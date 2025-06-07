#' Get Brazilian municipalities longitude
#'
#' @description
#'
#' `get_brazil_municipality_longitude()` returns the longitude of Brazilian
#' municipalities.
#'
#' @param municipality_code An [`integerish`][checkmate::test_integerish] vector
#'   with the IBGE codes of Brazilian municipalities. Use
#'   [`get_brazil_municipality_code()`][get_brazil_municipality_code]
#'   to obtain codes from municipality names and states.
#'
#' @return A [`numeric`][base::numeric] vector with the longitude of the
#'   Brazilian municipalities.
#'
#' @inheritParams get_brazil_municipality get_brazil_municipality_code
#' @template details_brazil_b
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_municipality_longitude(3550308)
#'
#' get_brazil_municipality_longitude(c(3550308, 3500204))
#'
#' get_brazil_municipality_longitude(c(3550308, 1000, 3500204))
#'
#' get_brazil_municipality_longitude(c(3550308, NA, 3500204))
get_brazil_municipality_longitude <- function( #nolint
  municipality_code,
  year = Sys.Date() |> lubridate::year(),
  coords_method = "geobr",
  names = TRUE,
  ...
) {
  checkmate::assert_integerish(municipality_code)
  checkmate::assert_integer(nchar(municipality_code), lower = 2, upper = 7)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_flag(names)

  get_from_brazil_municipality(
    x = municipality_code,
    col_filter = "municipality_code",
    col_return = "longitude",
    year = year,
    names = names,
    coords_method = coords_method,
    ...
  )
}
