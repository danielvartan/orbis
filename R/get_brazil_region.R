#' Get Brazilian regions
#'
#' @description
#'
#' `get_brazil_region()` returns a vector with the names of
#' [Brazilian regions](https://en.wikipedia.org/wiki/Regions_of_Brazil).
#'
#' @param x (optional) An [`atomic`][base::is.atomic()] vector containing the
#'   names, abbreviations, or numeric codes of Brazilian states or federal
#'   units. Region and municipality codes are also supported. If `NULL`,
#'   returns a vector with all Brazilian regions. (default: `NULL`)
#'
#' @return A [`character`][base::character()] vector with the names of
#'   Brazilian regions.
#'
#' @template details_brazil_a
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_region()
#' #> [1] "North" "Northeast" "South" "Southeast" "Central-West" # Expected
#'
#' get_brazil_region("sp")
#' #> [1] "Southeast" # Expected
#'
#' get_brazil_region("sao paulo")
#' #> [1] "Southeast" # Expected
#'
#' get_brazil_region(c(1, 4))
#' #> [1] "North" "South" # Expected
#'
#' get_brazil_region(35) # State of São Paulo
#' #> [1] "Southeast" # Expected
#'
#' get_brazil_region(3550308) # Municipality of São Paulo
#' #> [1] "Southeast" # Expected
#'
#' get_brazil_region(35503081) # >7 digits
#' #> [1] NA # Expected
get_brazil_region <- function(x = NULL) {
  checkmate::assert_atomic(x)

  if (is.null(x)) {
    c("North", "Northeast", "South", "Southeast", "Central-West")
  } else if (is.numeric(x)) {
    dplyr::case_when(
      !dplyr::between(nchar(x), 1, 7) ~ NA_character_,
      stringr::str_starts(x, "1") ~ "North",
      stringr::str_starts(x, "2") ~ "Northeast",
      stringr::str_starts(x, "3") ~ "Southeast",
      stringr::str_starts(x, "4") ~ "South",
      stringr::str_starts(x, "5") ~ "Central-West"
    )
  } else {
    x <- x |> as.character() |> to_ascii() |> tolower()

    dplyr::case_match(
      x,
      c("acre", "ac") ~ "North",
      c("alagoas", "al") ~ "Northeast",
      c("amapa", "ap") ~ "North",
      c("amazonas", "am") ~ "North",
      c("bahia", "ba") ~ "Northeast",
      c("ceara", "ce") ~ "Northeast",
      c("distrito federal", "df") ~ "Central-West",
      c("espirito santo", "es") ~ "Southeast",
      c("goias", "go") ~ "Central-West",
      c("maranhao", "ma") ~ "Northeast",
      c("mato grosso", "mt") ~ "Central-West",
      c("mato grosso do sul", "ms") ~ "Central-West",
      c("minas gerais", "mg") ~ "Southeast",
      c("para", "pa") ~ "North",
      c("paraiba", "pb") ~ "Northeast",
      c("parana", "pr") ~ "South",
      c("pernambuco", "pe") ~ "Northeast",
      c("piaui", "pi") ~ "Northeast",
      c("rio de janeiro", "rj") ~ "Southeast",
      c("rio grande do norte", "rn") ~ "Northeast",
      c("rio grande do sul", "rs") ~ "South",
      c("rondonia", "ro") ~ "North",
      c("roraima", "rr") ~ "North",
      c("santa catarina", "sc") ~ "South",
      c("sao paulo", "sp") ~ "Southeast",
      c("sergipe", "se") ~ "Northeast",
      c("tocantins", "to") ~ "North"
    )
  }
}
