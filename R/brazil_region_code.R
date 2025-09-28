#' Get Brazilian region codes
#'
#' @description
#'
#' `brazil_region_code()` returns a vector with the Brazilian Institute
#' of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) codes for
#' Brazilian regions.
#'
#' @param x (optional) A [`character`][base::character()] vector containing
#'   the names of Brazilian regions, states, or federal units. If `NULL`,
#'   returns a named vector with all Brazilian region codes (default: `NULL`).
#'
#' @return An [`integer`][base::integer()] vector with the IBGE codes of
#'   Brazilian regions.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' brazil_region_code()
#'
#' brazil_region_code("north")
#' #> [1] 1 # Expected
#'
#' brazil_region_code(c("north", "central-west"))
#' #> [1] 1 5 # Expected
#'
#' brazil_region_code("sao paulo")
#' #> [1] 3 # Expected
#'
#' brazil_region_code("sp")
#' #> [1] 3 # Expected
brazil_region_code <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  if (!is.null(x)) x <- x |> to_ascii() |> tolower()

  if (is.null(x)) {
    c(
      "North" = 1,
      "Northeast" = 2,
      "Southeast" = 3,
      "South" = 4,
      "Central-West" = 5
    ) %>%
      `storage.mode<-`("integer") # methods::as("integer")
  } else {
    dplyr::case_match(
      x,
      c(
        "north", "acre", "ac", "amapa", "ap", "amazonas", "am",
        "para", "pa", "rondonia", "ro", "roraima", "rr",
        "tocantins", "to"
      ) ~ 1,
      c(
        "northeast", "alagoas", "al", "bahia", "ba", "ceara", "ce",
        "maranhao", "ma", "paraiba", "pb", "pernambuco", "pe",
        "piaui", "pi", "rio grande do norte", "rn", "sergipe", "se"
      ) ~ 2,
      c(
        "southeast", "espirito santo", "es", "minas gerais", "mg",
        "rio de janeiro", "rj", "sao paulo", "sp"
      ) ~ 3,
      c(
        "south", "parana", "pr", "santa catarina", "sc",
        "rio grande do sul", "rs"
      ) ~ 4,
      c(
        "central-west", "central", "west", "distrito federal", "df",
        "goias", "go", "mato grosso", "mt", "mato grosso do sul", "ms"
      ) ~ 5
    ) |>
      as.integer()
  }
}
