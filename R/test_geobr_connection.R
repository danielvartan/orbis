#' Test `geobr` package connection with its server
#'
#' @description
#'
#' `test_geobr_connection()` tests if the `geobr` package can successfully
#' connect to its server and retrieve data.
#'
#' **Note:** This function requires an active internet connection and the
#' [`geobr`](https://ipeagit.github.io/geobr/) package to be installed.
#'
#' @return A [`logical`][base::logical()] flag indicating if the connection
#'   was successful.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' \dontrun{
#'   library(geobr)
#'   library(httr2)
#'
#'   if (is_online()) {
#'     test_geobr_connection()
#'   }
#' }
test_geobr_connection <- function() {
  require_package("geobr")

  assert_internet()

  test <-
    read_country(cache = FALSE, showProgress = FALSE) |>
    try(silent = TRUE) |>
    suppressMessages() |>
    suppressWarnings()

  if (!inherits(test, "try-error")) {
    TRUE
  } else {
    FALSE
  }
}
