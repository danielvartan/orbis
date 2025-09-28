#' Shift, rotate, and crop a raster using a vector
#'
#' @description
#'
#' `shift_and_crop()` shifts and rotates both a raster and a vector by a
#' specified horizontal distance, then crops the raster to the extent of the
#' shifted vector.
#'
#' This function is particularly useful for working with rasters and vectors
#' that span the dateline (e.g. the Russian territory).
#'
#' @param raster A [`SpatRaster`][terra::SpatRaster] object to be shifted,
#'   rotated, and cropped.
#' @param vector A [`SpatVector`][terra::SpatVector] object to be shifted
#'   and rotated.
#' @param ... Additional arguments passed to [`crop()`][terra::crop].
#'
#' @return A [`SpatRaster`][terra::SpatRaster] object that has been shifted and
#'   rotated by the specified amount in degrees, then cropped to the extent of
#'   the provided vector.
#'
#' @inheritParams shift_and_rotate
#' @family raster functions
#' @export
#'
#' @examples
#' \dontrun{
#'   library(curl)
#'   library(dplyr)
#'   library(geodata)
#'   library(ggplot2)
#'   library(terra)
#'   library(tidyterra)
#'
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
#'     raster <- raster |> crop(world_shape, mask = TRUE)
#'
#'     plot_raster <- function(raster) {
#'       plot <-
#'         ggplot() +
#'         geom_spatraster(data = raster) +
#'         scale_fill_continuous(
#'           palette = c("#072359", "#3243A6", "#9483AF"),
#'           na.value = "white"
#'         ) +
#'         labs(fill = NULL)
#'
#'       print(plot)
#'     }
#'
#'     vector <- gadm(country = "rus", level = 0, path = tempdir())
#'
#'     plot_vector <- function(vector) {
#'       plot <-
#'         vector |>
#'         ggplot() +
#'         geom_spatvector(fill = "#3243A6", color = "white")
#'
#'       print(plot)
#'     }
#'
#'     vector |> plot_vector()
#'
#'     raster <- raster |> shift_and_crop(vector, -45)
#'
#'     raster |>
#'       ggplot() +
#'       geom_spatraster(data = raster) +
#'       scale_fill_continuous(
#'         palette = c("#072359", "#3243A6", "#9483AF"),
#'         na.value = "white"
#'       ) +
#'       theme_bw() +
#'       theme(
#'         panel.grid.major = element_blank(),
#'         panel.grid.minor = element_blank()
#'       )
#'   }
#' }
shift_and_crop <- function(
  raster,
  vector,
  dx = -45,
  precision = 5,
  overlap_tol = 0.1,
  ...
) {
  checkmate::assert_class(raster, "SpatRaster")
  checkmate::assert_class(vector, "SpatVector")
  checkmate::assert_number(dx)
  checkmate::assert_number(precision, lower = 0, upper = 10)
  checkmate::assert_number(overlap_tol, lower = 0, upper = 1)

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

  raster <- raster |> shift_and_rotate(dx, precision, overlap_tol)
  vector <- vector |> shift_and_rotate(dx, precision, overlap_tol)

  raster |>
    terra::crop(
      vector,
      mask = TRUE,
      touches = TRUE,
      extend = TRUE,
      ...
    )
}
