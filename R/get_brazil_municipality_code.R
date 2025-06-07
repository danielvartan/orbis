#' Get Brazilian municipalities codes
#'
#' @description
#'
#' `get_brazil_municipality()` returns a vector with codes of the Brazilian
#' Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) for
#' Brazilian municipalities.
#'
#' @param names (optional) A [`logical`][base::logical()] flag indicating
#'   whether to return the names of the municipalities as names of the
#'   vector (default: `TRUE`).
#' @param ... (optional) Additional arguments passed to
#'   [`get_brazil_municipality()`][get_brazil_municipality].
#'
#' @return An [`integer`][base::integer()] vector with the IBGE codes of
#'   Brazilian municipalities.
#'
#' @inheritParams get_brazil_municipality
#' @template details_brazil_b
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_municipality_code(municipality = "Belém")
#'
#' get_brazil_municipality_code(municipality = "Belém", names = FALSE)
#'
#' get_brazil_municipality_code(municipality = "Belém", state = "Pará")
#'
#' get_brazil_municipality_code(municipality = c("Rio de Janeiro", "São Paulo"))
get_brazil_municipality_code <- function(
  municipality,
  state = NULL,
  year = Sys.Date() |> lubridate::year(),
  names = TRUE,
  ...
) {
  prettycheck::assert_internet()
  checkmate::assert_character(municipality)
  checkmate::assert_character(state, null.ok = TRUE)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_flag(names)

  # R CMD Check variable bindings fix
  # nolint start
  municipality_code <- federal_unit <- NULL
  # nolint end

  out <- get_brazil_municipality(municipality, state, year = year, ...)

  if (isTRUE(names)) {
    out |>
      dplyr::pull(municipality_code) |>
      magrittr::set_names(
        paste0(
          out |> dplyr::pull(municipality), "-",
          out |> dplyr::pull(federal_unit)
        )
      )
  } else {
    out |> dplyr::pull(municipality_code)
  }
}
