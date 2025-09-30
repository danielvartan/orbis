collapse_wc_resolutions  <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "collapse_wc_resolutions()",
    details = "Use `worldclim_collapse_resolutions()` instead."
  )

  worldclim_collapse_resolutions(...)
}

filter_points_on_land <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "filter_points_on_land()",
    details = "Use `filter_points()` instead."
  )

  filter_points(...)
}

get_brazil_fu <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_fu()",
    details = "Use `brazil_fu()` instead."
  )

  brazil_fu(...)
}

get_brazil_municipality <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_municipality()",
    details = "Use `brazil_municipality()` instead."
  )

  brazil_municipality(...)
}

get_brazil_municipality_coords <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_municipality_coords()",
    details = "Use `brazil_municipality_coords()` instead."
  )

  brazil_municipality_coords(...)
}

get_brazil_municipality_latitude <- function(...) { #nolint
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_municipality_latitude()",
    details = "Use `brazil_municipality_latitude()` instead."
  )

  brazil_municipality_latitude(...)
}

get_brazil_municipality_longitude <- function(...) { #nolint
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_municipality_longitude()",
    details = "Use `brazil_municipality_longitude()` instead."
  )

  brazil_municipality_longitude(...)
}

get_brazil_region <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_region()",
    details = "Use `brazil_region()` instead."
  )

  brazil_region(...)
}

get_brazil_region_code <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_region_code()",
    details = "Use `brazil_region_code()` instead."
  )

  brazil_region_code(...)
}

get_brazil_state <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state()",
    details = "Use `brazil_state()` instead."
  )

  brazil_state(...)
}

get_brazil_state_by_utc <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state_by_utc()",
    details = "Use `brazil_state_by_utc()` instead."
  )

  brazil_state_by_utc(...)
}

get_brazil_state_capital <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state_capital()",
    details = "Use `brazil_state_capital()` instead."
  )

  brazil_state_capital(...)
}

get_brazil_state_code <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state_code()",
    details = "Use `brazil_state_code()` instead."
  )

  brazil_state_code(...)
}

get_brazil_state_latitude <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state_latitude()",
    details = "Use `brazil_state_latitude()` instead."
  )

  brazil_state_latitude(...)
}

get_brazil_state_longitude <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_brazil_state_longitude()",
    details = "Use `brazil_state_longitude()` instead."
  )

  brazil_state_longitude(...)
}

get_country_names <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_country_names()",
    details = "Use `country_names()` instead."
  )

  country_names(...)
}

get_closest_geobr_year <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_closest_geobr_year()",
    details = "Use `closest_geobr_year()` instead."
  )

  closest_geobr_year(...)
}

get_from_brazil_municipality <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_from_brazil_municipality()",
    details = "Use `brazil_municipality_get()` instead."
  )

  brazil_municipality_get(...)
}

get_geocode_by_address <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_geocode_by_address()",
    details = "Use `geocode_by_address()` instead."
  )

  geocode_by_address(...)
}

get_geocode_by_postal_code <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_geocode_by_postal_code()",
    details = "Use `geocode_by_postal_code()` instead."
  )

  geocode_by_postal_code(...)
}

get_map_fill_data <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_map_fill_data()",
    details = "Use `map_fill_data()` instead."
  )

  map_fill_data(...)
}

get_qualocep_data <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_qualocep_data()",
    details = "Use `qualocep_download()` instead."
  )

  qualocep_download(...)
}

get_sidra_by_year <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_sidra_by_year()",
    details = "Use `sidra_download_by_year()` instead."
  )

  sidra_download_by_year(...)
}

get_wc_url <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "get_wc_url()",
    details = "Use `worldclim_url()` instead."
  )

  worldclim_url(...)
}

render_brazil_address <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "render_brazil_address()",
    details = "Use `brazil_render_address()` instead."
  )

  brazil_render_address(...)
}

wc_to_ascii <- function(...) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "wc_to_ascii()",
    details = "Use `worldclim_to_ascii()` instead."
  )

  worldclim_to_ascii(...)
}
