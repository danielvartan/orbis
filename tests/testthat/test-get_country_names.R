testthat::test_that("get_country_names() | General test", {
  get_country_names("name") |>
    magrittr::extract(235) |>
    testthat::expect_equal("United States")

  get_country_names("official name") |>
    magrittr::extract(235) |>
    testthat::expect_equal("United States of America")

  get_country_names("alpha 2") |>
    magrittr::extract(235) |>
    testthat::expect_equal(c("United States" = "US"))
})

testthat::test_that("get_country_names() | Error test", {
  # checkmate::assert_choice(format, format_options)
  get_country_names("test") |> testthat::expect_error()
})
