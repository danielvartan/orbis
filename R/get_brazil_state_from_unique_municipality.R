get_brazil_state_from_unique_municipality <- function(data) {
  var_set <- c("id", "country", "state", "municipality", "postal_code")

  checkmate::assert_tibble(data)
  checkmate::assert_subset(var_set, names(data))

  # R CMD Check variable bindings fix
  # nolint start
   municipality <- NULL
  # nolint end

  data |>
    dplyr::select(dplyr::all_of(var_set)) |>
    dplyr::filter(is.na(state), !is.na(municipality)) |>
    dplyr::left_join(
      get_brazil_municipality() |>
        dplyr::select(municipality, state) |>
        dplyr::filter(!vctrs::vec_duplicate_detect(municipality)),
      by = "municipality"
    )
}
