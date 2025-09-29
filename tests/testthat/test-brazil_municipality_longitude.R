testthat::test_that("`brazil_municipality_longitude()` | General test", {
  test_data <- dplyr::tibble(test = "test")

  testthat::local_mocked_bindings(
    require_pkg = function(...) TRUE,
    assert_internet = function(...) TRUE,
    brazil_municipality_get = function(...) TRUE
  )

  brazil_municipality_longitude(3550308) |>
    testthat::expect_equal(TRUE)
})
