#' Get and aggregate data by year from SIDRA API
#'
#' @description
#'
#' `sidra_download_by_year()` retrieves data from the Brazilian Institute of
#' Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) Automatic
#' Retrieval System ([SIDRA](https://sidra.ibge.gov.br/)) API for a specified
#' range of years.
#'
#' This function addresses the SIDRA API's limitations on the volume of data
#' that can be downloaded in a single request. It downloads data for each year
#' individually and then combines the results into a single data frame.
#'
#' **Note:** This function requires an active internet connection and the
#' [`sidrar`](https://CRAN.R-project.org/package=sidrar) package to be
#' installed.
#'
#' @details
#'
#' To construct the API call, follow these steps:
#'
#' 1. Visit the SIDRA website.
#' 2. Locate the desired table containing your data.
#' 3. Configure the parameters for data retrieval (e.g., variable, sex, years).
#' 4. Click the share button (link symbol) at the end of the page.
#' 5. If a checkbox labeled *Usar períodos relativos, quando possível.* appears,
#'    uncheck it, reload the page, and click the share button again.
#' 6. Copy the portion of the *Parâmetros para a API* URL that starts with `/t`
#'    (e.g., `/t/6407...`).
#'
#' You need to provide the function with separate parts of the API URL. For
#' example:
#'
#' ```
#' |-------- Start ------|--- Years ----|----- End -----|
#' /t/6407/n6/all/v/606/p/2021,2022,2023/c2/6794/c58/1140
#' ```
#'
#' If you have difficulty identifying the correct segments, try adjusting the
#' table settings, selecting different years, and examining how the URL changes.
#'
#' @param years An [`integerish`][checkmate::check_integerish()] vector with the
#'   years to download.
#' @param api_start A string specifying the initial part of the SIDRA API URL,
#'   up to (but not including) the year segment. See the Details section for
#'   guidance.
#' @param api_end A string specifying the final part of the SIDRA API URL,
#'   immediately following the year segment. See the Details section for
#'   guidance.
#'
#' @return A [tibble][tibble::tibble()] containing the combined data for all
#'   requested years, as retrieved from the SIDRA API.
#'
#' @family other functions.
#' @export
#'
#' @examples
#' library(curl)
#' library(dplyr)
#'
#' \dontrun{
#'   if (has_internet()) {
#'     sidra_download_by_year(
#'       years = 2010:2011,
#'       api_start = "/t/1612/n6/all/v/109/p/",
#'       api_end = "/c81/2692"
#'     ) |>
#'       glimpse()
#'   }
#' }
sidra_download_by_year <- function(years, api_start, api_end) {
  require_pkg("sidrar")

  assert_internet()
  checkmate::assert_integerish(years)
  checkmate::assert_string(api_start)
  checkmate::assert_string(api_end)

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  out <- list()

  for (i in years) {
    cli::cli_progress_step(
      msg = paste0("Downloading data from ", i),
      spinner = TRUE
    )

    data_i <-
      paste0(api_start, i, api_end) %>% # Don't change the pipe.
      get_sidra(api = .) |>
      try(silent = TRUE)

    if (inherits(data_i, "try-error")) {
      error_message <- attributes(data_i)$condition$message #nolint

      cli::cli_alert_warning(paste0(
        "Failed to get data for year ",
        "{.strong {cli::col_red(i)}}.\n\n",
        "{.strong Error message}: ",
        "{cli::col_grey(error_message)}"
      ))
    } else {
      out[[paste("year_", i)]] <- data_i |> dplyr::as_tibble()
    }
  }

  out |> dplyr::bind_rows()
}
