#' Fix postal code numbers
#'
#' @description
#'
#' `fix_postal_code()` provides tools to fix postal code numbers.
#'
#' @param postal_code A [`character`][base::character] vector with postal code
#'   numbers.
#' @param min_char (optional) An [integerish][checkmate::test_integerish]
#'   number with the minimum number of characters (default: `3`).
#' @param max_char (optional) An [integerish][checkmate::test_integerish]
#'   number with the maximum number of characters (default: `8`).
#' @param squish (optional) A [`logical`][base::logical] flag indicating
#'   whether to squish (i.e., remove leading, trailing, and extra spaces)
#'   the postal code numbers (default: `TRUE`).
#' @param remove_non_numeric (optional) A [`logical`][base::logical] flag
#'   indicating whether to remove non-numeric characters from the postal
#'   code numbers (default: `TRUE`).
#' @param remove_number_sequences (optional) A [`logical`][base::logical]
#'   flag indicating whether to remove number sequences from the postal
#'   code numbers. This is useful to remove postal code numbers like
#'   `11111111` (default: `TRUE`).
#' @param trunc (optional) A [`logical`][base::logical] flag indicating
#'   whether to truncate the postal code numbers to `max_char` width
#'   (default: `TRUE`).
#' @param pad (optional) A [`logical`][base::logical] flag indicating
#'   whether to pad the postal code numbers with zeros to `max_char`
#'   width (default: `TRUE`).
#' @param zero_na (optional) A [`logical`][base::logical] flag indicating
#'   whether to replace `NA` values with zeros (default: `FALSE`).
#'
#' @return A [`character`][base::character] vector with fixed postal code
#'   numbers.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' fix_postal_code("  01014908  ", squish = TRUE)
#' #> [1] "01014908" # Expected
#'
#' fix_postal_code("01014908", min_char = 10)
#' #> [1] NA # Expected
#'
#' fix_postal_code("01014908", max_char = 5, trunc = FALSE)
#' #> [1] NA # Expected
#'
#' fix_postal_code("A1C14D08", remove_non_numeric = TRUE, pad = TRUE)
#' #> [1] "11408000" # Expected
#'
#' fix_postal_code("123456789", remove_number_sequences = TRUE)
#' #> [1] NA # Expected
#'
#' fix_postal_code("01014908", max_char = 5, trunc = TRUE)
#' #> [1] "01014" # Expected
#'
#' fix_postal_code("01253", max_char = 8, pad = TRUE)
#' #> [1] "01253000" # Expected
#'
#' fix_postal_code(NA, max_char = 8, zero_na = TRUE)
#' #> [1] "00000000" # Expected
fix_postal_code <- function(
  postal_code,
  min_char = 3,
  max_char = 8,
  squish = TRUE,
  remove_non_numeric = TRUE,
  remove_number_sequences = TRUE,
  trunc = TRUE, # To `max_char` width
  pad = TRUE, # To `max_char` width
  zero_na = FALSE # To `max_char` width
) {
  checkmate::assert_atomic(postal_code)
  checkmate::assert_int(min_char, lower = 1)
  checkmate::assert_int(max_char, lower = 1)
  checkmate::assert_flag(squish)
  checkmate::assert_flag(remove_non_numeric)
  checkmate::assert_flag(remove_number_sequences)
  checkmate::assert_flag(trunc)
  checkmate::assert_flag(pad)
  checkmate::assert_flag(zero_na)

  postal_code <- postal_code |> as.character()

  if (isTRUE(squish)) postal_code <- postal_code |> stringr::str_squish()

  postal_code <- dplyr::case_when(
    nchar(postal_code) < min_char ~ NA_character_,
    nchar(postal_code) > max_char & trunc == FALSE ~ NA_character_,
    TRUE ~ postal_code
  )

  if (isTRUE(remove_non_numeric)) {
    postal_code <- postal_code |> stringr::str_remove_all("\\D+")
  }

  if (isTRUE(trunc)) {
    postal_code <-
      postal_code |>
      stringr::str_trunc(
        width = max_char,
        side = "right",
        ellipsis = ""
      )
  }

  if (isTRUE(remove_number_sequences)) {
    for (i in seq(0, 9)) {
      postal_code <-
        dplyr::if_else(
          postal_code |>
            stringr::str_detect(paste0("^", i, "{1,}$")),
          NA_character_,
          postal_code
        )
    }

    sequence_string <- character()

    for (i in seq(1, max_char)) {
      sequence_string <- paste0(sequence_string, i)

      postal_code <-
        dplyr::if_else(
          postal_code |>
            stringr::str_detect(paste0("^", sequence_string, "{1,}$")),
          NA_character_,
          postal_code
        )
    }
  }

  if (isTRUE(pad)) {
    postal_code <-
      postal_code |>
      stringr::str_pad(
        width = max_char,
        side = "right",
        pad = "0"
      )
  }

  postal_code <- dplyr::if_else(postal_code == "", NA_character_, postal_code)

  if (isTRUE(zero_na)) {
    postal_code <- dplyr::if_else(is.na(postal_code), "00000000", postal_code)
  }

  postal_code
}
