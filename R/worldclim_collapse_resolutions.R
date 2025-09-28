worldclim_collapse_resolutions <- function(resolutions) {
  choices <- c("10m", "5m", "2.5m", "30s")

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
