#' Return a random WorldClim data selection
#'
#' @description
#'
#' `worldclim_random()` returns a random selection of parameters for
#' downloading [WorldClim](https://worldclim.org/) data.
#'
#' @param series A string indicating the [WorldClim](https://worldclim.org/)
#'   data series to use. The following options are available:
#'   - `'hcd'` (Historical Climate Data).
#'   - `'hmwd'` (Historical Monthly Weather Data).
#'   - `'fcd'` (Future Climate Data).
#'
#' @return A [`list`][base::list()] with a random selection of parameters for
#'   downloading WorldClim data. The list contains the following elements:
#'   - `series`: The selected data series.
#'   - `resolution`: The selected spatial resolution.
#'   - `variable`: The selected climate variable.
#'   - `bioclimatic_variable`: The selected bioclimatic variable (only for
#'      Historical Climate Data and Future Climate Data when `variable` is
#'      set to `"bioc"`).
#'   - `model`: The selected climate model (only for Future Climate Data).
#'   - `ssp`: The selected Shared Socioeconomic Pathway (only for Future
#'      Climate Data).
#'   - `year`: The selected year or year range.
#'   - `month`: The selected month.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' worldclim_random("hcd")
#'
#' worldclim_random("hmwd")
#'
#' worldclim_random("fcd")
worldclim_random <- function(series = "hcd") {
  checkmate::assert_choice(tolower(series), worldclim_variables$series_choices)

  if (
    series %in%
      c(
        "hcd",
        "historical-climate-data",
        "historical climate data"
      )
  ) {
    out <- list(
      series = c("Historical Climate Data" = "hcd"),
      resolution = worldclim_variables |>
        magrittr::extract2("resolutions") |>
        sample(1),
      variable = worldclim_variables |>
        magrittr::extract2("hcd_variables") |>
        sample(1),
      year = worldclim_variables |>
        magrittr::extract2("hcd_years") |>
        sample(1),
      month = worldclim_variables |>
        magrittr::extract2("months") |>
        sample(1)
    )

    if (out$variable == "bioc") {
      append(
        out,
        list(
          bioclimatic_variable = worldclim_variables |>
            magrittr::extract2("bioclimatic_variables") |>
            sample(1)
        ),
        after = 3
      )
    } else if (out$variable == "elev") {
      out[c("month", "year")] <- NULL

      out
    } else {
      out
    }
  } else if (
    series %in%
      c(
        "hmwd",
        "historical-monthly-weather-data",
        "historical monthly weather data"
      )
  ) {
    list(
      series = c("Historical Monthly Weather Data" = "hmwd"),
      resolution = worldclim_variables |>
        magrittr::extract2("resolutions") |>
        magrittr::extract(
          stringr::str_detect(
            worldclim_variables |>
              magrittr::extract2("resolutions") |>
              names(),
            "30 Seconds",
            negate = TRUE
          )
        ) |>
        sample(1),
      variable = worldclim_variables |>
        magrittr::extract2("hmwd_variables") |>
        sample(1),
      year = worldclim_variables |>
        magrittr::extract2("hmwd_years") |>
        sample(1),
      month = worldclim_variables |>
        magrittr::extract2("months") |>
        sample(1)
    )
  } else if (
    series %in%
      c(
        "fcd",
        "future-climate-data",
        "future climate data"
      )
  ) {
    out <- list(
      series = c("Future Climate Data" = "fcd"),
      resolution = worldclim_variables |>
        magrittr::extract2("resolutions") |>
        sample(1),
      variable = worldclim_variables |>
        magrittr::extract2("fcd_variables") |>
        sample(1),
      model = worldclim_variables |>
        magrittr::extract2("models") |>
        sample(1),
      ssp = worldclim_variables |>
        magrittr::extract2("ssps") |>
        sample(1),
      year = worldclim_variables |>
        magrittr::extract2("fcd_years") |>
        sample(1),
      month = worldclim_variables |>
        magrittr::extract2("months") |>
        sample(1)
    )

    if (out$variable == "bioc") {
      append(
        out,
        list(
          bioclimatic_variable = worldclim_variables |>
            magrittr::extract2("bioclimatic_variables") |>
            sample(1)
        ),
        after = 3
      )
    } else {
      out
    }
  }
}
