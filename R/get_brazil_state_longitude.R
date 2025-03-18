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
#' the [`tidygeocoder`][tidygeocoder] R package.
#'
#' @param x (Optional) A [`character`][base::character] vector with the names
#'   of Brazilian states or federal units. If `NULL`, returns all state
#'   longitudes (Default: `NULL`).
#'
#' @return A [`character`][base::character] vector with the longitude of
#'   Brazilian states.
#'
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state_longitude()
#'
#' get_brazil_state_longitude("sao paulo")
#' #> [1] -46.63338 # Expected
#'
#' get_brazil_state_longitude("sp")
#' #> [1] -46.63338 # Expected
get_brazil_state_longitude <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

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
  } else {
    x <- x |> groomr::to_ascii() |> tolower()

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
