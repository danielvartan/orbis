brazil_municipality_get <- function(
  #nolint
  x,
  col_filter,
  col_return,
  year = Sys.Date() |> substr(1, 4) |> as.numeric(),
  names = TRUE,
  ...
) {
  require_package("geobr")

  assert_internet()
  checkmate::assert_atomic(x)
  checkmate::assert_string(col_filter)
  checkmate::assert_string(col_return)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_flag(names)

  # R CMD Check variable bindings fix
  # nolint start
  municipality <- federal_unit <- NULL
  # nolint end

  data <- brazil_municipality(year = year, ...)

  checkmate::assert_choice(col_filter, names(data))
  checkmate::assert_choice(col_return, names(data))

  out <-
    x |>
    purrr::map(
      function(x) {
        if (x %in% data[[col_filter]]) {
          data_i <-
            data |>
            dplyr::filter(!!as.symbol(col_filter) == x)

          data_i |>
            dplyr::pull(!!as.symbol(col_return)) |>
            magrittr::set_names(
              paste0(
                data_i |> dplyr::pull(municipality),
                "-",
                data_i |> dplyr::pull(federal_unit)
              )
            )
        } else {
          NA_real_ |>
            magrittr::set_names(NA)
        }
      }
    )

  if (isTRUE(names)) {
    out |> unlist()
  } else {
    out |> unlist() |> unname()
  }
}
