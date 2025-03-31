#' Get Brazilian state codes
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_state_code()` returns a vector with the Brazilian Institute
#' of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) codes for
#' Brazilian states.
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian states or federal units. If `NULL`, returns all state codes
#'   (Default: `NULL`).
#'
#' @return A [`character`][base::character()] vector with the IBGE codes of
#'   Brazilian states.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_code()
#'
#' get_brazil_state_code("acre")
#' #> [1] 12 # Expected
#'
#' get_brazil_state_code("ac")
#' #> [1] 12 # Expected
get_brazil_state_code <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  if (is.null(x)) {
    c(
      "Acre" = 12,
      "Alagoas" = 27,
      "Amap\u00e1" = 16,
      "Amazonas" = 13,
      "Bahia" = 29,
      "Cear\u00e1" = 23,
      "Distrito Federal" = 53,
      "Esp\u00edrito Santo" = 32,
      "Goi\u00e1s" = 52,
      "Maranh\u00e3o" = 21,
      "Mato Grosso" = 51,
      "Mato Grosso do Sul" = 50,
      "Minas Gerais" = 31,
      "Par\u00e1" = 15,
      "Para\u00edba" = 25,
      "Paran\u00e1" = 41,
      "Pernambuco" = 26,
      "Piau\u00ed" = 22,
      "Rio de Janeiro" = 33,
      "Rio Grande do Norte" = 24,
      "Rio Grande do Sul" = 43,
      "Rond\u00f4nia" = 11,
      "Roraima" = 14,
      "Santa Catarina" = 42,
      "S\u00e3o Paulo" = 35,
      "Sergipe" = 28,
      "Tocantins" = 17
    ) |>
      methods::as("integer")
  } else {
    x <- x |> to_ascii() |> tolower()

    dplyr::case_match(
      x,
      c("acre", "ac") ~ 12,
      c("alagoas", "al") ~ 27,
      c("amapa", "ap") ~ 16,
      c("amazonas", "am") ~ 13,
      c("bahia", "ba") ~ 29,
      c("ceara", "ce") ~ 23,
      c("distrito federal", "df") ~ 53,
      c("espirito santo", "es") ~ 32,
      c("goias", "go") ~ 52,
      c("maranhao", "ma") ~ 21,
      c("mato grosso", "mt") ~ 51,
      c("mato grosso do sul", "ms") ~ 50,
      c("minas gerais", "mg") ~ 31,
      c("para", "pa") ~ 15,
      c("paraiba", "pb") ~ 25,
      c("parana", "pr") ~ 41,
      c("pernambuco", "pe") ~ 26,
      c("piaui", "pi") ~ 22,
      c("rio de janeiro", "rj") ~ 33,
      c("rio grande do norte", "rn") ~ 24,
      c("rio grande do sul", "rs") ~ 43,
      c("rondonia", "ro") ~ 11,
      c("roraima", "rr") ~ 14,
      c("santa catarina", "sc") ~ 42,
      c("sao paulo", "sp") ~ 35,
      c("sergipe", "se") ~ 28,
      c("tocantins", "to") ~ 17
    ) |>
      as.integer()
  }
}
