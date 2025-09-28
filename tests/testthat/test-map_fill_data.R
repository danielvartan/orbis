testthat::test_that("map_fill_data() | General test", {
  data <- dplyr::tibble(
    state = c("SP", "RJ", "MG", "SP", "RJ", "MG"),
    value = c(1, 2, 3, 4, 5, 6)
  )

  map_fill_data(data, col_fill = NULL, col_code = "state") |>
    dplyr::pull(n) |>
    testthat::expect_equal(c(2, 2, 2))

  map_fill_data(data, col_fill = "value", col_code = "state") |>
    dplyr::pull(n) |>
    shush() |>
    testthat::expect_equal(c(2.5, 3.5, 4.5))
})

testthat::test_that("map_fill_data() | Error test", {
  # checkmate::assert_tibble(data)
  map_fill_data(
    data = 1,
    col_fill = NULL,
    col_code = "a",
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(col_fill, null.ok = TRUE)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = 1,
    col_code = "a",
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(col_fill, names(data), null.ok = TRUE)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "c",
    col_code = "a",
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(col_code)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "a",
    col_code = 1,
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(col_code, names(data))
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "a",
    col_code = "c",
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(name_col_value)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "a",
    col_code = "b",
    name_col_value = 1,
    name_col_ref = col_code,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(name_col_ref)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "a",
    col_code = "b",
    name_col_value = "n",
    name_col_ref = 1,
    quiet = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(quiet)
  map_fill_data(
    data = dplyr::tibble(a = 1, b = 2),
    col_fill = "a",
    col_code = "b",
    name_col_value = "n",
    name_col_ref = col_code,
    quiet = "a"
  ) |>
    testthat::expect_error()
})
