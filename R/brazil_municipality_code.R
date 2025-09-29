#' Get Brazilian municipalities codes
#'
#' @description
#'
#' `brazil_municipality_code()` returns a vector with codes of the Brazilian
#' Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) for
#' Brazilian municipalities.
#'
#' **Note:** This function requires an active internet connection and the
#' [`geobr`](https://ipeagit.github.io/geobr/) package to be installed.
#'
#' @param names (optional) A [`logical`][base::logical()] flag indicating
#'   whether to return the names of the municipalities as names of the
#'   vector (default: `TRUE`).
#' @param ... (optional) Additional arguments passed to
#'   [`brazil_municipality()`][brazil_municipality].
#'
#' @return An [`integer`][base::integer()] vector with the IBGE codes of
#'   Brazilian municipalities.
#'
#' @inheritParams brazil_municipality
#' @template details_brazil_b
#' @family Brazil functions
#' @export
#'
#' @examples
#' library(curl)
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality_code(municipality = "Belém")
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality_code(municipality = "Belém", names = FALSE)
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality_code(municipality = "Belém", state = "Pará")
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality_code(c("Rio de Janeiro", "São Paulo"))
#'   }
#' }
brazil_municipality_code <- function(
  municipality,
  state = NULL,
  year = Sys.Date() |> substr(1, 4) |> as.numeric(),
  names = TRUE,
  ...
) {
  require_pkg("geobr")

  assert_internet()
  checkmate::assert_character(municipality)
  checkmate::assert_character(state, null.ok = TRUE)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_flag(names)

  # R CMD Check variable bindings fix
  # nolint start
  municipality_code <- federal_unit <- NULL
  # nolint end

  out <- brazil_municipality(municipality, state, year = year, ...)

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
