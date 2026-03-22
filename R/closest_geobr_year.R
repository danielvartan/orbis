#' Get the closest year available in the `geobr` package
#'
#' @description
#'
#' `closest_geobr_year()` returns the closest year available in the
#' [`geobr`][geobr::geobr] package `read_*()` functions.
#'
#' @param year An [`integerish`][checkmate::test_integerish()] vector with the
#'   year to find the closest available year in the `geobr` package.
#' @param type (optional) A [`character`][base::character()] string indicating
#'   the type of data to find the closest year for. It must match one of the
#'   suffixes from the [`geobr`][geobr::geobr] package `read_*()` functions, for
#'   example: `"municipality"`, `"municipal_seat"`, `"state"`, or `"country"`
#'   (default: `"country"`).
#' @param verbose (optional) A [`logical`][base::logical()] flag indicating
#'   whether to print a warning message if the specified year is not available
#'  in the [`geobr`][geobr::geobr] package. Only applicable if `year` is a
#'  single value (default: `TRUE`).
#'
#' @return A [`numeric`][base::numeric()] vector with the closest year available
#'   in the [`geobr`][geobr::geobr] package for the specified type of data.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' closest_geobr_year(2026, type = "amazon")
#' #> [1] 2012 # Expected
#'
#' closest_geobr_year(2026, type = "biomes")
#' #> [1] 2019 # Expected
#'
#' closest_geobr_year(2026, type = "census_tract")
#' #> [1] 2022 # Expected
#'
#' closest_geobr_year(2026, type = "municipality")
#' #> [1] 2024 # Expected
#'
#' closest_geobr_year(2026, type = "municipal_seat")
#' #> [1] 2010 # Expected
#'
#' closest_geobr_year(2026, type = "state")
#' #> [1] 2020 # Expected
#'
#' closest_geobr_year(2026, type = "region")
#' #> [1] 2020 # Expected
#'
#' closest_geobr_year(2026, type = "country")
#' #> [1] 2020 # Expected
#'
#' closest_geobr_year(c(2026, 1999, NA, 1800), type = "country")
#' #> [1] 2020 2000   NA 1872 # Expected
closest_geobr_year <- function(
  year,
  type = "country",
  verbose = TRUE
) {
  type_choices <-
    getNamespaceExports("geobr") |>
    sort() |>
    stringr::str_subset("^read_") |>
    stringr::str_remove("^read_") |>
    stringr::str_subset("^capitals$", negate = TRUE)

  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_choice(type, type_choices)
  checkmate::assert_flag(verbose)

  years <- try(
    expr = {
      do.call(
        what = get(
          paste0("read_", type),
          envir = asNamespace("geobr")
        ),
        args = list(year = 0)
      )
    },
    silent = TRUE
  ) |>
    as.character() |>
    stringr::str_extract_all("\\d{4}") |>
    unlist() |>
    as.integer()

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
