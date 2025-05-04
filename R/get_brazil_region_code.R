#' Get Brazilian region codes
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_region_code()` returns a vector with the Brazilian Institute
#' of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) codes for
#' Brazilian regions.
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian regions. If `NULL`, returns all Brazilian region codes
#'   (Default: `NULL`).
#'
#' @return An [`integer`][base::integer()] vector with the IBGE codes of
#'   Brazilian regions.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_region_code()
#'
#' get_brazil_region_code("north")
#' #> [1] 1 # Expected
#'
#' get_brazil_region_code(c("north", "central-west"))
#' #> [1] 1 5 # Expected
get_brazil_region_code <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  if (!is.null(x)) x <- x |> to_ascii() |> tolower()

  if (is.null(x)) {
    c(
      "North" = 1,
      "Northeast" = 2,
      "Southeast" = 3,
      "South" = 4,
      "Central-West" = 5
    ) |>
      methods::as("integer")
  } else {

    dplyr::case_match(
      x,
      "north" ~ 1,
      "northeast" ~ 2,
      "southeast" ~ 3,
      "south" ~ 4,
      c("central-west", "central", "west") ~ 5,
    ) |>
      as.integer()
  }
}
