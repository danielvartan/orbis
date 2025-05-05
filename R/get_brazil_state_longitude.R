#' Get Brazilian state longitude
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_state_longitude()` returns a vector with the longitude of
#' Brazilian state capitals.
#'
#' @details
#'
#' The data from this function is based on Google's Geocoding API gathered via
#' the [`tidygeocoder`][tidygeocoder::tidygeocoder] R package.
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names of Brazilian states or federal units. Municipality and state codes
#'   are also supported. If `NULL`, returns a vector with all state longitudes
#'   (default: `NULL`).
#'
#' @return A [`character`][base::character] vector with the longitude of
#'   Brazilian state capitals.
#'
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_longitude()
#'
#' get_brazil_state_longitude("sp")
#' #> [1] -46.63338 # Expected
#'
#' get_brazil_state_longitude("sao paulo")
#' #> [1] -46.63338 # Expected
#'
#' get_brazil_state_longitude(35) # State of São Paulo
#' #> [1] -46.63338 # Expected
#'
#' get_brazil_state_longitude(3550308) # Municipality of São Paulo
#' #> [1] -46.63338 # Expected
#'
#' get_brazil_state_longitude(35503081) # >7 digits
#' #> [1] NA # Expected
#'
#' get_brazil_state_longitude(3912345) # Non-existent state code
#' #> [1] NA # Expected
get_brazil_state_longitude <- function(x = NULL) {
  checkmate::assert_atomic(x)

  if (is.null(x)) {
    c(
      "Acre" = -67.8220778, # Rio Branco
      "Alagoas" = -35.7339264, # Maceió
      "Amap\u00e1" = -51.0569588, # Macapá
      "Amazonas" = -59.9825041, # Manaus
      "Bahia" = -38.4812772, # Salvador
      "Cear\u00e1" = -38.5217989, # Fortaleza
      "Distrito Federal" = -47.8823172, # Brasília
      "Esp\u00edrito Santo" = -40.3376682, # Vitória
      "Goi\u00e1s" = -49.2532691, # Goiânia
      "Maranh\u00e3o" = -44.2963942, # São Luís
      "Mato Grosso" = -56.0991301, # Cuiabá
      "Mato Grosso do Sul" = -54.6162947, # Campo Grande
      "Minas Gerais" = -43.9450948, # Belo Horizonte
      "Par\u00e1" = -48.4682453, # Belém
      "Para\u00edba" = -34.8820280, # João Pessoa
      "Paran\u00e1" = -49.2712724, # Curitiba
      "Pernambuco" = -34.8848193, # Recife
      "Piau\u00ed" = -42.8049571, # Teresina
      "Rio de Janeiro" = -43.2093727, # Rio de Janeiro
      "Rio Grande do Norte" = -35.2080905, # Natal
      "Rio Grande do Sul" = -51.2303767, # Porto Alegre
      "Rond\u00f4nia" = -63.8735438, # Porto Velho
      "Roraima" = -60.6719582, # Boa Vista
      "Santa Catarina" = -48.5496098, # Florianópolis
      "S\u00e3o Paulo" = -46.6333824, # São Paulo
      "Sergipe" = -37.0774655, # Aracaju
      "Tocantins" = -48.3336423  # Palmas
    )
  }   else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_real_,
      stringr::str_starts(x, "12") ~ -67.8220778, # Rio Branco (AC)
      stringr::str_starts(x, "27") ~ -35.7339264, # Maceió (AL)
      stringr::str_starts(x, "16") ~ -51.0569588, # Macapá (AP)
      stringr::str_starts(x, "13") ~ -59.9825041, # Manaus (AM)
      stringr::str_starts(x, "29") ~ -38.4812772, # Salvador (BA)
      stringr::str_starts(x, "23") ~ -38.5217989, # Fortaleza (CE)
      stringr::str_starts(x, "53") ~ -47.8823172, # Brasília (DF)
      stringr::str_starts(x, "32") ~ -40.3376682, # Vitória (ES)
      stringr::str_starts(x, "52") ~ -49.2532691, # Goiânia (GO)
      stringr::str_starts(x, "21") ~ -44.2963942, # São Luís (MA)
      stringr::str_starts(x, "51") ~ -56.0991301, # Cuiabá (MT)
      stringr::str_starts(x, "50") ~ -54.6162947, # Campo Grande (MS)
      stringr::str_starts(x, "31") ~ -43.9450948, # Belo Horizonte (MG)
      stringr::str_starts(x, "15") ~ -48.4682453, # Belém (PA)
      stringr::str_starts(x, "25") ~ -34.8820280, # João Pessoa (PB)
      stringr::str_starts(x, "41") ~ -49.2712724, # Curitiba (PR)
      stringr::str_starts(x, "26") ~ -34.8848193, # Recife (PE)
      stringr::str_starts(x, "22") ~ -42.8049571, # Teresina (PI)
      stringr::str_starts(x, "33") ~ -43.2093727, # Rio de Janeiro (RJ)
      stringr::str_starts(x, "24") ~ -35.2080905, # Natal (RN)
      stringr::str_starts(x, "43") ~ -51.2303767, # Porto Alegre (RS)
      stringr::str_starts(x, "11") ~ -63.8735438, # Porto Velho (RO)
      stringr::str_starts(x, "14") ~ -60.6719582, # Boa Vista (RR)
      stringr::str_starts(x, "42") ~ -48.5496098, # Florianópolis (SC)
      stringr::str_starts(x, "35") ~ -46.6333824, # São Paulo (SP)
      stringr::str_starts(x, "28") ~ -37.0774655, # Aracaju (SE)
      stringr::str_starts(x, "17") ~ -48.3336423, # Palmas (TO)
    )
  } else {
    x <- x |> as.character() |> to_ascii() |> tolower()

    dplyr::case_match(
      x,
      c("acre", "ac") ~ -67.8220778, # Rio Branco
      c("alagoas", "al") ~ -35.7339264, # Maceió
      c("amapa", "ap") ~ -51.0569588, # Macapá
      c("amazonas", "am") ~ -59.9825041, # Manaus
      c("bahia", "ba") ~ -38.4812772, # Salvador
      c("ceara", "ce") ~ -38.5217989, # Fortaleza
      c("distrito federal", "df") ~ -47.8823172, # Brasília
      c("espirito santo", "es") ~ -40.3376682, # Vitória
      c("goias", "go") ~ -49.2532691, # Goiânia
      c("maranhao", "ma") ~ -44.2963942, # São Luís
      c("mato grosso", "mt") ~ -56.0991301, # Cuiabá
      c("mato grosso do sul", "ms") ~ -54.6162947, # Campo Grande
      c("minas gerais", "mg") ~ -43.9450948, # Belo Horizonte
      c("para", "pa") ~ -48.4682453, # Belém
      c("paraiba", "pb") ~ -34.8820280, # João Pessoa
      c("parana", "pr") ~ -49.2712724, # Curitiba
      c("pernambuco", "pe") ~ -34.8848193, # Recife
      c("piaui", "pi") ~ -42.8049571, # Teresina
      c("rio de janeiro", "rj") ~ -43.2093727, # Rio de Janeiro
      c("rio grande do norte", "rn") ~ -35.2080905, # Natal
      c("rio grande do sul", "rs") ~ -51.2303767, # Porto Alegre
      c("rondonia", "ro") ~ -63.8735438, # Porto Velho
      c("roraima", "rr") ~ -60.6719582, # Boa Vista
      c("santa catarina", "sc") ~ -48.5496098, # Florianópolis
      c("sao paulo", "sp") ~ -46.6333824, # São Paulo
      c("sergipe", "se") ~ -37.0774655, # Aracaju
      c("tocantins", "to") ~ -48.3336423  # Palmas
    )
  }
}
