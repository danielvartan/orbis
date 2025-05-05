#' Get Brazilian state latitude
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_state_latitude()` returns a vector with the latitude of
#' Brazilian state capitals.
#'
#' @details
#'
#' The data from this function is based on Google's Geocoding API gathered via
#' the [`tidygeocoder`][tidygeocoder::tidygeocoder] R package.
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names of Brazilian states or federal units. Municipality and state codes
#'   are also supported. If `NULL`, returns a vector with all state latitudes
#'   (default: `NULL`).
#'
#' @return A [`character`][base::character] vector with the latitude of
#'   Brazilian state capitals.
#'
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_latitude()
#'
#' get_brazil_state_latitude("sp")
#' #> [1] -23.55065 # Expected
#'
#' get_brazil_state_latitude("sao paulo")
#' #> [1] -23.55065 # Expected
#'
#' get_brazil_state_latitude(35) # State of São Paulo
#' #> [1] -23.55065 # Expected
#'
#' get_brazil_state_latitude(3550308) # Municipality of São Paulo
#' #> [1] -23.55065 # Expected
#'
#' get_brazil_state_latitude(35503081) # >7 digits
#' #> [1] NA # Expected
#'
#' get_brazil_state_latitude(3912345) # Non-existent state code
#' #> [1] NA # Expected
get_brazil_state_latitude <- function(x = NULL) {
  checkmate::assert_atomic(x)

  if (is.null(x)) {
    c(
      "Acre" = -9.9765362, # Rio Branco
      "Alagoas" = -9.6476843, # Maceió
      "Amap\u00e1" = 0.0401529, # Macapá
      "Amazonas" = -3.1316333, # Manaus
      "Bahia" = -12.9822499, # Salvador
      "Cear\u00e1" = -3.7304512, # Fortaleza
      "Distrito Federal" = -15.7934036, # Brasília
      "Esp\u00edrito Santo" = -20.3200917, # Vitória
      "Goi\u00e1s" = -16.6808820, # Goiânia
      "Maranh\u00e3o" = -2.5295265, # São Luís
      "Mato Grosso" = -15.5986686, # Cuiabá
      "Mato Grosso do Sul" = -20.4640173, # Campo Grande
      "Minas Gerais" = -19.9227318, # Belo Horizonte
      "Par\u00e1" = -1.4505600, # Belém
      "Para\u00edba" = -7.1215981, # João Pessoa
      "Paran\u00e1" = -25.4295963, # Curitiba
      "Pernambuco" = -8.0584933, # Recife
      "Piau\u00ed" = -5.0874608, # Teresina
      "Rio de Janeiro" = -22.9110137, # Rio de Janeiro
      "Rio Grande do Norte" = -5.8053980, # Natal
      "Rio Grande do Sul" = -30.0324999, # Porto Alegre
      "Rond\u00f4nia" = -8.7494525, # Porto Velho
      "Roraima" = 2.8208478, # Boa Vista
      "Santa Catarina" = -27.5973002, # Florianópolis
      "S\u00e3o Paulo" = -23.5506507, # São Paulo
      "Sergipe" = -10.9162061, # Aracaju
      "Tocantins" = -10.1837852 # Palmas
    )
  }  else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_real_,
      stringr::str_starts(x, "12") ~ -9.9765362, # Rio Branco (AC)
      stringr::str_starts(x, "27") ~ -9.6476843, # Maceió (AL)
      stringr::str_starts(x, "16") ~ 0.0401529, # Macapá (AP)
      stringr::str_starts(x, "13") ~ -3.1316333, # Manaus (AM)
      stringr::str_starts(x, "29") ~ -12.9822499, # Salvador (BA)
      stringr::str_starts(x, "23") ~ -3.7304512, # Fortaleza (CE)
      stringr::str_starts(x, "53") ~ -15.7934036, # Brasília (DF)
      stringr::str_starts(x, "32") ~ -20.3200917, # Vitória (ES)
      stringr::str_starts(x, "52") ~ -16.6808820, # Goiânia (GO)
      stringr::str_starts(x, "21") ~ -2.5295265, # São Luís (MA)
      stringr::str_starts(x, "51") ~ -15.5986686, # Cuiabá (MT)
      stringr::str_starts(x, "50") ~ -20.4640173, # Campo Grande (MS)
      stringr::str_starts(x, "31") ~ -19.9227318, # Belo Horizonte (MG)
      stringr::str_starts(x, "15") ~ -1.4505600, # Belém (PA)
      stringr::str_starts(x, "25") ~ -7.1215981, # João Pessoa (PB)
      stringr::str_starts(x, "41") ~ -25.4295963, # Curitiba (PR)
      stringr::str_starts(x, "26") ~ -8.0584933, # Recife (PE)
      stringr::str_starts(x, "22") ~ -5.0874608, # Teresina (PI)
      stringr::str_starts(x, "33") ~ -22.9110137, # Rio de Janeiro (RJ)
      stringr::str_starts(x, "24") ~ -5.8053980, # Natal (RN)
      stringr::str_starts(x, "43") ~ -30.0324999, # Porto Alegre (RS)
      stringr::str_starts(x, "11") ~ -8.7494525, # Porto Velho (RO)
      stringr::str_starts(x, "14") ~ 2.8208478, # Boa Vista (RR)
      stringr::str_starts(x, "42") ~ -27.5973002, # Florianópolis (SC)
      stringr::str_starts(x, "35") ~ -23.5506507, # São Paulo (SP)
      stringr::str_starts(x, "28") ~ -10.9162061, # Aracaju (SE)
      stringr::str_starts(x, "17") ~ -10.1837852 # Palmas (TO)
    )
  } else {
    x <- x |> to_ascii() |> tolower()

    dplyr::case_match(
      x,
      c("acre", "ac") ~ -9.9765362, # Rio Branco
      c("alagoas", "al") ~ -9.6476843, # Maceió
      c("amapa", "ap") ~ 0.0401529, # Macapá
      c("amazonas", "am") ~ -3.1316333, # Manaus
      c("bahia", "ba") ~ -12.9822499, # Salvador
      c("ceara", "ce") ~ -3.7304512, # Fortaleza
      c("distrito federal", "df") ~ -15.7934036, # Brasília
      c("espirito santo", "es") ~ -20.3200917, # Vitória
      c("goias", "go") ~ -16.6808820, # Goiania
      c("maranhao", "ma") ~ -2.5295265, # São Luís
      c("mato grosso", "mt") ~ -15.5986686, # Cuiabá
      c("mato grosso do sul", "ms") ~ -20.4640173, # Campo Grande
      c("minas gerais", "mg") ~ -19.9227318, # Belo Horizonte
      c("para", "pa") ~ -1.4505600, # Belém
      c("paraiba", "pb") ~ -7.1215981, # João Pessoa
      c("parana", "pr") ~ -25.4295963, # Curitiba
      c("pernambuco", "pe") ~ -8.0584933, # Recife
      c("piaui", "pi") ~ -5.0874608, # Teresina
      c("rio de janeiro", "rj") ~ -22.9110137, # Rio de Janeiro
      c("rio grande do norte", "rn") ~ -5.8053980, # Natal
      c("rio grande do sul", "rs") ~ -30.0324999, # Porto Alegre
      c("rondonia", "ro") ~ -8.7494525, # Porto Velho
      c("roraima", "rr") ~ 2.8208478, # Boa Vista
      c("santa catarina", "sc") ~ -27.5973002, # Florianópolis
      c("sao paulo", "sp") ~ -23.5506507, # São Paulo
      c("sergipe", "se") ~ -10.9162061, # Aracaju
      c("tocantins", "to") ~ -10.1837852 # Palmas
    )
  }
}
