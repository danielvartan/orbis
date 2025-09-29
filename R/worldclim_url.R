#' Get paths to WorldClim data
#'
#' @description
#'
#' `worldclim_url()` returns the URL(s) of a
#' [WorldClim](https://worldclim.org/) data series.
#'
#' @param series A [`character`][base::character()] vector with the name of the
#'   [WorldClim](https://worldclim.org/) data series (default: `"hcd"`).
#'   The following options are available:
#'   - `'hcd'` (Historical Climate Data).
#'   - `'hmwd'` (Historical Monthly Weather Data).
#'   - `'fcd'` (Future Climate Data).
#' @param resolution (optional) A [`character`][base::character()] vector with
#'   the resolution of the [WorldClim](https://worldclim.org/) data series
#'   (default: `"all"`). The following options are available:
#'   - `"all"` returns all available resolutions.
#'   - `"10m"` returns the 10m resolution.
#'   - `"5m"` returns the 5m resolution.
#'   - `"2.5m"` returns the 2.5m resolution.
#'   - `"30s"` returns the 30s resolution.
#'
#' @return A named [`character`][base::character()] vector with the URL(s) of
#'   the [WorldClim](https://worldclim.org/) data series.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' worldclim_url("hcd")
#'
#' worldclim_url("hmwd")
#'
#' worldclim_url("fcd")
#'
#' worldclim_url("fcd", "10m")
#'
#' worldclim_url(c("hcd", "hmwd", "fcd"))
#'
#' worldclim_url(c("hcd", "hmwd", "fcd"), "5m")
worldclim_url <- function(series, resolution = "all") {
  checkmate::assert_choice(
    if (!is.null(resolution)) resolution |> tolower(),
    c("all", "10m", "5m", "2.5m", "30s"),
    null.ok = TRUE
  )

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  lapply(
    X = series,
    FUN = get_wc_url_scalar,
    resolution = resolution
  ) |>
    unlist(use.names = TRUE) %>%
    magrittr::extract(!duplicated(.))
}

get_wc_url_scalar <- function(series, resolution = NULL) {
  series_choices <- c(
    "hcd", "historical-climate-data", "historical climate data",
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data",
    "fcd", "future-climate-data", "future climate data"
  )

  resolution_choices <- c("all", "10m", "5m", "2.5m", "30s")

  checkmate::assert_choice(
    if (!is.null(series)) series |> tolower(),
    series_choices
  )

  checkmate::assert_choice(
    if (!is.null(resolution)) resolution |> tolower(),
    resolution_choices,
    null.ok = TRUE
  )

  if (series %in% c(
    "hcd", "historical-climate-data", "historical climate data"
  )) {
    "https://worldclim.org/data/worldclim21.html" |>
      magrittr::set_names("Historical climate data")
  } else if (series %in% c(
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data"
  )) {
    "https://worldclim.org/data/monthlywth.html" |>
      magrittr::set_names("Historical monthly weather data")
  } else if (series %in% c(
    "fcd", "future-climate-data", "future climate data"
  )) {
    out <-
      c(
        "https://worldclim.org/data/cmip6/cmip6_clim10m.html",
        "https://worldclim.org/data/cmip6/cmip6_clim5m.html",
        "https://worldclim.org/data/cmip6/cmip6_clim2.5m.html",
        "https://worldclim.org/data/cmip6/cmip6_clim30s.html"
      ) |>
      magrittr::set_names(
        c(
          "Future climate data (10m)",
          "Future climate data (5m)",
          "Future climate data (2.5m)",
          "Future climate data (30s)"
        )
      )

    if (resolution == "all" || is.null(resolution)) {
      out
    } else {
      out |>
        magrittr::extract(
          stringr::str_detect(
            names(out),
            paste0("(?<=\\()", resolution)
          )
        )
    }
  }
}
