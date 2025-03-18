testthat::test_that("get_brazil_municipality_code() | General test", {
  get_brazil_municipality_code(
    municipality = "São Paulo",
    state = NULL,
    year = 2017,
    names = TRUE
  ) |>
    testthat::expect_equal(c("São Paulo-SP" = 3550308))

  get_brazil_municipality_code(
    municipality = c("Rio de Janeiro", "São Paulo"),
    state = NULL,
    year = 2017,
    names = FALSE
  ) |>
    testthat::expect_equal(c(3304557, 3550308))
})

testthat::test_that("get_brazil_municipality_code() | Error test", {
  # prettycheck::assert_internet()

  # checkmate::assert_character(municipality)
  get_brazil_municipality_code(
    municipality = 1,
    state = NULL,
    year = 2017,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(state, null.ok = TRUE)
  get_brazil_municipality_code(
    municipality = NULL,
    state = 1,
    year = 2017,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_int( ...
  get_brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 1.5,
    names = TRUE
  ) |>
    testthat::expect_error()

  get_brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 1899,
    names = TRUE
  ) |>
    testthat::expect_error()

  get_brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 3000,
    names = TRUE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(names)
  get_brazil_municipality_code(
    municipality = NULL,
    state = NULL,
    year = 2017,
    names = "a"
  ) |>
    testthat::expect_error()
})
