#' Get Brazilian federative unit abbreviations
#'
#' @description
#'
#' `get_brazil_fu()` returns a vector with the abbreviations of
#' Brazilian federal units.
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names or numeric codes of Brazilian regions or federal units.
#'   Municipality codes are also supported. If `NULL`,
#'   returns a [`character`][base::character()] vector with all Brazilian
#'   federal unit abbreviations (default: `NULL`).
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
#' get_brazil_fu("sp")
#' #> [1] "SP" # Expected
#'
#' get_brazil_fu("sao paulo")
#' #> [1] "SP" # Expected
#'
#' get_brazil_fu(35)
#' #> [1] "SP" # Expected
#'
#' get_brazil_fu(3550308) # Municipality of São Paulo
#' #> [1] "SP" # Expected
#'
#' get_brazil_fu(35503081) # >7 digits
#' #> [1] NA # Expected
#'
#' get_brazil_fu(39027001) # Non-existent state code
#' #> [1] NA # Expected
#'
#' get_brazil_fu("southeast")
#' #> [1] "ES" "MG" "RJ" "SP" # Expected
#'
#' get_brazil_fu(3)
#' #> [1] "ES" "MG" "RJ" "SP" # Expected
get_brazil_fu <- function(x = NULL) {
  checkmate::assert_atomic(x)

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
      "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT",
      "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO",
      "RR", "SC", "SP", "SE", "TO"
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
      "north" = c("AC", "AP", "AM", "PA", "RO", "RR", "TO"),
      "northeast" = c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE"),
      "southeast" = c("ES", "MG", "RJ", "SP"),
      "south" = c("PR", "RS", "SC"),
      "central-west" = c("DF", "GO", "MT", "MS")
    )

    if (length(out) == 0) as.character(NA) else out
  } else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_character_,
      stringr::str_starts(x, "12") ~ "AC",
      stringr::str_starts(x, "27") ~ "AL",
      stringr::str_starts(x, "16") ~ "AP",
      stringr::str_starts(x, "13") ~ "AM",
      stringr::str_starts(x, "29") ~ "BA",
      stringr::str_starts(x, "23") ~ "CE",
      stringr::str_starts(x, "53") ~ "DF",
      stringr::str_starts(x, "32") ~ "ES",
      stringr::str_starts(x, "52") ~ "GO",
      stringr::str_starts(x, "21") ~ "MA",
      stringr::str_starts(x, "51") ~ "MT",
      stringr::str_starts(x, "50") ~ "MS",
      stringr::str_starts(x, "31") ~ "MG",
      stringr::str_starts(x, "15") ~ "PA",
      stringr::str_starts(x, "25") ~ "PB",
      stringr::str_starts(x, "41") ~ "PR",
      stringr::str_starts(x, "26") ~ "PE",
      stringr::str_starts(x, "22") ~ "PI",
      stringr::str_starts(x, "33") ~ "RJ",
      stringr::str_starts(x, "24") ~ "RN",
      stringr::str_starts(x, "43") ~ "RS",
      stringr::str_starts(x, "11") ~ "RO",
      stringr::str_starts(x, "14") ~ "RR",
      stringr::str_starts(x, "42") ~ "SC",
      stringr::str_starts(x, "35") ~ "SP",
      stringr::str_starts(x, "28") ~ "SE",
      stringr::str_starts(x, "17") ~ "TO"
    )
  } else {
    x <- x |> as.character() |> to_ascii() |> tolower()

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
