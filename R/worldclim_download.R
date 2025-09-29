worldclim_download <- function(
  series = "historical-climate-data",
  resolution = "10m",
  model = NULL,
  dir = here::here("data-raw")
) {
  require_pkg("curl", "fs", "httr", "rvest", "zip")

  series_choices <- c(
    "hcd", "historical-climate-data", "historical climate data",
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data",
    "fcd", "future-climate-data", "future climate data"
  )

  resolution_choices <- c("10m", "5m", "2.5m", "30s")

  model_choices <- c(
    "access-cm2", "bcc-csm2-mr", "cmcc-esm2", "ec-earth3-veg", "fio-esm-2-0",
    "gfdl-esm4", "giss-e2-1-g", "hadgem3-gc31-ll", "inm-cm5-0", "ipsl-cm6a-lr",
    "miroc6", "mpi-esm1-2-hr", "mri-esm2-0", "ukesm1-0-ll"
  )

  checkmate::assert_choice(tolower(series), series_choices)

  checkmate::assert_choice(
    tolower(resolution), resolution_choices, null.ok = TRUE
  )

  checkmate::assert_character(model, null.ok = TRUE)

  if (!is.null(model)) {
    for (i in model) checkmate::assert_choice(tolower(i), model_choices)
  }

  checkmate::assert_path_for_output(dir, overwrite = TRUE)

  # R CMD Check variable bindings fix
  # nolint start
  . <- size <- NULL
  # nolint end

  dir_series <- fs::path(dir, series)
  dir_res <- fs::path(
    dir_series,
    resolution |> stringr::str_replace_all("\\.", "\\-")
  )

  dirs <- c(dir, dir_series, dir_res)

  for (i in dirs) if (!fs::dir_exists(i)) fs::dir_create(i, recurse = TRUE)

  cli::cli_progress_step("Scraping WorldClim Website")

  html <- worldclim_url(series, resolution) |> rvest::read_html()

  urls <-
    html |>
    rvest::html_elements("a") |>
    rvest::html_attr("href") |>
    stringr::str_subset("geodata")

  if (!resolution == "all") {
    urls <-
      urls %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", resolution)
        )
      )
  }

  if (!is.null(model)) {
    urls <-
      urls %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", model, collapse = "|")
        )
      )
  }

  cli::cli_progress_step("Calculating File Sizes")

  metadata <-
    dplyr::tibble(
      file = basename(urls),
      url = urls,
      size = urls |> purrr::map_dbl(get_file_size) |> fs::as_fs_bytes()
    ) |>
    dplyr::arrange(size) |>
    dplyr::mutate(
      size_cum_sum =
        size |>
        tidyr::replace_na() |>
        cumsum() |>
        fs::as_fs_bytes()
    )

  cli::cli_alert_info(
    paste0(
      "Total download size (compressed): ",
      "{.strong {cli::col_red(",
      "metadata |> dplyr::pull(size_cum_sum) |> dplyr::last()",
      ")}}."
    )
  )

  cli::cli_alert_info(
    paste0(
      "{.strong {cli::col_red(count_na(metadata$size))}} ",
      "url requests resulted in error."
    )
  )

  if (count_na(metadata$size) > 0) {
    cli::cli_alert_info("Their file names are:")
    cli::cli_li(metadata$file[is.na(metadata$size)])
  }

  cli::cli_progress_step("Creating LICENSE and README Files")

  dirs <- c(dir, dir_series, dir_res)

  for (i in dirs) {
    worldclim_download_license() |>
      readr::write_lines(fs::path(i, "LICENSE.md"))
  }

  worldclim_download_readme() |>
    readr::write_lines(fs::path(dir, "README.md"))

  worldclim_download_readme(series) |>
    readr::write_lines(fs::path(dir_series, "README.md"))

  worldclim_download_readme(series, resolution) |>
    readr::write_lines(fs::path(dir_res, "README.md"))

  cli::cli_progress_step("Downloading Files")

  metadata |> dplyr::pull(url) |> download_file(dir = dir_res)

  cli::cli_progress_step("Unzipping Files")

  if (any(stringr::str_detect(metadata$file, ".zip$"))) {
    zip_files <-
      fs::path(dir_res, metadata$file) |>
      stringr::str_subset(".zip$")

    for (i in zip_files) {
      cli::cli_progress_bar(
        name = "Unzipping data",
        total = length(zip_files),
        clear = FALSE
      )

      if (fs::file_exists(i)) {
         i |> zip::unzip(overwrite = TRUE, exdir = dir_res)

        cli::cli_progress_update()
      }

      cli::cli_progress_done()
    }

    zip_files |> fs::file_delete()
  }

  invisible(metadata)
}

# # Helpers -----
#
# worldclim_download_license() |> cat()

worldclim_download_license <- function() {
  paste0(
    "# WorldClim 2.1",
    "\n\n",
    long_string(
      "
      The data are freely available for academic use and other non-commercial
      use. Redistribution or commercial use is not allowed without prior
      permission. Using the data to create maps for publishing of academic
      research articles is allowed. Thus you can use the maps you made with
      WorldClim data for figures in articles published by PLoS, Springer
      Nature, Elsevier, MDPI, etc. You are allowed (but not required) to
      publish these articles (and the maps they contain) under an open
      license such as CC-BY as is the case with PLoS journals and may be the
      case with other open access articles.
      "
    ),
    "\n\n",
    "Please send your questions to <info@worldclim.org>.",
    "\n\n",
    "> Extracted from <https://worldclim.org/about.html> on ",
    "2025-06-06."
  )
}

# # Helpers -----
#
# worldclim_download_readme() |> cat()

worldclim_download_readme <- function(series = NULL, resolution = NULL) {
  series_choices <- c(
    "historical-climate-data",
    "historical-monthly-weather-data",
    "future-climate-data"
  )

  resolution_choices <- c("10m", "5m", "2.5m", "30s", "all")

  checkmate::assert_string(series, null.ok = TRUE)
  checkmate::assert_choice(series, series_choices, null.ok = TRUE)
  checkmate::assert_string(resolution, null.ok = TRUE)
  checkmate::assert_choice(resolution, resolution_choices, null.ok = TRUE)

  if (!is.null(series) && !is.null(resolution) && !resolution == "all") {
    source <- worldclim_url(series, resolution)
  } else {
    source <- "https://www.worldclim.org"
  }

  if (!is.null(series)) {
    series <-
      series |>
      stringr::str_replace_all("-", " ") |>
      stringr::str_to_title()
  }

  if (!is.null(resolution)) {
    if (resolution == "all") resolution <- "10m, 5m, 2.5m, and 30s"

    resolution <-
      resolution |>
      stringr::str_replace_all("m$", " minutes") |>
      stringr::str_replace("^30s$", "30 seconds")
  }

  paste0(
    "# WorldClim 2.1",
    "\n\n",
    ifelse(!is.null(series), paste0("- Series: ", series, "\n"), ""),
    ifelse(
      !is.null(resolution), paste0("- Resolution: ", resolution, "\n"), ""
    ),
    ifelse(!is.null(source), paste0("- Source: <", source, ">", "\n"), ""),
    "- Note: Downloaded on ", Sys.Date(),
    "\n\n",
    "> This dataset is licensed under the WorldClim 2.1 Terms of Use, ",
    "available at: <https://worldclim.org/about.html>."
  )
}
