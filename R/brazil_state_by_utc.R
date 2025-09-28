#' Get Brazilian state names by UTC
#'
#' @description
#'
#' `brazil_state_by_utc()` returns a vector with the names of
#' Brazilian states or abbreviations of Brazilian federal units by the
#' [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)
#' offset.
#'
#' @details
#'
#' The data from this function is based on the 2024b dataset
#' (Released 2024-09-04) from the Internet Assigned Numbers Authority
#' (IANA, 2024)
#'
#' @param utc (optional) An [`integerish`][checkmate::test_int] number
#'   with the UTC offset. Available choices are `-5`, `-4`, `-3`, or `-2`
#'  (default: `-3`).
#' @param type (optional) A [`character`][base::character] string specifying
#'   the type of value to return. Available choices are `"state"` or `"fu"`
#'   (default: `"fu"`).
#'
#' @return A [`character`][base::character] vector with the names of
#'   Brazilian states or abbreviations of Brazilian federal units.
#'
#' @family Brazil functions
#' @export
#'
#' @references
#'
#' Internet Assigned Numbers Authority. (2024). *Time zone database
#' (No. 2024b)* \[Dataset\]. \url{https://www.iana.org/time-zones}
#'
#' @examples
#' brazil_state_by_utc(-3, type = "fu")
#'
#' brazil_state_by_utc(-3, type = "state")
brazil_state_by_utc <- function(utc = -3, type = "fu") {
  # checkmate::assert_choice(utc, -5:-2)
  checkmate::assert_int(utc)
  checkmate::assert_choice(type, c("fu", "state"))

  if (!utc %in% c(-5, -4, -3, -2)) {
    cli::cli_abort(
      paste0(
        "The {.strong {cli::col_red('utc')}} argument must be an integerish
        vector with the UTC offset. Available choices are: ",
        "{.strong -5}, {.strong -4}, {.strong -3}, or {.strong -2}."
      )
    )
  }

  if (utc == -2) {
    # PE -> Except Atlantic islands -> Fernando de Noronha
    out <- "PE"
  } else if (utc == -3) {
    out <- c(
      "AL", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "PA", "PB", "PR",
      "PE", "PI", "RJ", "RN", "RS", "SC", "SP", "SE", "TO"
    )
  } else if (utc == -4) {
    # AM -> East (Except far west)
    out <- c("AM", "MT", "MS", "RO", "RR")
  } else if (utc == -5) {
    # AM -> West (Far west)
    out <- c("AC", "AM")
  }

  if (type == "fu") out else brazil_state(out)
}
