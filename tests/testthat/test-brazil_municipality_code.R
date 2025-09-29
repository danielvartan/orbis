testthat::test_that("`brazil_municipality_code()` | General test", {
  test_data <- dplyr::tibble(
    region_code = 1L,
    region = "North",
    state_code = 11L,
    state = "Rondônia",
    federal_unit = "RO",
    municipality_code = 1100015,
    municipality = "Alta Floresta D'Oeste"
  )


  testthat::local_mocked_bindings(
    require_pkg = function(...) TRUE,
    assert_internet = function(...) TRUE,
    brazil_municipality = function(...) test_data
  )

  brazil_municipality_code("Alta Floresta D'Oeste") |>
    testthat::expect_equal(c("Alta Floresta D'Oeste-RO" = 1100015))

  brazil_municipality_code("Alta Floresta D'Oeste", names = FALSE) |>
    testthat::expect_equal(1100015)
})

testthat::test_that("`brazil_municipality_code()` | Error test", {
  # assert_internet()

  # checkmate::assert_character(municipality)
  brazil_municipality_code(
    municipality = 1,
    state = NULL,
    year = 2017,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(state, null.ok = TRUE)
  brazil_municipality_code(
    municipality = NULL,
    state = 1,
    year = 2017,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_int( ...
  brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 1.5,
    names = TRUE
  ) |>
    testthat::expect_error()

  brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 1899,
    names = TRUE
  ) |>
    testthat::expect_error()

  brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 3000,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(names)
  brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 2017,
    names = "a"
  ) |>
    testthat::expect_error()
})
