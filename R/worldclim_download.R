#' Download WorldClim data
#'
#' @description
#'
#' `worldclim_download()` downloads and unzips data from the
#' [WorldClim](https://worldclim.org/) website.
#'
#' See [`worldclim_global()`][geodata::worldclim_global()],
#' [`worldclim_country()`][geodata::worldclim_country()], and
#' [`worldclim_tile()`][geodata::worldclim_tile()] from the
#' [geodata](https://cran.r-project.org/package=geodata) package for
#' alternative ways to download WorldClim data.
#'
#' **Note:** This function requires an active internet connection and the
#' [`curl`](https://CRAN.R-project.org/package=curl),
#' [`fs`](https://CRAN.R-project.org/package=fs),
#' [`httr2`](https://CRAN.R-project.org/package=httr2),
#' [`rvest`](https://CRAN.R-project.org/package=rvest), and
#' [`zip`](https://CRAN.R-project.org/package=zip) packages to be
#' installed.
#'
#' @param series A [`character`][base::character()] string with the name of the
#'   WorldClim data series. The following options are available:
#'   - `"hcd"` = Historical Climate Data
#'   - `"hmwd"` = Historical Monthly Weather Data
#'   - `"fcd"` = Future Climate Data
#' @param dir A [`character`][base::character()] string specifying the directory
#'   where to save the downloaded files (default: `here::here("data")`).
#' @param timeout A [`numeric`][base::numeric()] value specifying the timeout
#'   (in seconds) for requests (default: `100`).
#' @param max_tries A [`numeric`][base::numeric()] value specifying the maximum
#'   number of retry attempts (default: `3`).
#' @param retry_on_failure A [`logical`][base::logical()] value indicating
#'   whether to retry on failure (default: `TRUE`).
#'
#' @return An invisible [`character`][base::character()] vector with the file
#'   path(s) of the downloaded data.
#'
#' @template params_worldclim_a
#' @family WorldClim functions
#' @export
#'
#' @examples
#' \dontrun{
#'   if (FALSE) {
#'     worldclim_download(
#'       series = "hcd",
#'       resolution = "10m",
#'       variable = "prec"
#'     )
#'   }
#' }
#'
#' \dontrun{
#'   if (FALSE) {
#'     worldclim_download(
#'       series = "fcd",
#'       resolution = "10m",
#'       variable = "tmin",
#'       model = "ACCESS-CM2",
#'       ssp = "ssp245",
#'       year = "2041-2060"
#'     )
#'   }
#' }
worldclim_download <- function(
  series,
  resolution = NULL,
  variable = NULL,
  model = NULL,
  ssp = NULL,
  year = NULL,
  dir = here::here("data"),
  timeout = 100,
  max_tries = 3,
  retry_on_failure = TRUE
) {
  require_pkg("curl", "fs", "httr2", "rvest", "zip")

  assert_internet()
  checkmate::assert_string(series)
  checkmate::assert_string(resolution)
  checkmate::assert_path_for_output(dir, overwrite = TRUE)
  checkmate::assert_number(timeout, lower = 1)
  checkmate::assert_number(max_tries, lower = 1)
  checkmate::assert_flag(retry_on_failure)

  # R CMD Check variable bindings fix
  # nolint start
  . <- size <- NULL
  # nolint end

  dir_series <- fs::path(dir, worldclim_normalize_series(series, type = 2))
  dirs <- c(dir, dir_series)

  for (i in dirs) {
    if (!fs::dir_exists(i)) fs::dir_create(i, recurse = TRUE)
  }

  cli::cli_progress_step("Scraping WorldClim Website")

  urls <- worldclim_file(
    series = series,
    resolution = resolution,
    variable = variable,
    model = model,
    ssp = ssp,
    year = year
  )

  cli::cli_progress_step("Calculating File Sizes")

  for (i in seq_len(3)) {
    metadata <-
      dplyr::tibble(
        file = basename(urls),
        url = urls,
        size = urls |>
          purrr::map_dbl(
            get_file_size,
            timeout = timeout
          )
      ) |>
      dplyr::arrange(size) |>
      dplyr::mutate(
        size_cum_sum = size |>
          tidyr::replace_na() |>
          cumsum() |>
          fs::as_fs_bytes()
      )

    if (!any(is.na(metadata$size))) break
  }

  if (any(is.na(metadata$size))) {
    cli::cli_abort(
      paste0(
        "{.strong {cli::col_red('worldclim_download()')}} ",
        "encountered issues when trying to get the size of one or more ",
        "files. This may be due to temporary issues with the WorldClim ",
        "website or your internet connection.",
      )
    )
  }

  cli::cli_alert_info(
    paste0(
      "Total download size (compressed): ",
      "{.strong {cli::col_red(",
      "metadata |> dplyr::pull(size_cum_sum) |> dplyr::last()",
      ")}}."
    )
  )

  if (count_na(metadata$size) != 0) {
    cli::cli_alert_warning(
      paste0(
        "{.strong {cli::col_red(count_na(metadata$size))}} ",
        "url requests resulted in error."
      )
    )
  }

  if (count_na(metadata$size) > 0) {
    cli::cli_alert_info("Their file names are:")
    cli::cli_li(metadata$file[is.na(metadata$size)])
  }

  cli::cli_progress_step("Creating LICENSE and README Files")

  for (i in dirs) {
    worldclim_download.license() |>
      readr::write_lines(fs::path(i, "LICENSE.md"))
  }

  worldclim_download.readme() |>
    readr::write_lines(fs::path(dir, "README.md"))

  worldclim_download.readme(series) |>
    readr::write_lines(fs::path(dir_series, "README.md"))

  cli::cli_progress_step("Downloading Files")

  metadata |> dplyr::pull(url) |> download_file(dir = dir_series)

  cli::cli_progress_step("Unzipping Files")

  if (any(stringr::str_detect(metadata$file, ".zip$"))) {
    zip_files <-
      fs::path(dir_series, metadata$file) |>
      stringr::str_subset(".zip$")

    for (i in zip_files) {
      cli::cli_progress_bar(
        name = "Unzipping data",
        total = length(zip_files),
        clear = FALSE
      )

      if (fs::file_exists(i)) {
        i |> zip::unzip(overwrite = TRUE, exdir = dir_series)

        cli::cli_progress_update()
      }

      cli::cli_progress_done()
    }

    zip_files |> fs::file_delete()
  }

  dir_series |>
    fs::dir_ls(type = "file", glob = "*.tif") |>
    invisible()
}

worldclim_download.license <- function() {
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
    "2026-01-12."
  )
}

worldclim_download.readme <- function(series = NULL, resolution = NULL) {
  if (!is.null(series) && !is.null(resolution)) {
    source <- worldclim_url(series, resolution)
  } else {
    source <- "https://www.worldclim.org"
  }

  if (!is.null(series)) {
    checkmate::assert_choice(
      if (!is.null(series)) series |> tolower(),
      worldclim_variables |> magrittr::extract2("series_choices")
    )
    series <- series |> worldclim_normalize_series()
    series_names <- worldclim_variables |> magrittr::extract2("series")

    series <-
      series_names |>
      magrittr::extract(match(series, series_names)) |>
      names()
  }

  if (!is.null(resolution)) {
    checkmate::assert_choice(
      if (!is.null(resolution)) resolution |> tolower(),
      worldclim_variables |> magrittr::extract2("resolution_choices"),
      null.ok = TRUE
    )

    resolution <-
      resolution |>
      stringr::str_replace_all("m$", " minutes") |>
      stringr::str_replace("^30s$", "30 seconds")
  } else {
    if (!is.null(series)) {
      if (series == "Historical Monthly Weather Data") {
        resolution <- "10m, 5m, and 2.5m"
      } else {
        resolution <- "10m, 5m, 2.5m, and 30s"
      }
    }
  }

  paste0(
    "# WorldClim 2.1",
    "\n\n",
    ifelse(!is.null(series), paste0("- Series: ", series, "\n"), ""),
    ifelse(
      !is.null(resolution),
      paste0("- Resolution: ", resolution, "\n"),
      ""
    ),
    ifelse(!is.null(source), paste0("- Source: <", source, ">", "\n"), ""),
    "- Note: Downloaded on ",
    Sys.Date(),
    "\n\n",
    "> This dataset is licensed under the WorldClim 2.1 Terms of Use, ",
    "available at: <https://worldclim.org/about.html>."
  )
}
