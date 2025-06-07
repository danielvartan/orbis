#' Get the closest year available in `geobr` package
#'
#' @description
#'
#' `get_closest_geobr_year()` returns the closest year available in the
#' [`geobr`][geobr::geobr] package for a specified type of data.
#'
#' @param year An [`integerish`][checkmate::test_integerish] vector with the
#'   year to find the closest available year in the `geobr` package.
#' @param type (optional) A string indicating the type of data to find the
#'   closest year for. It can be one of the following: `"municipality"`,
#'   `"municipal_seat"`, `"state"`, or `"country"` (default: `"country"`).
#' @param verbose (optional) A [`logical`][base::logical] flag indicating
#'   whether to print a warning message if the specified year is not available
#'  in the `geobr` package. Only applicable if `year` is a single value
#'  (default: `TRUE`).
#'
#' @return A [`numeric`][base::numeric] vector with the closest year available
#'   in the geobr package for the specified type of data.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' get_closest_geobr_year(2025, type = "municipality")
#' #> [1] 2022 # Expected
#'
#' get_closest_geobr_year(2025, type = "state")
#' #> [1] 2020 # Expected
#'
#' get_closest_geobr_year(2025, type = "country")
#' #> [1] 2020 # Expected
#'
#' get_closest_geobr_year(c(2025, 1999, NA, 1800), type = "country")
#' #> [1] 2020 2000   NA 1872 # Expected
get_closest_geobr_year <- function(
  year,
  type = "country",
  verbose = TRUE
) {
  type_choices <- c("municipality", "municipal_seat", "state", "country")

  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_choice(type, type_choices)
  checkmate::assert_flag(verbose)

  if (type == "municipality") {
    years <- c(
      1872, 1900, 1911, 1920, 1933, 1940, 1950, 1960, 1970, 1980, 1991, 2000,
      2001, 2005, 2007, 2010, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020,
      2021, 2022
    )
  } else if (type == "municipal_seat") {
    years <- c(
      1872, 1900, 1911, 1920, 1933, 1940, 1950, 1960, 1970, 1980, 1991, 2010
    )
  } else if (type == "state") {
    years <- c(
      1872, 1900, 1911, 1920, 1933, 1940, 1950, 1960, 1970, 1980, 1991, 2000,
      2001, 2010, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020
    )
  } else if (type == "country") {
    years <- c(
      1872, 1900, 1911, 1920, 1933, 1940, 1950, 1960, 1970, 1980, 1991, 2000,
      2001, 2010, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020
    )
  }

  out <- purrr::map_dbl(
    year,
    function(x) {
      ifelse(is.na(x), as.numeric(NA), years[which.min(abs(years - x))])
    }
  )

  if (isTRUE(verbose) && length(out) == 1 && year != out) {
    cli::cli_alert_warning(
      paste0(
        "The closest map year to {.strong {cli::col_red(year)}} is ",
        "{.strong {out}}. Using year {.strong {out}} instead."
      )
    )
  }

  out
}
