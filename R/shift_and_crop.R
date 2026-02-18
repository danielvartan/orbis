#' Shift, rotate, and crop a SpatVector or a SpatRaster
#'
#' @description
#'
#' `shift_and_crop()` shifts and rotates a [`SpatRaster`][terra::SpatRaster] by
#' a specified horizontal distance, then crops it to the extent of a
#' [`SpatVector`][terra::SpatVector] that has been similarly transformed.
#'
#' This function is particularly useful for working with rasters and vectors
#' that span the
#' [International Date Line](
#' https://en.wikipedia.org/wiki/International_Date_Line)
#' (e.g. the Russian territory).
#'
#' @param raster A [`SpatRaster`][terra::SpatRaster] object to be shifted,
#'   rotated, and cropped.
#' @param vector A [`SpatVector`][terra::SpatVector] object to be shifted
#'   and rotated.
#' @param ... Additional arguments passed to [`crop()`][terra::crop()].
#'
#' @return A [`SpatRaster`][terra::SpatRaster] object that has been shifted
#'   and rotated by the specified amount in degrees, then cropped to the extent
#'   of the provided vector.
#'
#' @inheritParams shift_and_rotate
#' @family terra functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(httr2)
#' library(dplyr)
#' library(geodata)
#' library(ggplot2)
#' library(terra)
#' library(tidyterra)
#'
#' plot_vector <- function(vector) {
#'   plot <-
#'     vector |>
#'     ggplot() +
#'     geom_spatvector(fill = "#3243A6", color = "white")
#'
#'   print(plot)
#' }
#'
#' plot_raster <- function(raster) {
#'   plot <-
#'     ggplot() +
#'     geom_spatraster(data = raster) +
#'     scale_fill_continuous(
#'       palette = c("#072359", "#3243A6", "#9483AF"),
#'       na.value = "white"
#'     ) +
#'     labs(fill = NULL)
#'
#'   print(plot)
#' }
#'
#' # Define the SpatVector -----
#'
#' \dontrun{
#'   if (is_online()) {
#'     russia_vector <- gadm(country = "rus", level = 0, path = tempdir())
#'
#'     russia_vector |> plot_vector()
#'   }
#' }
#'
#' # Define the SpatRaster -----
#'
#' \dontrun{
#'   if (is_online()) {
#'     raster <-
#'       expand.grid(
#'         seq(-179.75, 179.75, by = 0.5),
#'         seq(-89.75, 89.75, by = 0.5)
#'       ) |>
#'       as_tibble() |>
#'       rename(x = Var1, y = Var2) |>
#'       mutate(value = rnorm(259200)) |>
#'       rast(type = "xyz") %>%
#'       `crs<-`("epsg:4326")
#'
#'     world_shape <- world(path = tempdir())
#'
#'     raster <- raster |> crop(world_shape, mask = TRUE)
#'   }
#' }
#'
#' # Visualize the SpatRaster -----
#'
#' \dontrun{
#'   if (is_online()) {
#'     raster |> plot_raster()
#'   }
#' }
#'
#' # Shift, Rotate and Crop the SpatRaster -----
#'
#' \dontrun{
#'   if (is_online()) {
#'     raster <- raster |> shift_and_crop(russia_vector, -45)
#'   }
#' }
#'
#' # Visualize the SpatRaster After Shift and Crop -----
#'
#' \dontrun{
#'   if (is_online()) {
#'     raster |> plot_raster()
#'   }
#' }
shift_and_crop <- function(
  raster,
  vector,
  dx = -45,
  precision = 5,
  overlap_tolerance = 0.1,
  ...
) {
  checkmate::assert_class(raster, "SpatRaster")
  checkmate::assert_class(vector, "SpatVector")
  checkmate::assert_number(dx)
  checkmate::assert_number(precision, lower = 0, upper = 10)
  checkmate::assert_number(overlap_tolerance, lower = 0, upper = 1)

  if (any(c("mask", "touches", "extend") %in% names(list(...)), na.rm = TRUE)) {
    cli::cli_abort(
      paste0(
        "The arguments {.strong {cli::col_red('mask')}},
        {.strong {cli::col_red('touches')}}, and
        {.strong {cli::col_red('extend')}} ",
        "are reserved for the {.strong shift_and_crop} function."
      )
    )
  }

  raster <- raster |> shift_and_rotate(dx, precision, overlap_tolerance)
  vector <- vector |> shift_and_rotate(dx, precision, overlap_tolerance)

  raster |>
    terra::crop(
      vector,
      mask = TRUE,
      touches = TRUE,
      extend = TRUE,
      ...
    )
}
