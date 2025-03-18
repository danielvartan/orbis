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
#' the [`tidygeocoder`][tidygeocoder] R package.
#'
#' @param x (Optional) A [`character`][base::character] vector with the names
#'   of Brazilian states or federal units. If `NULL`, returns all state
#'   latitudes (Default: `NULL`).
#'
#' @return A [`character`][base::character] vector with the latitude of
#'   Brazilian states.
#'
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_latitude()
#'
#' get_brazil_state_latitude("sao paulo")
#' #> [1] -23.55065 # Expected
#'
#' get_brazil_state_latitude("sp")
#' #> [1] -23.55065 # Expected
get_brazil_state_latitude <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

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
  } else {
    x <- x |> groomr::to_ascii() |> tolower()

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
