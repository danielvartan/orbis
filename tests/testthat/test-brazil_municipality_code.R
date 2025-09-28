# Error with MacOS Latest: Probably because it can't connect to the internet
# testthat::test_that("brazil_municipality_code() | General test", {
#   brazil_municipality_code(
#     municipality = "São Paulo",
#     state = NULL,
#     year = 2017,
#     names = TRUE
#   ) |>
#     testthat::expect_equal(c("São Paulo-SP" = 3550308))

#   brazil_municipality_code(
#     municipality = c("Rio de Janeiro", "São Paulo"),
#     state = NULL,
#     year = 2017,
#     names = FALSE
#   ) |>
#     testthat::expect_equal(c(3304557, 3550308))
# })

testthat::test_that("brazil_municipality_code() | Error test", {
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
