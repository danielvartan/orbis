#' Get Brazilian municipalities codes
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_municipality()` returns a vector with codes of the Brazilian
#' Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) for
#' Brazilian municipalities.
#'
#' @param names (Optional) A [`logical`][base::logical] flag indicating
#'   whether to return the names of the municipalities as names of the
#'   vector (Default: `TRUE`).
#'
#' @return An [`integer`][base::integer] vector with the municipalities codes.
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
    municipality, # nolint
    state = NULL,
    year = 2017,
    names = TRUE
  ) {
  prettycheck::assert_internet()
  checkmate::assert_character(municipality)
  checkmate::assert_character(state, null.ok = TRUE)
  checkmate::assert_int(
    year,
    lower = 1900,
    upper = Sys.Date() |> lubridate::year()
  )
  checkmate::assert_flag(names)

  # R CMD Check variable bindings fix
  # nolint start
  municipality_code <- federal_unit <- NULL
  # nolint end

  out <- get_brazil_municipality(municipality, state, year = year)

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
