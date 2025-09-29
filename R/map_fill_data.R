#' Prepare data to fill a map
#'
#' @description
#'
#' `map_fill_data()` prepares data to be used as fill in a map plot.
#'
#' @param data A [`tibble`][tibble::tibble] with the data to be used as fill.
#' @param col_fill (optional) A [`character`][base::character] string with
#'   the column name to be used as fill. If `NULL`, the function will count
#'   the number of occurrences of each value in `col_ref` (default: `NULL`).
#' @param col_ref A [`character`][base::character] string with the column
#'   name to be used as reference.
#' @param name_col_value (optional) A [`character`][base::character] string
#'   with the name of the column to be used as value (default: `"value"`).
#' @param name_col_ref (optional) A [`character`][base::character] string
#'   with the name of the column to be used as reference (default: `col_ref`).
#'
#' @return A [`tibble`][tibble::tibble()] with two columns:
#'   - `name_col_ref`: with unique values from `col_ref`.
#'   - `name_col_value`: with the values from `col_fill` or the count of
#'     occurrences of each value in `col_ref` (if `col_fill` is `NULL`).
#'
#' @family utility functions
#' @export
#'
#' @examples
#' # Set the Environment -----
#'
#' library(curl)
#' library(dplyr)
#' library(geodata)
#' library(ggplot2)
#' library(terra)
#' library(tidyterra)
#'
#' plot_vector_shape <- function(vector) {
#'   plot <-
#'     vector |>
#'     ggplot() +
#'     geom_spatvector(fill = "white", color = "#3243A6")
#'
#'   print(plot)
#' }
#'
#' plot_vector_data <- function(data, vector) {
#'   plot <-
#'     data |>
#'     ggplot() +
#'     geom_spatvector(aes(fill = value), color = "white") +
#'     scale_fill_continuous(
#'         palette = c("#072359", "#3243A6", "#9483AF"),
#'         na.value = "white"
#'     ) +
#'     labs(fill = NULL)
#'
#'   print(plot)
#' }
#'
#' # Define the Map -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_states_vector <- gadm("BRA", level = 1, path = tempdir())
#'   }
#' }
#'
#' # Visualize the Map -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_states_vector |> plot_vector_shape()
#'   }
#' }
#'
#' # Define the Data -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     data <- tibble(
#'       state = sample(
#'         brazil_states_vector$NAME_1, size = 1000, replace = TRUE
#'       ),
#'       value = sample(1:1000, size = 1000, replace = TRUE)
#'     )
#'
#'     data
#'   }
#' }
#'
#' # Create the Map Fill Data -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     data <- data |> map_fill_data(col_fill = "value", col_ref = "state")
#'
#'     data
#'   }
#' }
#'
#' # Visualize the Map Fill Data -----
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_states_vector |>
#'       left_join(data, by = c("NAME_1" = "state")) |>
#'       plot_vector_data()
#'   }
#' }
map_fill_data <- function(
  data,
  col_fill = NULL,
  col_ref,
  name_col_value = "value",
  name_col_ref = col_ref
) {
  checkmate::assert_tibble(data)
  checkmate::assert_string(col_fill, null.ok = TRUE)
  checkmate::assert_choice(col_fill, names(data), null.ok = TRUE)
  checkmate::assert_string(col_ref)
  checkmate::assert_choice(col_ref, names(data))
  checkmate::assert_string(name_col_value)
  checkmate::assert_string(name_col_ref)

  # R CMD Check variable bindings fix
  # nolint start
  n <- NULL
  # nolint end

  if (is.null(col_fill)) {
    data |>
      dplyr::rename(!!as.symbol(name_col_ref) := !!as.symbol(col_ref)) |>
      dplyr::select(!!as.symbol(name_col_ref)) |>
      tidyr::drop_na() |>
      dplyr::count(!!as.symbol(name_col_ref)) |>
      dplyr::rename(!!as.symbol(name_col_value) := n)
  } else {
    checkmate::assert_numeric(data[[col_fill]], null.ok = TRUE)

    out <-
      data |>
      dplyr::rename(
        !!as.symbol(name_col_ref) := !!as.symbol(col_ref),
        !!as.symbol(name_col_value) := !!as.symbol(col_fill)
      ) |>
      dplyr::select(!!as.symbol(name_col_ref), !!as.symbol(name_col_value)) |>
      tidyr::drop_na()

    if (any(duplicated(out[[name_col_ref]]), na.rm = TRUE)) {
      cli::cli_alert_warning(
        paste0(
          "There are duplicated values in ",
          "{.strong {cli::col_red(col_ref)}}. ",
          "{.strong {cli::col_blue(col_fill)}} will be aggregated ",
          "using the mean."
        )
      )

      out |>
        dplyr::summarize(
          !!as.symbol(name_col_value) := mean(!!as.symbol(name_col_value)),
          .by = !!as.symbol(name_col_ref)
        )
    } else {
      out
    }
  }
}
