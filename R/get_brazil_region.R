#' Get Brazilian regions
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_brazil_region()` returns a vector with the names of
#' [Brazilian regions](https://en.wikipedia.org/wiki/Regions_of_Brazil).
#'
#' @param x (Optional) A [`character`][base::character()] vector with the names
#'   of Brazilian states or federal unit abbreviations. If `NULL`, returns all
#'   Brazilian regions (Default: `NULL`).
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
#' #> [1] "Central-West" "North" "Northeast" "South" "Southeast" # Expected
#'
#' get_brazil_region("sao paulo")
#' #> [1] "Southeast" # Expected
#'
#' get_brazil_region("sp")
#' #> [1] "Southeast" # Expected
get_brazil_region <- function(x = NULL) {
  checkmate::assert_character(x, null.ok = TRUE)

  if (!is.null(x)) x <- x |> to_ascii() |> tolower()

  if (is.null(x)) {
    c("Central-West", "North", "Northeast", "South", "Southeast")
  } else {

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
