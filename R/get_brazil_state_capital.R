#' Get Brazilian state capital names
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_state_capital()` returns a vector with the capital names of
#' Brazilian states or federal units.
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian states or federal units. If `NULL`, returns all state capital
#'   names (Default: `NULL`).
#'
#' @return A [`character`][base::character()] vector with the names of
#'   Brazilian state capitals.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_capital()
#'
#' get_brazil_state_capital("piaui")
#' #> [1] "Teresina" # Expected
#'
#' get_brazil_state_capital("pi")
#' #> [1] "Teresina" # Expected
get_brazil_state_capital <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "get_brazil_state_capital.R"))

  if (!is.null(x)) x <- x |> groomr::to_ascii() |> tolower()

  if (is.null(x)) {
    c(
      "Acre" = "Rio Branco",
      "Alagoas" = "Macei\u00f3",
      "Amap\u00e1" = "Macap\u00e1",
      "Amazonas" = "Manaus",
      "Bahia" = "Salvador",
      "Cear\u00e1" = "Fortaleza",
      "Distrito Federal" = "Bras\u00edlia",
      "Esp\u00edrito Santo" = "Vit\u00f3ria",
      "Goi\u00e1s" = "Goi\u00e2nia",
      "Maranh\u00e3o" = "S\u00e3o Lu\u00eds",
      "Mato Grosso" = "Cuiab\u00e1",
      "Mato Grosso do Sul" = "Campo Grande",
      "Minas Gerais" = "Belo Horizonte",
      "Par\u00e1" = "Bel\u00e9m",
      "Para\u00edba" = "Jo\u00e3o Pessoa",
      "Paran\u00e1" = "Curitiba",
      "Pernambuco" = "Recife",
      "Piau\u00ed" = "Teresina",
      "Rio de Janeiro" = "Rio de Janeiro",
      "Rio Grande do Norte" = "Natal",
      "Rio Grande do Sul" = "Porto Alegre",
      "Rond\u00f4nia" = "Porto Velho",
      "Roraima" = "Boa Vista",
      "Santa Catarina" = "Florian\u00f3polis",
      "S\u00e3o Paulo" = "S\u00e3o Paulo",
      "Sergipe" = "Aracaju",
      "Tocantins" = "Palmas"
    )
  } else {
    dplyr::case_match(
      x,
      c("ac", "acre") ~ "Rio Branco",
      c("al", "alagoas") ~ "Macei\u00f3",
      c("ap", "amapa") ~ "Macap\u00e1",
      c("am", "amazonas") ~ "Manaus",
      c("ba", "bahia") ~ "Salvador",
      c("ce", "ceara") ~ "Fortaleza",
      c("df", "distrito federal") ~ "Bras\u00edlia",
      c("es", "espirito santo") ~ "Vit\u00f3ria",
      c("go", "goias") ~ "Goi\u00e2nia",
      c("ma", "maranhao") ~ "S\u00e3o Lu\u00eds",
      c("mt", "mato grosso") ~ "Cuiab\u00e1",
      c("ms", "mato grosso do sul") ~ "Campo Grande",
      c("mg", "minas gerais") ~ "Belo Horizonte",
      c("pa", "para") ~ "Bel\u00e9m",
      c("pb", "paraiba") ~ "Jo\u00e3o Pessoa",
      c("pr", "parana") ~ "Curitiba",
      c("pe", "pernambuco") ~ "Recife",
      c("pi", "piaui") ~ "Teresina",
      c("rj", "rio de janeiro") ~ "Rio de Janeiro",
      c("rn", "rio grande do norte") ~ "Natal",
      c("rs", "rio grande do sul") ~ "Porto Alegre",
      c("ro", "rondonia") ~ "Porto Velho",
      c("rr", "roraima") ~ "Boa Vista",
      c("sc", "santa catarina") ~ "Florian\u00f3polis",
      c("sp", "sao paulo") ~ "S\u00e3o Paulo",
      c("se", "sergipe") ~ "Aracaju",
      c("to", "tocantins") ~ "Palmas"
    )
  }
}
