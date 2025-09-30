#' Filter points on land
#'
#' @description
#'
#' `filter_points()` filters latitude/longitude points that intersects
#' with a given [`sf`](https://r-spatial.github.io/sf/) geometry.
#'
#' **Note:** This function requires the [`sf`](https://r-spatial.github.io/sf/)
#' package to be installed.
#'
#' @param data A [`tibble`][tibble::tibble] containing the data points to
#'   filter. Must include `latitude` and `longitude` columns.
#' @param geometry An [`sf`][sf::sf] object with the geometry to be used for
#'   filtering.
#'
#' @return A [`tibble`][tibble::tibble()] with the filtered data points.
#'
#' @family `sf` functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(curl)
#' library(dplyr)
#' library(ggplot2)
#' library(geobr)
#' library(sf)
#'
#' plot_geometry <- function(geometry) {
#'   plot <-
#'     geometry |>
#'     ggplot() +
#'     geom_sf(
#'       color = "gray75",
#'       fill = "white",
#'       inherit.aes = FALSE
#'     ) +
#'     labs(x = "Longitude", y = "Latitude")
#'
#'   print(plot)
#' }
#'
#' plot_points <- function(data, geometry) {
#'   plot <-
#'     data |>
#'     ggplot(aes(x = longitude, y = latitude)) +
#'     geom_sf(
#'       data = geometry,
#'       color = "gray75",
#'       fill = "white",
#'       inherit.aes = FALSE
#'     ) +
#'     geom_point(color = "#3243A6") +
#'     labs(x = "Longitude", y = "Latitude")
#'
#'   print(plot)
#' }
#'
#' # Define the Points -----
#'
#' \dontrun{
#'   if (has_internet() && test_geobr_connection()) {
#'     data <- tibble(
#'       latitude = brazil_state_latitude(),
#'       longitude = brazil_state_longitude()
#'     )
#'
#'     data
#'   }
#' }
#'
#' # Visualize the Points on a Map -----
#'
#' \dontrun{
#'   if (has_internet() && test_geobr_connection()) {
#'     brazil_states_geometry <- read_state()
#'
#'     data |> plot_points(brazil_states_geometry)
#'   }
#' }
#'
#' # Set the Geometry to Filter the Points -----
#'
#' \dontrun{
#'   if (has_internet() && test_geobr_connection()) {
#'     sp_state_geometry <- read_state(code = "SP")
#'
#'     sp_state_geometry |> plot_geometry()
#'   }
#' }
#'
#' # Filter the Points -----
#'
#' \dontrun{
#'   data <- data |> filter_points(sp_state_geometry)
#'
#'   data
#' }
#'
#' # Visualize the Filtered Points -----
#'
#' \dontrun{
#'   data |> plot_points(brazil_states_geometry)
#' }
filter_points <- function(data, geometry) {
  require_pkg("sf")

  checkmate::assert_tibble(data)
  checkmate::assert_subset(c("longitude", "latitude"), names(data))
  assert_geometry(geometry)

  # R CMD Check variable bindings fix
  # nolint start
  row_number <- latitude <- longitude <- NULL
  # nolint end

  geometry <- geometry |> sf::st_geometry()
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
