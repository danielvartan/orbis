#' Get Brazilian state names
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_state()` returns a vector with the names of Brazilian states.
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian federal units or regions. If `NULL`, returns all state names
#'   (Default: `NULL`).
#'
#' @return A [`character`][base::character()] vector with the names of
#'   Brazilian states.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_state()
#'
#' get_brazil_state("rj")
#' #> [1] "Rio de Janeiro" # Expected
#'
#' get_brazil_state("southeast")
#' #> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro"
#' #> [4] "São Paulo"
get_brazil_state <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "get_brazil_state.R"))

  if (!is.null(x)) x <- x |> groomr::to_ascii() |> tolower()

  region_choices <- c(
    "central-west", "north", "northeast", "south", "southeast"
  )

  if (length(x) > 1 && any(x %in% region_choices, na.rm = TRUE)) {
    cli::cli_abort(
      paste0(
        "When searching for ",
        "{.strong {cli::col_red('regions')}}, ",
        "only one region can be specified at a time."
      )
    )
  }

  if (is.null(x)) {
    c(
      "Acre", "Alagoas", "Amap\u00e1", "Amazonas", "Bahia", "Cear\u00e1",
      "Distrito Federal", "Esp\u00edrito Santo", "Goi\u00e1s", "Maranh\u00e3o",
      "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Par\u00e1",
      "Para\u00edba", "Paran\u00e1", "Pernambuco", "Piau\u00ed",
      "Rio de Janeiro", "Rio Grande do Norte", "Rio Grande do Sul",
      "Rond\u00f4nia", "Roraima", "Santa Catarina", "S\u00e3o Paulo",
      "Sergipe", "Tocantins"
    )
  } else if (length(x) == 1 && all(x %in% region_choices)) {
    out <- character()

    for (i in x) {
      out <- c(
        out,
        switch(
          i,
          "central-eest" = c(
            "Distrito Federal", "Goi\u00e1s", "Mato Grosso",
            "Mato Grosso do Sul"
          ),
          "north" = c(
            "Acre", "Amap\u00e1", "Amazonas", "Par\u00e1", "Rond\u00f4nia",
            "Roraima", "Tocantins"
          ),
          "northeast" = c(
            "Alagoas", "Bahia", "Cear\u00e1", "Maranh\u00e3o", "Para\u00edba",
            "Pernambuco", "Piau\u00ed", "Rio Grande do Norte", "Sergipe"
          ),
          "south" = c("Paran\u00e1", "Rio Grande do Sul", "Santa Catarina"),
          "southeast" = c(
            "Esp\u00edrito Santo", "Minas Gerais", "Rio de Janeiro",
            "S\u00e3o Paulo"
          )
        )
      )
    }

    if (length(out) == 0) as.character(NA) else out
  } else {
    dplyr::case_match(
      x,
      c("acre", "ac") ~ "Acre",
      c("alagoas", "al") ~ "Alagoas",
      c("amapa", "ap") ~ "Amap\u00e1",
      c("amazonas", "am") ~ "Amazonas",
      c("bahia", "ba") ~ "Bahia",
      c("ceara", "ce") ~ "Cear\u00e1",
      c("distrito federal", "df") ~ "Distrito Federal",
      c("espirito santo", "es") ~ "Esp\u00edrito Santo",
      c("goias", "go") ~ "Goi\u00e1s",
      c("maranhao", "ma") ~ "Maranh\u00e3o",
      c("mato grosso", "mt") ~ "Mato Grosso",
      c("mato grosso do sul", "ms") ~ "Mato Grosso do Sul",
      c("minas gerais", "mg") ~ "Minas Gerais",
      c("para", "pa") ~ "Par\u00e1",
      c("paraiba", "pb") ~ "Para\u00edba",
      c("parana", "pr") ~ "Paran\u00e1",
      c("pernambuco", "pe") ~ "Pernambuco",
      c("piaui", "pi") ~ "Piau\u00ed",
      c("rio de janeiro", "rj") ~ "Rio de Janeiro",
      c("rio grande do norte", "rn") ~ "Rio Grande do Norte",
      c("rio grande do sul", "rs") ~ "Rio Grande do Sul",
      c("rondonia", "ro") ~ "Rond\u00f4nia",
      c("roraima", "rr") ~ "Roraima",
      c("santa catarina", "sc") ~ "Santa Catarina",
      c("sao paulo", "sp") ~ "S\u00e3o Paulo",
      c("sergipe", "se") ~ "Sergipe",
      c("tocantins", "to") ~ "Tocantins"
    )
  }
}
