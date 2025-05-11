#' Render Brazilian addresses
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `render_brazil_address()`
#'
#' @param street (optional) A [`character`][base::character] vector with the
#'   street names (default: `NA_character`).
#' @param complement (optional) A [`character`][base::character] vector with
#'   the complement of the address (default: `NA_character`).
#' @param neighborhood (optional) A [`character`][base::character] vector with
#'   the neighborhood names (default: `NA_character`).
#' @param municipality (optional) A [`character`][base::character] vector
#'   with the name of the municipalities (default: `NA_character`).
#' @param state (optional) A [`character`][base::character] vector with the
#'   name of the states (default: `NA_character`).
#' @param postal_code (optional) A [`character`][base::character] vector with
#'   the postal codes (default: `NA_character`).
#'
#' @return A [`character`][base::character] vector with the formatted address.
#'
#' @family Brazil functions
#' @export
#'
#' @examples
#' render_brazil_address(
#'   street = c("Viaduto do Chá, 15", "Alameda Ribeiro da Silva, 919"),
#'   complement = c("", "Ap. 502"),
#'   neighborhood = c("Centro", "Campos Elíseos"),
#'   municipality = c("São Paulo", "São Paulo"),
#'   state = c("SP", "SP"),
#'   postal_code = c("01002-020", "01217-010")
#' )
render_brazil_address <- function(
  street = NA_character_,
  complement = NA_character_,
  neighborhood = NA_character_,
  municipality = NA_character_,
  state = NA_character_,
  postal_code = NA_character_
) {
  checkmate::assert_character(street)
  checkmate::assert_character(complement)
  checkmate::assert_character(neighborhood)
  checkmate::assert_character(municipality)
  checkmate::assert_character(state)
  checkmate::assert_character(
    postal_code,
    pattern = "^\\d{8}$|^\\d{5}-\\d{3}$"
  )
  prettycheck::assert_identical(
    street, complement, neighborhood, municipality, state, postal_code,
    type = "length"
  )

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  postal_code <- fix_postal_code(postal_code)

  out <- character()

  for (i in seq_along(postal_code)) {
    out <-
      glue::glue(
        ifelse(street[i] %in% c(NA, "", "NA"), "", "{street[i]}, "),
        ifelse(
          complement[i] %in% c(NA, "", "NA"),
          "",
          "{complement[i]}, "
        ),
        ifelse(
          neighborhood[i] %in% c(NA, "", "NA"),
          "",
          "{neighborhood[i]}, "
        ),
        dplyr::case_when(
          !(municipality[i] %in% c(NA, "", "NA")) &
            !(state[i] %in% c(NA, "", "NA")) ~
            "{municipality[i]}-{get_brazil_fu(state[i])}, ",
          (municipality[i] %in% c(NA, "", "NA")) &
            !(state[i] %in% c(NA, "", "NA")) ~
            "{get_brazil_fu(state[i])}, ",
          !(municipality[i] %in% c(NA, "", "NA")) ~ "{municipality[i]}, ",
          TRUE ~ ""
        ),
        ifelse(
          postal_code[i] %in% c(NA, "", "NA"),
          "",
          paste0(
            "{stringr::str_sub(postal_code[i], 1, 5)}",
            "-",
            "{stringr::str_sub(postal_code[i], 6, 8)}",
            ", "
          )
        ),
        "Brasil",
        .na = "",
        .null = ""
      ) |>
      as.character() %>%
      append(out, .)
  }

  out
}
