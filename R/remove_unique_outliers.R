#' Remove unique outliers from raster files
#'
#' @description
#'
#' `remove_unique_outliers()` removes unique outliers from raster files
#' ([GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) or
#' [Esri ASCII](https://en.wikipedia.org/wiki/Esri_grid) raster format) based
#' on the interquartile range
#' ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)).
#'
#' This function processes each raster file by reading its values, identifying
#' unique outliers using the [`unique_outliers()`][unique_outliers()] function,
#' and replacing those outlier values with `NA`. The modified raster is then
#' saved back to the same file, effectively overwriting the original data.
#'
#' **Note:** This function requires the [`fs`](https://fs.r-lib.org/) package to
#' be installed.
#'
#' @param file A [`character`][base::character()] vector with the file paths of
#'   the raster files to be processed. Supported file formats are
#'   [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF)
#'   (`.tif` or `.tiff`) and
#'   [Esri ASCII](https://en.wikipedia.org/wiki/Esri_grid) raster (`.asc`).
#' @param n_iqr (optional) A number specifying the multiplier of the
#'   interquartile range
#'   ([IQR](https://en.wikipedia.org/wiki/Interquartile_range))
#'   to define outliers. See [`unique_outliers()`][unique_outliers()]
#'   to learn more (default: `1.5`).
#'
#' @return An invisible `NULL` value. This function is used for its side
#'   effects.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(readr)
#' library(terra)
#'
#' # Create a Fictional Esri ASCII File -----
#'
#' asc_content <- c(
#'   "ncols         5",
#'   "nrows         5",
#'   "xllcorner     0.0",
#'   "yllcorner     0.0",
#'   "cellsize      1.0",
#'   "NODATA_value  -9999",
#'   "1 2 3 4 5",
#'   "6 7 8 9 10",
#'   "11 12 1000 14 15", # Extreme outlier (1000)
#'   "16 1 18 19 20",
#'   "21 22 23 24 25"
#' )
#'
#' temp_file <- tempfile(fileext = ".asc")
#'
#' asc_content |> write_lines(temp_file)
#'
#' # Visualize Values Before `remove_unique_outliers()` -----
#'
#' temp_file |> rast() |> values(mat = FALSE)
#'
#' # Visualize Values After `remove_unique_outliers()` -----
#'
#' temp_file |> remove_unique_outliers()
#'
#' temp_file |> rast() |> values(mat = FALSE)
remove_unique_outliers <- function(file, n_iqr = 1.5) {
  require_pkg("fs", "stats")

  file_extension_choices <- c("tif", "tiff", "asc")

  checkmate::assert_character(file, min.len = 1)
  checkmate::assert_file_exists(file, access = "rw")

  for (i in file) {
    checkmate::assert_choice(fs::path_ext(file), file_extension_choices)
  }

  checkmate::assert_number(n_iqr, lower = 0)

  if (fs::path_ext(file) %in% c("tif", "tiff")) {
    file |> lapply(remove_unique_outliers.tiff, n_iqr = n_iqr)
  } else if (fs::path_ext(file) == "asc") {
    file |> lapply(remove_unique_outliers.asc, n_iqr = n_iqr)
  }

  invisible()
}

remove_unique_outliers.tiff <- function(file, n_iqr = 1.5) {
  require_pkg("fs", "stats")

  checkmate::assert_string(file)
  checkmate::assert_file_exists(file, access = "rw")
  checkmate::assert_choice(fs::path_ext(file), c("tif", "tiff"))
  checkmate::assert_number(n_iqr, lower = 0)

  data <- file |> terra::rast()

  if (terra::nlyr(data) > 1) {
    cli::cli_alert_info(
      paste0(
        "The file {.strong {basename(file)}} has ",
        "{.strong {terra::nlyr(data)}} layers. ",
        "Only the first layer will be processed."
      )
    )
  }

  data <- data[[1]]

  values <- data |> terra::values(mat = FALSE)

  if (length(stats::na.omit(values)) < 4) {
    cli::cli_alert_warning(
      paste0(
        "The file {.strong {basename(file)}} has less than 4 non-NA values. ",
        "No outlier removal was performed."
      )
    )
  } else {
    outliers <- unique_outliers(values, n_iqr)

    values[values %in% outliers] <- NA

    terra::values(data) <- values

    data |>
      terra::writeRaster(
        filename = file,
        overwrite = TRUE
      )
  }

  invisible()
}

remove_unique_outliers.asc <- function(file, n_iqr = 1.5) {
  require_pkg("fs", "stats")

  checkmate::assert_string(file)
  checkmate::assert_file_exists(file, access = "rw")
  checkmate::assert_choice(fs::path_ext(file), "asc")
  checkmate::assert_number(n_iqr, lower = 0)

  asc_data <- file |> readr::read_lines()
  header <- asc_data[1:6]

  if (
    !stringr::str_detect(header[6], "NODATA_value") ||
      !stringr::str_detect(header[2], "nrows")
  ) {
    cli::cli_abort(
      paste0(
        "The file {.strong {basename(file)}} does not appear to be a valid ",
        "Esri ASCII raster file."
      )
    )
  }

  nrows <- header[2] |> stringr::str_extract("[\\d]+") |> as.integer()
  nodata_value <- header[6] |> stringr::str_extract("[-\\d]+") |> as.numeric()

  data <-
    asc_data[-(1:6)] |>
    strsplit(" ") |>
    unlist() |>
    as.numeric()

  if (!checkmate::test_int(length(data) / nrows)) {
    cli::cli_abort(
      paste0(
        "The file {.strong {basename(file)}} does not appear to be a valid ",
        "Esri ASCII raster file."
      )
    )
  }

  if (length(stats::na.omit(data)) < 4) {
    cli::cli_alert_warning(
      paste0(
        "The file {.strong {basename(file)}} has less than 4 non-NA values. ",
        "No outlier removal was performed."
      )
    )
  } else {
    outliers <- unique_outliers(data, n_iqr)

    data[data %in% outliers] <- nodata_value

    data <-
      data |>
      split(cut(seq_along(data), nrows, labels = FALSE)) |>
      lapply(\(x) paste0(paste(x, collapse = " "), " ")) |>
      unlist(use.names = FALSE)

    c(header, data) |> readr::write_lines(file)
  }

  invisible()
}
