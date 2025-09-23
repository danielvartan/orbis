#' Filter points on land
#'
#' @description
#'
#' `filter_points_on_land()` filters latitude/longitude points that intersects
#' with a given geometry.
#'
#' **Note:** This function requires the [`sf`](https://r-spatial.github.io/sf/)
#' package to be installed.
#'
#' @param data A [`tibble`][tibble::tibble] with the data points to be filtered.
#'   It must have columns `longitude` and `latitude`.
#' @param geometry A [`sf`][sf::sf] object with the geometry to be used for
#'   filtering.
#'
#' @return A [`tibble`][tibble::tibble()].
#'
#' @family `sf` functions
#' @export
#'
#' @examples
#' \dontrun{
#'   library(curl)
#'   library(dplyr)
#'   library(geobr)
#'   library(sf)
#'
#'   if (has_internet()) {
#'     data <- tibble(
#'       latitude = get_brazil_state_latitude(),
#'       longitude = get_brazil_state_longitude()
#'     )
#'
#'     data
#'
#'     geometry <- read_state(code = "SP") |> pull(geom)
#'
#'     geometry |> st_bbox()
#'
#'     filter_points_on_land(data, geometry)
#'   }
#' }
filter_points_on_land <- function(data, geometry) {
  checkmate::assert_tibble(data)
  checkmate::assert_subset(c("longitude", "latitude"), names(data))
  checkmate::assert_class(geometry, "sfc_MULTIPOLYGON")

  require_pkg("sf")

  # R CMD Check variable bindings fix
  # nolint start
  row_number <- latitude <- longitude <- NULL
  # nolint end

  box <- geometry |> sf::st_bbox() #nolint

  data <-
    data |>
    dplyr::mutate(row_number = dplyr::row_number()) |>
    dplyr::relocate(row_number)

  na_cases <-
    data |>
    dplyr::select(row_number, latitude, longitude) |>
    dplyr::filter(is.na(latitude) | is.na(longitude))

  points <-
    data |>
    dplyr::select(row_number, latitude, longitude) |>
    tidyr::drop_na() |>
    sf::st_as_sf(
      coords = c("longitude", "latitude"),
      crs = sf::st_crs(geometry)
    ) |>
    sf::st_filter(geometry)

  valid_rows <- c(points$row_number, na_cases$row_number)

  data |>
    dplyr::filter(row_number %in% valid_rows) |>
    dplyr::select(-row_number)
}
