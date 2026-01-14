#' Get URLs to WorldClim data
#'
#' @description
#'
#' `worldclim_url()` returns the URL(s) of a
#' [WorldClim](https://worldclim.org/) data series.
#'
#' @return A named [`character`][base::character()] vector with the URL(s) of
#'   the [WorldClim](https://worldclim.org/) data series.
#'
#' @inheritParams worldclim_file
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
#'
#' worldclim_url(c("hcd", "hmwd", "fcd"), c("5m", "30s"))
worldclim_url <- function(series, resolution = NULL) {
  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  grid <- list()

  for (i in ls()[-1]) {
    if (!is.null(get(i))) grid[[i]] <- get(i)
  }

  grid |>
    expand.grid() |>
    magrittr::set_names(names(grid)) |>
    purrr::map(as.character) |>
    purrr::pmap(worldclim_url.scalar) |>
    unlist(use.names = TRUE) %>%
    magrittr::extract(!duplicated(.))
}

worldclim_url.scalar <- function(series, resolution = NULL) {
  #nolint
  checkmate::assert_choice(
    if (!is.null(series)) series |> tolower(),
    worldclim_variables |> magrittr::extract2("series_choices")
  )

  checkmate::assert_choice(
    if (!is.null(resolution)) resolution |> tolower(),
    worldclim_variables |> magrittr::extract2("resolution_choices"),
    null.ok = TRUE
  )

  if (
    series %in%
      c(
        "hcd",
        "historical-climate-data",
        "historical climate data"
      )
  ) {
    "https://worldclim.org/data/worldclim21.html" |>
      magrittr::set_names("Historical climate data")
  } else if (
    series %in%
      c(
        "hmwd",
        "historical-monthly-weather-data",
        "historical monthly weather data"
      )
  ) {
    "https://worldclim.org/data/monthlywth.html" |>
      magrittr::set_names("Historical monthly weather data")
  } else if (
    series %in%
      c(
        "fcd",
        "future-climate-data",
        "future climate data"
      )
  ) {
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

    if (is.null(resolution)) {
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
