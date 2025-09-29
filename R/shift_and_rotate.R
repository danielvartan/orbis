#' Shift and rotate a raster or a vector
#'
#' @description
#'
#' `shift_and_rotate()` shifts a raster or vector by a specified horizontal
#' distance and rotates the data around the dateline.
#'
#' This function is particularly useful for working with rasters and vectors
#' that span the dateline (e.g., the Russian territory).
#'
#' @param x A [`SpatRaster`][terra::SpatRaster] or
#'   [`SpatVector`][terra::SpatVector] object to be shifted and rotated.
#' @param dx A numeric value indicating the amount of the horizontal shift in
#'   degrees. Positive values shift to the right, negative values shift to the
#'   left (default: `-45`).
#' @param precision (optional) A numeric value specifying the number of decimal
#'   digits to use when rounding longitude and latitude coordinates
#'   (default: `5`).
#' @param overlap_tolerance (optional) A numeric value specifying the tolerance
#'   for overlapping geometries when combining vectors. This value controls the
#'   allowable error when merging overlapping geometries (default: `0.1`).
#'
#' @return A object of the same class as `x` that has been shifted and rotated
#'   by the specified amount in degrees.
#'
#' @family raster functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(curl)
#' library(dplyr)
#' library(geodata)
#' library(ggplot2)
#' library(magrittr)
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
#'     labs(fill = NULL) +
#'     theme(
#'       axis.ticks.x = element_blank(),
#'       axis.text.x = element_blank(),
#'       axis.ticks.y = element_blank(),
#'       axis.text.y = element_blank()
#'     )
#'
#'     print(plot)
#' }
#'
#' # Vector Example -----
#'
#' ## Define the Vector
#'
#' \dontrun{
#'   if (has_internet()) {
#'     russia_vector <- gadm(country = "rus", level = 0, path = tempdir())
#'   }
#' }
#'
#' ## Visualize the Vector
#'
#' \dontrun{
#'   if (has_internet()) {
#'     russia_vector |> plot_vector()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector -45 Degrees to the Left
#'
#' \dontrun{
#'   if (has_internet()) {
#'     russia_vector |> shift_and_rotate(-45) |> plot_vector()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector 45 Degrees to the Right
#'
#' \dontrun{
#'   if (has_internet()) {
#'     russia_vector |> shift_and_rotate(45) |> plot_vector()
#'   }
#' }
#'
#' # Raster Example -----
#'
#' ## Define the Raster
#'
#' \dontrun{
#'   if (has_internet()) {
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
#' ## Visualize the Raster
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector -45 Degrees to the Left
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(-45) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector -90 Degrees to the Left
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(-90) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector -135 Degrees to the Left
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(-135) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector -180 Degrees to the Left
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(-180) |> plot_raster()
#'   }
#' }
#'
#' ## Visualize the Raster
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector 45 Degrees to the Right
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(45) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector 90 Degrees to the Right
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(90) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector 135 Degrees to the Right
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(135) |> plot_raster()
#'   }
#' }
#'
#' ## Shift and Rotate the Vector 180 Degrees to the Right
#'
#' \dontrun{
#'   if (has_internet()) {
#'     raster |> shift_and_rotate(180) |> plot_raster()
#'   }
#' }
shift_and_rotate <- function(
  x,
  dx = -45,
  precision = 5,
  overlap_tolerance = 0.1
) {
  checkmate::assert_multi_class(x, c("SpatRaster", "SpatVector"))
  checkmate::assert_number(dx)
  checkmate::assert_number(precision, lower = 0, upper = 10)
  checkmate::assert_number(overlap_tolerance, lower = 0, upper = 1)

  x_min <- terra::ext(x)[1] |> round(precision)
  x_max <- terra::ext(x)[2] |> round(precision)
  y_min <- terra::ext(x)[3] |> round(precision)
  y_max <- terra::ext(x)[4] |> round(precision)
  x_range <- terra::ext(x)[1:2] |> diff() |> unname()

  roll <- dx / x_range
  roll <- abs(roll) %% 1
  comp <- 1 - roll

  if (roll == 0) {
    x
  } else if (dx >= 0) {
    left_x_max <- (x_min + (comp * x_range)) |> round(precision)

    left_ext <- terra::ext(x_min, left_x_max, y_min, y_max)
    left  <- x |> terra::crop(left_ext)

    right_ext <- terra::ext(left_x_max, x_max, y_min, y_max)
    right <- x |> terra::crop(right_ext)

    if (inherits(x, "SpatVector")) {
      left <- terra::shift(left, roll * x_range)
      right <- terra::shift(right, (- (comp * x_range)) + overlap_tolerance)

      terra::combineGeoms(right, left, minover = 10^-10) |>
        terra::shift(- (roll * x_range))
    } else {
      left  <- left %>% terra::`ext<-`(left_ext)
      right <- right %>% terra::`ext<-`(right_ext)

      right_range <- terra::ext(right)[1:2] |> diff()
      terra::ext(right) <- terra::ext(x_min - right_range, x_min, y_min, y_max)

      terra::merge(right, left)
    }
  } else {
    right_x_min <- (x_max - (comp * x_range)) |> round(precision)

    right_ext <- terra::ext(right_x_min, x_max, y_min, y_max)
    right  <- x |> terra::crop(right_ext)

    left_ext <- terra::ext(x_min, right_x_min, y_min, y_max)
    left <- x |> terra::crop(left_ext)

    if (inherits(x, "SpatVector")) {
      right <- terra::shift(right, - (roll * x_range))
      left <- terra::shift(left, (comp * x_range) - overlap_tolerance)

      terra::combineGeoms(right, left, minover = 10^-10) |>
        terra::shift(roll * x_range)
    } else {
      right <- right %>% terra::`ext<-`(right_ext)
      left  <- left %>% terra::`ext<-`(left_ext)

      left_range <- terra::ext(left)[1:2] |> diff()
      terra::ext(left) <- terra::ext(x_max, x_max + left_range, y_min, y_max)

      terra::merge(right, left)
    }
  }
}
