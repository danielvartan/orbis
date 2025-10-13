testthat::test_that("`get_sidra()` | General test", {
  get_sidra() |> testthat::expect_error()
})

testthat::test_that("`has_internet()` | General test", {
  has_internet() |>
    testthat::expect_equal(curl::has_internet())
})

testthat::test_that("`read_country()` | General test", {
  read_country(year = NULL) |> testthat::expect_error()
})

testthat::test_that("`read_municipality()` | General test", {
  read_municipality(year = NULL) |> testthat::expect_error()
})

testthat::test_that("`require_namespace()` | General test", {
  require_namespace("base", quietly = TRUE) |>
    testthat::expect_equal(requireNamespace("base", quietly = TRUE))
})
