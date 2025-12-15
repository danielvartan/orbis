testthat::test_that("`closest_geobr_year()` | General test", {
  closest_geobr_year(2025, type = "municipality") |>
    testthat::expect_equal(2024) |>
    suppressMessages()

  closest_geobr_year(2025, type = "municipal_seat") |>
    testthat::expect_equal(2010) |>
    suppressMessages()

  closest_geobr_year(2025, type = "state") |>
    testthat::expect_equal(2020) |>
    suppressMessages()

  closest_geobr_year(2025, type = "country") |>
    testthat::expect_equal(2020) |>
    suppressMessages()

  closest_geobr_year(c(2025, 1999, NA, 1800), type = "country") |>
    testthat::expect_equal(c(2020, 2000, NA, 1872)) |>
    suppressMessages()
})
