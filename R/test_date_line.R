#' Test if a spatial object crosses the international date line
#'
#' @description
#'
#' `test_date_line()` checks whether a given spatial object crosses the
#' international date line
#' ([IDL](https://en.wikipedia.org/wiki/International_Date_Line)) by examining
#' its longitude extent.
#'
#' @param x A [`sf`][sf::st_as_sf()], [`SpatVector`][terra::vect()], or
#'   [`SpatRaster`][terra::rast()] object to be tested.
#'
#' @return A [`logical`][base::logical()] flag indicating if the object crosses
#'   the international date line.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' \dontrun{
#'    library(geodata)
#'
#'    brazil_shape <- gadm(country = "BRA", level = 0)
#'    russia_shape <- gadm(country = "RUS", level = 0)
#'
#'    test_date_line(brazil_shape)
#'    test_date_line(russia_shape)
#' }
test_date_line <- function(x) {
  checkmate::assertMultiClass(x, c("sf", "SpatVector", "SpatRaster"))

  if (inherits(x, "sf")) {
    x <- x |> terra::vect()
  }

  x_min <-
    x |>
    terra::ext() |>
    magrittr::extract(1) |>
    round()

  x_max <-
    x |>
    terra::ext() |>
    magrittr::extract(2) |>
    round()

  if ((x_max - x_min) > 270) {
    if ("GID_0" %in% names(x)) {
      if ("Antarctica" %in% x$GID_0) {
        FALSE
      } else {
        TRUE
      }
    } else {
      TRUE
    }
  } else {
    FALSE
  }
}
