testthat::test_that("`test_geobr_connection()` | General test", {
  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    read_country = function(...) TRUE
  )

  test_geobr_connection() |> testthat::expect_equal(TRUE)

  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    read_country = function(...) stop("Test")
  )

  test_geobr_connection() |> testthat::expect_equal(FALSE)
})
