#' Get Brazilian federative unit abbreviations
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_fu()` returns a vector with the abbreviations of
#' Brazilian federal units.
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian states or regions. If `NULL`, returns all federal unit
#'   abbreviations (Default: `NULL`).
#'
#' @return A [`character`][base::character()] vector with the abbreviations of
#'   Brazilian federal units.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_fu()
#'
#' get_brazil_fu("sao paulo")
#' #> [1] "SP" # Expected
#'
#' get_brazil_fu("southeast")
#' #> [1] "ES" "MG" "RJ" "SP" # Expected
get_brazil_fu <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

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
      "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT",
      "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO",
      "RR", "SC", "SE", "SP", "TO"
    )
  } else if (length(x) == 1 && all(x %in% region_choices)) {
    out <- character()

    for (i in x) {
      out <- c(
        out,
        switch(
          i,
          "central-west" = c("DF", "GO", "MT", "MS"),
          "north" = c("AC", "AP", "AM", "PA", "RO", "RR", "TO"),
          "northeast" = c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE"),
          "south" = c("PR", "RS", "SC"),
          "southeast" = c("ES", "MG", "RJ", "SP")
        )
      )
    }

    if (length(out) == 0) as.character(NA) else out
  } else {
    dplyr::case_match(
      x,
      c("acre", "ac") ~ "AC",
      c("alagoas", "al") ~ "AL",
      c("amapa", "ap") ~ "AP",
      c("amazonas", "am") ~ "AM",
      c("bahia", "ba") ~ "BA",
      c("ceara", "ce") ~ "CE",
      c("distrito federal", "df") ~ "DF",
      c("espirito santo", "es") ~ "ES",
      c("goias", "go") ~ "GO",
      c("maranhao", "ma") ~ "MA",
      c("mato grosso", "mt") ~ "MT",
      c("mato grosso do sul", "ms") ~ "MS",
      c("minas gerais", "mg") ~ "MG",
      c("para", "pa") ~ "PA",
      c("paraiba", "pb") ~ "PB",
      c("parana", "pr") ~ "PR",
      c("pernambuco", "pe") ~ "PE",
      c("piaui", "pi") ~ "PI",
      c("rio de janeiro", "rj") ~ "RJ",
      c("rio grande do norte", "rn") ~ "RN",
      c("rio grande do sul", "rs") ~ "RS",
      c("rondonia", "ro") ~ "RO",
      c("roraima", "rr") ~ "RR",
      c("santa catarina", "sc") ~ "SC",
      c("sao paulo", "sp") ~ "SP",
      c("sergipe", "se") ~ "SE",
      c("tocantins", "to") ~ "TO"
    )
  }
}
