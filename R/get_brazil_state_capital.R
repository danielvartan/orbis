#' Get Brazilian state capital names
#'
#' @description
#'
#' `get_brazil_state_capital()` returns a vector with the capital names of
#' Brazilian states or federal units.
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names of Brazilian states or federal units. Municipality and state codes
#'   are also supported. If `NULL`, returns a vector with all state capital
#'   names (default: `NULL`).
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
#' get_brazil_state_capital("pi")
#' #> [1] "Teresina" # Expected
#'
#' get_brazil_state_capital("piaui")
#' #> [1] "Teresina" # Expected
#'
#' get_brazil_state_capital(22)
#' #> [1] "Teresina" # Expected
#'
#' get_brazil_state_capital(2211001) # Teresina
#' #> [1] "Teresina" # Expected
#'
#' get_brazil_state_capital(22110011) # >7 digits
#' #> [1] NA # Expected
#'
#' get_brazil_state_capital(3912345) # Non-existent state code
#' #> [1] NA # Expected
get_brazil_state_capital <- function(x = NULL) {
  checkmate::assert_atomic(x)

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "get_brazil_state_capital.R"))

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
  } else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_character_,
      stringr::str_starts(x, "12") ~ "Rio Branco", # AC
      stringr::str_starts(x, "27") ~ "Macei\u00f3", # AL
      stringr::str_starts(x, "16") ~ "Macap\u00e1", # AP
      stringr::str_starts(x, "13") ~ "Manaus", # AM
      stringr::str_starts(x, "29") ~ "Salvador", # BA
      stringr::str_starts(x, "23") ~ "Fortaleza", # CE
      stringr::str_starts(x, "53") ~ "Bras\u00edlia", # DF
      stringr::str_starts(x, "32") ~ "Vit\u00f3ria", # ES
      stringr::str_starts(x, "52") ~ "Goi\u00e2nia", # GO
      stringr::str_starts(x, "21") ~ "S\u00e3o Lu\u00eds", # MA
      stringr::str_starts(x, "51") ~ "Cuiab\u00e1", # MT
      stringr::str_starts(x, "50") ~ "Campo Grande", # MS
      stringr::str_starts(x, "31") ~ "Belo Horizonte", # MG
      stringr::str_starts(x, "15") ~ "Bel\u00e9m", # PA
      stringr::str_starts(x, "25") ~ "Jo\u00e3o Pessoa", # PB
      stringr::str_starts(x, "41") ~ "Curitiba", # PR
      stringr::str_starts(x, "26") ~ "Recife", # PE
      stringr::str_starts(x, "22") ~ "Teresina", # PI
      stringr::str_starts(x, "33") ~ "Rio de Janeiro", # RJ
      stringr::str_starts(x, "24") ~ "Natal", # RN
      stringr::str_starts(x, "43") ~ "Porto Alegre", # RS
      stringr::str_starts(x, "11") ~ "Porto Velho", # RO
      stringr::str_starts(x, "14") ~ "Boa Vista", # RR
      stringr::str_starts(x, "42") ~ "Florian\u00f3polis", # SC
      stringr::str_starts(x, "35") ~ "S\u00e3o Paulo", # SP
      stringr::str_starts(x, "28") ~ "Aracaju", # SE
      stringr::str_starts(x, "17") ~ "Palmas", # TO
    )
  } else {
    x <- x |> as.character() |> to_ascii() |> tolower()

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
