#' Get file paths to WorldClim data
#'
#' @description
#'
#' `worldclim_file()` returns the file path(s) of a
#' [WorldClim](https://worldclim.org/) data series.
#'
#'
#'
#' @return A [`character`][base::character()] vector with the file path(s) of
#'   the [WorldClim](https://worldclim.org/) data series.
#'
#' @template params_worldclim_a
#' @family WorldClim functions
#' @export
#'
#' @examples
#' library(curl)
#'
#' \dontrun{
#'   if (has_internet()) {
#'     worldclim_file(series = "hcd")
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     worldclim_file(
#'       series = "hcd",
#'       resolution = c("10m", "30s"),
#'       variable = c("tmin", "tavg"))
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     worldclim_file(
#'       series = "hmwd",
#'       resolution = c("10m", "5m"),
#'       variable = "tmin",
#'       year = c("1950-1959", "2020-2024")
#'     )
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     worldclim_file(
#'       series = "fcd",
#'       resolution = c("2.5m", "30s"),
#'       variable = c("tmin"),
#'       model = c("MIROC6", "GISS-E2-1-G"),
#'       ssp = c("ssp126", "ssp585"),
#'       year = "2021-2040"
#'     )
#'   }
#' }
worldclim_file <- function(
  series,
  resolution = NULL,
  variable = NULL,
  model = NULL,
  ssp = NULL,
  year = NULL
) {
  require_pkg("rvest")

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  grid <- list()

  for (i in ls()[-1]) if (!is.null(get(i))) grid[[i]] <- get(i)

  grid |>
    expand.grid() |>
    magrittr::set_names(names(grid)) |>
    purrr::map(as.character) |>
    purrr::pmap(worldclim_file.scalar) |>
    unlist(use.names = TRUE) %>%
    magrittr::extract(!duplicated(.))
}

worldclim_file.scalar <- function(
  series,
  resolution = NULL,
  variable = NULL,
  model = NULL,
  ssp = NULL,
  year = NULL
) {
  require_pkg("curl", "rvest")

  assert_internet()

  checkmate::assert_choice(
    if (!is.null(series)) series |> tolower(),
     worldclim_variables |> magrittr::extract2("series_choices")
  )

  checkmate::assert_choice(
    if (!is.null(resolution)) resolution |> tolower(),
    worldclim_variables |> magrittr::extract2("resolution_choices"),
    null.ok = TRUE
  )

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  series <- worldclim_normalize_series(series)
  html <- worldclim_url.scalar(series, resolution) |> rvest::read_html()

  out <-
    html |>
    rvest::html_elements("a") |>
    rvest::html_attr("href") |>
    stringr::str_subset("geodata")

  if (!is.null(resolution)) {
    out <-
      out %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", resolution, collapse = "|")
        )
      )
  }

  if (!is.null(variable)) {
    checkmate::assert_choice(
      variable |> tolower(),
      worldclim_variables |> magrittr::extract2(paste0(series, "_variables"))
    )

    out <-
      out %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=(m|s)_)", variable, collapse = "|")
        )
      )
  }

  if (!is.null(model)) {
    checkmate::assert_choice(
      model |> tolower(),
      worldclim_variables |> magrittr::extract2("models") |> tolower()
    )

    out <-
      out %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", model, "(?=_ssp\\d{3})", collapse = "|")
        )
      )
  }

  if (!is.null(ssp)) {
    checkmate::assert_choice(
      ssp |> tolower(),
      worldclim_variables |> magrittr::extract2("ssps")
    )

    out <-
      out %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", ssp, "(?=_)", collapse = "|")
        )
      )
  }

  if (!is.null(year)) {
    if (series == "hmwd") {
      checkmate::assert_choice(
        year,
        worldclim_variables |>
          magrittr::extract2("hmwd_years") |>
          names() |>
          unique()
      )
    } else if (series == "fcd") {
      checkmate::assert_choice(
        year,
        worldclim_variables |>
          magrittr::extract2("fcd_years") |>
          names() |>
          unique()
      )
    }

    out <-
      out %>%
      magrittr::extract(
        stringr::str_detect(
          basename(.),
          paste0("(?<=_)", year, collapse = "|")
        )
      )
  }

  out
}
