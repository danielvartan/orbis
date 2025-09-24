#' Convert WorldClim GeoTIFF files to ASCII format
#'
#' @description
#'
#' `wc_to_ascii()` facilitates the conversion of one or more
#' [WorldClim](https://worldclim.org/)
#' [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to the [Esri ASCII
#' Grid](https://en.wikipedia.org/wiki/Esri_grid) raster format. Optionally,
#' rasters can be cropped and/or aggregated using a provided polygon of class
#' [`SpatVector`][terra::SpatVector-class].
#'
#' @details
#'
#' ## `na_flag` parameter
#'
#' According to the Esri ASCII raster format documentation, the default value
#' for `NODATA_VALUE` (the `NA` flag) is `-9999`. However, using four digits of
#' precision significantly inflates file size. For WorldClim data, two
#' significant digits (`-99`) are sufficient, since the only variables with
#' negative values are temperatures, and the lowest temperature ever recorded on
#' Earth is above that.
#'
#' @param file A [`character`][base::character()] vector of file paths to the
#'   WorldClim GeoTIFF files to be converted. The files must have a `.tif`
#'   extension.
#' @param dir A [`character`][base::character()] vector specifying the output
#'   directory for the converted ASCII files (default: `dirname(file[1])`).
#' @param shape (optional) A [`SpatVector`][terra::SpatVector-class] object
#'   representing the polygon to crop the raster data. The function will crop
#'   the raster data to the extent of this polygon (default: `NULL`).
#' @param box (optional) A [`numeric`][base::numeric()] vector of length 4
#'   specifying the bounding box for cropping the raster data in the format
#'   `c(xmin, ymin, xmax, ymax)` (default: `NULL`).
#' @param dateline_fix (optional) A [`logical`][base::logical()] flag indicating
#'   whether to apply a dateline fix to the raster data. This is particularly
#'   useful when working with rasters and vectors that span the dateline (e.g.
#'   the Russian territory). See [`shift_and_crop`] to learn more
#'   (default: `TRUE`).
#' @param aggregate (optional) An [`integer`][base::integer()] value specifying
#'   the aggregation factor. The function will aggregate the raster data by this
#'   factor. See [`aggregate()`][terra::aggregate()] for more details
#'   (default: `NULL`).
#' @param overwrite (optional) A [`logical`][base::logical()] flag indicating
#'   whether to overwrite existing files in the output directory
#'   (default: `TRUE`).
#' @param dx (optional) A [`numeric`][base::numeric()] value specifying the
#'   horizontal distance in degrees to shift the raster data. This is only
#'   relevant if `dateline_fix` is set to `TRUE` (default: `-45`).
#' @param na_flag (optional) An [`integer`][base::integer()] value specifying
#'   the NoData value for the output ASCII files. See the *Details* section
#'   to learn more (default: `-99`).
#' @param ... Additional arguments passed to
#'   [`writeRaster()`][terra::writeRaster()] for writing the ASCII files.
#'
#' @return A [`character`][base::character()] vector containing the file paths
#'   of the converted ASCII files.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' \dontrun{
#'   library(curl)
#'   library(fs)
#'   library(magrittr)
#'   library(readr)
#'   library(rvest)
#'   library(stringr)
#'   library(zip)
#'
#'   # Download the WorldClim Data
#'
#'   url <-
#'     get_wc_url("hcd") |>
#'     rvest::read_html() |>
#'     rvest::html_elements("a") |>
#'     rvest::html_attr("href") |>
#'     stringr::str_subset("geodata") |>
#'     magrittr::extract(1)
#'
#'   zip_file <- basename(url)
#'
#'   curl::curl_download(url, path(tempdir(), zip_file))
#'
#'   path(tempdir(), zip_file) |>
#'     zip::unzip(exdir = tempdir())
#'
#'   tif_file <-
#'     dir_ls(tempdir(), regexp = "\\.tif$") |>
#'     magrittr::extract(1)
#'
#'   # Run the Function
#'
#'   asc_file <- tif_file |> wc_to_ascii()
#'
#'   # Check the Output
#'
#'   asc_file |> read_lines(n_max = 6)
#' }
wc_to_ascii <- function(
  file,
  dir = dirname(file[1]),
  shape = NULL,
  box = NULL,
  dateline_fix = TRUE,
  aggregate = NULL,
  overwrite = TRUE,
  dx = -45,
  na_flag = -99,
  ...
) {
  checkmate::assert_character(file)
  checkmate::assert_file_exists(file, access = "r", extension = "tif")
  checkmate::assert_class(shape, "SpatVector", null.ok = TRUE)
  checkmate::assert_numeric(box, len = 4, null.ok = TRUE)
  checkmate::assert_flag(dateline_fix)
  checkmate::assert_int(aggregate, null.ok = TRUE)
  checkmate::assert_directory_exists(dir, access = "rw")
  checkmate::assert_flag(overwrite)
  checkmate::assert_number(dx, finite = TRUE)
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
    if (isTRUE(dateline_fix) && isTRUE(test_dateline(shape))) {
      cli::cli_progress_step(
        "Applying dateline fix to {.strong {cli::col_blue('shape')}}."
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
      file.path(dir, .)

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

        asc_file <- paste0(
          stringr::str_extract(asc_file, ".*(?=[0-9]{2}\\.asc)"),
          "1970-2000_",
          stringr::str_extract(asc_file, "[0-9]{2}\\.asc$")
        )
      } else if (stringr::str_detect(asc_file, "_[0-9]{2}\\.asc$")) {
        asc_file <- paste0(
          stringr::str_extract(asc_file, ".*(?=[0-9]{2}\\.asc)"),
          "1970-2000-",
          stringr::str_extract(asc_file, "[0-9]{2}\\.asc$")
        )
      } else {
        asc_file <- paste0(
          stringr::str_extract(asc_file, ".*(?=\\.asc)"),
          "_1970-2000.asc"
        )
      }
    }

    data_i <- i |> terra::rast()

    if (!is.null(shape)) {
      if (isTRUE(dateline_fix) && isTRUE(test_dateline(shape))) {
        data_i <- data_i |> shift_and_rotate(dx = dx)
      }

      data_i <-
        data_i |>
        terra::crop(
          shape,
          snap = "near",
          mask = TRUE,
          touches = TRUE,
          extend = TRUE
        )
    }

    if (!is.null(box)) data_i <- data_i |> terra::crop(box)

    if (!is.null(aggregate)) {
      data_i <- data_i |> terra::aggregate(fact = aggregate)
    }

    # To adjust `future-climate-data` files.
    if (!length(names(data_i)) == 1) {
      if (stringr::str_detect(names(data_i)[1], "^bio")) {
        suffix <- "_"
      } else {
        suffix <- "-"
      }

      asc_file <- paste0(
        stringr::str_extract(asc_file, ".*(?=.asc)"),
        suffix,
        stringr::str_extract(names(data_i), "[0-9]{1,2}$"),
        ".asc"
      )
    }

    data_i |>
      terra::writeRaster(
        filename = asc_file,
        overwrite = overwrite,
        NAflag = na_flag,
        verbose = FALSE,
        ...
      )

    out <- c(out, asc_file)

    cli::cli_progress_update()
  }

  out
}
