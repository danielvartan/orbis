#' Get Brazilian state names
#'
#' @description
#'
#' `brazil_state()` returns a vector with the names of Brazilian states.
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names or numeric codes of Brazilian regions or federal units.
#'   Municipality codes are also supported. If `NULL`,
#'   returns a [`character`][base::character()] vector with all Brazilian
#'   state names (default: `NULL`).
#'
#' @return A [`character`][base::character()] vector with the names of
#'   Brazilian states.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' brazil_state()
#'
#' brazil_state("rj")
#' #> [1] "Rio de Janeiro" # Expected
#'
#' brazil_state("rio de janeiro")
#' #> [1] "Rio de Janeiro" # Expected
#'
#' brazil_state(33)
#' #> [1] "Rio de Janeiro" # Expected
#'
#' brazil_state(3302700) # Maricá
#' #> [1] "Rio de Janeiro" # Expected
#'
#' brazil_state(33027001) # >7 digits
#' #> [1] NA # Expected
#'
#' brazil_state(39027001) # Non-existent state code
#' #> [1] NA # Expected
#'
#' brazil_state("southeast")
#' #> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" # Expected
#' #> [4] "São Paulo"
#'
#' brazil_state(3)
#' #> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" # Expected
#' #> [4] "São Paulo"
brazil_state <- function(x = NULL) {
  checkmate::assert_atomic(x)

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "brazil_state.R"))

  region_choices <- c(
    "north", "northeast", "south", "southeast", "central-west"
  )

  if (
    length(x) > 1 &&
      (
        any(x %in% region_choices, na.rm = TRUE) ||
          any(nchar(x) == 1, na.rm = TRUE)
      )
  ) {
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
  } else if (
    length(x) == 1 &&
      (
        all(x %in% region_choices, na.rm = TRUE) ||
          all(nchar(x) == 1, na.rm = TRUE)
      )
  ) {
    x <- x |> as.character() |> to_ascii() |> tolower()

    region_code <- dplyr::case_match(
      x,
      c("north", "1") ~ "north",
      c("northeast", "2") ~ "northeast",
      c("southeast", "3") ~ "southeast",
      c("south", "4") ~ "south",
      c("central-west", "5") ~ "central-west"
    )

    out <- switch(
      region_code,
      "north" = c(
        "Acre", "Amap\u00e1", "Amazonas", "Par\u00e1", "Rond\u00f4nia",
        "Roraima", "Tocantins"
      ),
      "northeast" = c(
        "Alagoas", "Bahia", "Cear\u00e1", "Maranh\u00e3o", "Para\u00edba",
        "Pernambuco", "Piau\u00ed", "Rio Grande do Norte", "Sergipe"
      ),
      "southeast" = c(
        "Esp\u00edrito Santo", "Minas Gerais", "Rio de Janeiro",
        "S\u00e3o Paulo"
      ),
      "south" = c("Paran\u00e1", "Rio Grande do Sul", "Santa Catarina"),
      "central-west" = c(
        "Distrito Federal", "Goi\u00e1s", "Mato Grosso",
        "Mato Grosso do Sul"
      )
    )

    if (length(out) == 0) as.character(NA) else out
  } else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_character_,
      stringr::str_starts(x, "12") ~ "Acre",
      stringr::str_starts(x, "27") ~ "Alagoas",
      stringr::str_starts(x, "16") ~ "Amap\u00e1",
      stringr::str_starts(x, "13") ~ "Amazonas",
      stringr::str_starts(x, "29") ~ "Bahia",
      stringr::str_starts(x, "23") ~ "Cear\u00e1",
      stringr::str_starts(x, "53") ~ "Distrito Federal",
      stringr::str_starts(x, "32") ~ "Esp\u00edrito Santo",
      stringr::str_starts(x, "52") ~ "Goi\u00e1s",
      stringr::str_starts(x, "21") ~ "Maranh\u00e3o",
      stringr::str_starts(x, "51") ~ "Mato Grosso",
      stringr::str_starts(x, "50") ~ "Mato Grosso do Sul",
      stringr::str_starts(x, "31") ~ "Minas Gerais",
      stringr::str_starts(x, "15") ~ "Par\u00e1",
      stringr::str_starts(x, "25") ~ "Para\u00edba",
      stringr::str_starts(x, "41") ~ "Paran\u00e1",
      stringr::str_starts(x, "26") ~ "Pernambuco",
      stringr::str_starts(x, "22") ~ "Piau\u00ed",
      stringr::str_starts(x, "33") ~ "Rio de Janeiro",
      stringr::str_starts(x, "24") ~ "Rio Grande do Norte",
      stringr::str_starts(x, "43") ~ "Rio Grande do Sul",
      stringr::str_starts(x, "11") ~ "Rond\u00f4nia",
      stringr::str_starts(x, "14") ~ "Roraima",
      stringr::str_starts(x, "42") ~ "Santa Catarina",
      stringr::str_starts(x, "35") ~ "S\u00e3o Paulo",
      stringr::str_starts(x, "28") ~ "Sergipe",
      stringr::str_starts(x, "17") ~ "Tocantins"
    )
  } else {
    x <- x |> as.character() |> to_ascii() |> tolower()

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
