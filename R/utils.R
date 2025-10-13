worldclim_collapse_resolutions <- function(resolutions) {
  choices <- c("10m", "5m", "2.5m", "30s", NA)

  for (i in resolutions) checkmate::assert_choice(i, choices)

  # R CMD Check variable bindings fix
  # nolint start
  . <- NULL
  # nolint end

  out <- resolutions |> unique()

  if (all(is.na(out))) {
    NULL
  } else {
    out %>%
      magrittr::extract(!is.na(.)) |>
      match(choices) |>
      sort() %>%
      magrittr::extract(choices, .) |>
      paste0(collapse = "-")
  }
}

worldclim_normalize_series <- function(series, type = 1) {
 series |> purrr::map_chr(worldclim_normalize_series.scalar, type = type)
}

worldclim_normalize_series.scalar <- function(series, type = 1) {
  checkmate::assert_choice(
    series |> tolower(),
    worldclim_variables |> magrittr::extract2("series_choices")
  )

  checkmate::assert_int(type)
  checkmate::assert_choice(as.integer(type), c(1L, 2L))

  if (series %in% c(
    "hcd", "historical-climate-data", "historical climate data"
  )) {
    if (type == 1) "hcd" else "historical-climate-data"
  } else if (series %in% c(
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data"
  )) {
    if (type == 1) "hmwd" else "historical-monthly-weather-data"
  } else if (series %in% c(
    "fcd", "future-climate-data", "future climate data"
  )) {
    if (type == 1) "fcd" else "future-climate-data"
  }
}
