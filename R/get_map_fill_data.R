#' Get data to fill a map
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `get_map_fill_data()` prepares data to be used as fill in a map.
#'
#' @param data A [`tibble`][tibble::tibble] with the data to be used as fill.
#' @param col_fill (Optional) A [`character`][base::character] string with
#'   the column name to be used as fill. If `NULL`, the function will count
#'   the number of occurrences of each value in `col_code` (Default: `NULL`).
#' @param col_code A [`character`][base::character] string with the column
#'   name to be used as reference.
#' @param name_col_value (Optional) A [`character`][base::character] string
#'   with the name of the column to be used as value (Default: `"n"`).
#' @param name_col_ref (Optional) A [`character`][base::character] string
#'   with the name of the column to be used as reference (Default: `col_code`).
#' @param quiet (Optional) A [`logical`][base::logical] flag to suppress
#'   messages (Default: `FALSE`).
#'
#' @return A [`tibble`][tibble::tibble()].
#'
#' @family utility functions
#' @export
#'
#' @examples
#' library(dplyr)
#'
#' data <- tibble(
#'   state = c("SP", "RJ", "MG", "SP", "RJ", "MG"),
#'   value = c(1, 2, 3, 4, 5, 6)
#' )
#'
#' get_map_fill_data(data, col_fill = NULL, col_code = "state")
#'
#' get_map_fill_data(data, col_fill = "value", col_code = "state")
get_map_fill_data <- function(
    data, #nolint
    col_fill = NULL,
    col_code,
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) {
  checkmate::assert_tibble(data)
  checkmate::assert_string(col_fill, null.ok = TRUE)
  checkmate::assert_choice(col_fill, names(data), null.ok = TRUE)
  checkmate::assert_string(col_code)
  checkmate::assert_choice(col_code, names(data))
  checkmate::assert_string(name_col_value)
  checkmate::assert_string(name_col_ref)
  checkmate::assert_flag(quiet)

  if (is.null(col_fill)) {
    data |>
      dplyr::rename(!!as.symbol(name_col_ref) := !!as.symbol(col_code)) |>
      dplyr::select(!!as.symbol(name_col_ref)) |>
      tidyr::drop_na() |>
      dplyr::count(!!as.symbol(name_col_ref))
  } else {
    prettycheck::assert_numeric(data[[col_fill]], null_ok = TRUE)

    out <-
      data |>
      dplyr::rename(
        !!as.symbol(name_col_ref) := !!as.symbol(col_code),
        !!as.symbol(name_col_value) := !!as.symbol(col_fill)
      ) |>
      dplyr::select(!!as.symbol(name_col_ref), !!as.symbol(name_col_value)) |>
      tidyr::drop_na()

    if (any(duplicated(out[[name_col_ref]]))) {
      cli::cli_alert_warning(
        paste0(
          "There are duplicated values in ",
          "{.strong {cli::col_red(col_code)}}. ",
          "{.strong {cli::col_blue(col_fill)}} will be aggregated ",
          "using the mean."
        )
      ) |>
        rutils::shush(quiet)

      out |>
        dplyr::summarise(
          !!as.symbol(name_col_value) := mean(!!as.symbol(name_col_value)),
          .by = !!as.symbol(name_col_ref)
        )
    } else {
      out
    }
  }
}
