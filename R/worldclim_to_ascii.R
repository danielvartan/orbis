#' Convert WorldClim GeoTIFF files to Esri ASCII Grid
#'
#' @description
#'
#' `worldclim_to_ascii()` facilitates the conversion of one or more
#' [WorldClim](https://worldclim.org/)
#' [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to the
#' [Esri ASCII Grid](https://en.wikipedia.org/wiki/Esri_grid) raster format.
#'
#' @details
#'
#' ## `na_flag` parameter
#'
#' According to the [Esri ASCII](https://en.wikipedia.org/wiki/Esri_grid)
#' raster format documentation, the default value for `NODATA_VALUE`
#' (the `NA` flag) is `-9999`. However, using four digits of precision
#' significantly inflates file size. For
#' [WorldClim](https://worldclim.org/) data, two significant digits (`-99`) are
#' sufficient, since the only variables with negative values are temperatures,
#' and the lowest temperature ever recorded on Earth is above that threshold.
#'
#' @param file A [`character`][base::character()] vector of file paths to the
#'   [WorldClim](https://worldclim.org/)
#'   [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to be converted.
#'   The files must have a `.tif` extension.
#' @param shape (optional) An [`sf`][sf::st_sf()] or
#'   [`SpatVector`][terra::vect()] class object representing the polygon to crop
#'   the raster data (default: `NULL`).
#' @param box (optional) A [`numeric`][base::numeric()] vector of length 4
#'   specifying the bounding box for cropping the raster data in the format
#'   `c(xmin, ymin, xmax, ymax)` (default: `NULL`).
#' @param shift_longitude (optional) A [`logical`][base::logical()] flag
#'   indicating whether to apply a date line fix to the raster data when
#'   the shape parameter is provided and spans the
#'   [International Date Line](
#'   https://en.wikipedia.org/wiki/International_Date_Line).
#'   This is particularly useful when working with rasters and vectors that span
#'   the date line (e.g. the Russian territory). See
#'   [`shift_and_rotate()`][shift_and_rotate()] to learn more (default: `TRUE`).
#' @param dx (optional) A [`numeric`][base::numeric()] value specifying the
#'   horizontal distance in degrees to shift the raster data. This is only
#'   relevant if `shift_longitude` is set to `TRUE` (default: `-45`).
#' @param remove_extreme_outliers (optional) A [`logical`][base::logical()] flag
#'   indicating whether to transform to `NA` values 10 times the interquartile
#'   range ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)) below the
#'   first quartile or above the third quartile of the data values without
#'   duplications. This is useful to remove abnormal values in the raster data
#'   (default: `FALSE`).
#' @param overwrite (optional) A [`logical`][base::logical()] flag indicating
#'   whether to overwrite existing files in the output directory
#'   (default: `TRUE`).
#' @param na_flag (optional) An [`integer`][base::integer()] value specifying
#'   the `NODATA_VALUE` for the output ASCII files. See the *Details* section
#'   to learn more (default: `-99`).
#' @param dir (optional) A [`character`][base::character()] vector specifying
#'   the output directory for the converted
#'   [Esri ASCII Grid](https://en.wikipedia.org/wiki/Esri_grid)
#'   files. Defaults to the directory of the first file in the `file` parameter
#'   (default: `dirname(file[1])`).
#'
#' @return An invisible [`character`][base::character()] vector containing the
#'   file paths of the converted ASCII files.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(curl)
#' library(fs)
#' library(httr2)
#' library(magrittr)
#' library(readr)
#' library(rvest)
#' library(zip)
#'
#' # Download a WorldClim Dataset -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     tif_file <-
#'       worldclim_download(
#'         series = "hcd",
#'         resolution = "10m",
#'         variable = "prec",
#'         dir = tempdir()
#'       ) |>
#'         magrittr::extract(1)
#'   }
#' }
#'
#' # Transform Data to Esri ASCII -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     asc_file <- tif_file |> worldclim_to_ascii()
#'   }
#' }
#'
#' # Check the Output -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     asc_file |> read_lines(n_max = 11)
#'   }
#' }
worldclim_to_ascii <- function(
  file,
  shape = NULL,
  box = NULL,
  shift_longitude = TRUE,
  dx = -45,
  remove_extreme_outliers = TRUE,
  overwrite = TRUE,
  na_flag = -99,
  dir = dirname(file[1])
) {
  require_pkg("stats")

  checkmate::assert_character(file)
  checkmate::assert_file_exists(file, access = "r", extension = "tif")
  checkmate::assert_directory_exists(dir, access = "rw")
  checkmate::assert_class(shape, "SpatVector", null.ok = TRUE)
  checkmate::assert_numeric(box, len = 4, null.ok = TRUE)
  checkmate::assert_flag(shift_longitude)
  checkmate::assert_number(dx, finite = TRUE)
  checkmate::assert_flag(remove_extreme_outliers)
  checkmate::assert_flag(overwrite)
  checkmate::assert_int(na_flag)

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  if (!is.null(shape)) {
    if (!terra::is.polygons(shape)) {
      cli::cli_abort(
        paste0(
          "{.strong {cli::col_red('shape')}} must be a polygon ",
          "of class {.strong SpatVector}. ",
          "See the {.strong terra} R package for more details."
        )
      )
    }
  }

  if (!is.null(shape)) {
    needs_rotation <-
      isTRUE(shift_longitude) && isTRUE(test_date_line(shape))

    if (needs_rotation) {
      cli::cli_progress_step(
        "Applying date line fix to {.strong {cli::col_blue('shape')}}"
      )

      shape <- shape |> shift_and_rotate(dx = dx)
    }
  }

  cli::cli_progress_bar(
    name = "Converting data",
    total = length(file),
    clear = FALSE
  )

  out <- character()

  for (i in file) {
    asc_file <-
      stringr::str_replace(i, "(?i)tif$", "asc") |>
      basename() %>%
      file.path(dir, .) |>
      adjust_hcd_file_name()

    data_i <- i |> terra::rast()

    terra::crs(data_i) <- "EPSG:4326"

    if (!is.null(shape)) {
      if (needs_rotation) {
        cli::cli_progress_step(
          "Applying date line fix to {.strong {cli::col_blue(i)}}"
        )

        data_i <- data_i |> shift_and_rotate(dx = dx)
      }
    }

    if (!is.null(shape)) {
      terra::crs(shape) <- "EPSG:4326"

      data_i <-
        data_i |>
        terra::crop(
          shape,
          snap = "out",
          mask = TRUE,
          touches = TRUE,
          extend = TRUE
        )
    }

    if (!is.null(box)) {
      data_i <- data_i |> terra::crop(box)
    }

    asc_file <- asc_file |> adjust_fcd_file_name(data_i)

    data_i |>
      terra::writeRaster(
        filename = asc_file,
        overwrite = overwrite,
        datatype = "FLT4S",
        filetype = "AAIGrid",
        NAflag = na_flag,
        verbose = FALSE
      )

    if (isTRUE(remove_extreme_outliers)) {
      remove_unique_outliers(asc_file, 10)
    }

    out <- c(out, asc_file)

    cli::cli_progress_update()
  }

  invisible(out)
}

adjust_hcd_file_name <- function(asc_file) {
  checkmate::assert_string(asc_file)

  # To adjust `historical-climate-data bioclimatic` files.
  if (!stringr::str_detect(asc_file, "[0-9]{4}")) {
    if (stringr::str_detect(asc_file, "(?i)_bio_")) {
      asc_file <- asc_file |> stringr::str_replace("(?i)_bio_", "_bioc_")

      if (!stringr::str_detect(asc_file, "[0-9]{2}\\.asc$")) {
        asc_file <- paste0(
          stringr::str_extract(asc_file, ".*(?=[0-9]{1}\\.asc)"),
          "0",
          stringr::str_extract(asc_file, "[0-9]{1}\\.asc$")
        )
      }

      paste0(
        stringr::str_extract(asc_file, ".*(?=[0-9]{2}\\.asc)"),
        "1970-2000_",
        stringr::str_extract(asc_file, "[0-9]{2}\\.asc$")
      )
    } else if (stringr::str_detect(asc_file, "_[0-9]{2}\\.asc$")) {
      paste0(
        stringr::str_extract(asc_file, ".*(?=[0-9]{2}\\.asc)"),
        "1970-2000-",
        stringr::str_extract(asc_file, "[0-9]{2}\\.asc$")
      )
    } else {
      paste0(
        stringr::str_extract(asc_file, ".*(?=\\.asc)"),
        "_1970-2000.asc"
      )
    }
  } else {
    asc_file
  }
}

adjust_fcd_file_name <- function(asc_file, data_i) {
  checkmate::assert_character(asc_file)
  checkmate::assert_class(data_i, "SpatRaster")

  if (!length(names(data_i)) == 1) {
    if (stringr::str_detect(names(data_i)[1], "^bio")) {
      suffix <- "_"
    } else {
      suffix <- "-"
    }

    paste0(
      stringr::str_extract(asc_file, ".*(?=.asc)"),
      suffix,
      stringr::str_extract(names(data_i), "[0-9]{1,2}$"),
      ".asc"
    )
  } else {
    asc_file
  }
}
