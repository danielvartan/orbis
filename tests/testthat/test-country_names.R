testthat::test_that("country_names() | General test", {
  country_names("name") |>
    magrittr::extract(235) |>
    testthat::expect_equal("United States")

  country_names("official name") |>
    magrittr::extract(235) |>
    testthat::expect_equal("United States of America")

  country_names("alpha 2") |>
    magrittr::extract(235) |>
    testthat::expect_equal(c("United States" = "US"))
})

testthat::test_that("country_names() | Error test", {
  # checkmate::assert_choice(format, format_options)
  country_names("test") |> testthat::expect_error()
})
