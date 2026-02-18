testthat::test_that("`sidra_download_by_year()` | General test", {
  test_data <- dplyr::tibble(test = "test")

  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    get_sidra = function(...) test_data
  )

  sidra_download_by_year(
    years = 2025,
    api_start = "/t/123/",
    api_end = "/c123"
  ) |>
    testthat::expect_equal(test_data) |>
    suppressMessages()
})

testthat::test_that("`sidra_download_by_year()` | Error test", {
  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    get_sidra = function(...) stop("Test!")
  )

  # checkmate::assert_integerish(years)
  sidra_download_by_year(
    years = 2025.12,
    api_start = "/t/123/",
    api_end = "/c123"
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(api_start)
  sidra_download_by_year(
    years = 2025,
    api_start = 1,
    api_end = "/c123"
  ) |>
    testthat::expect_error()

  # checkmate::assert_string(api_start)
  sidra_download_by_year(
    years = 2025,
    api_start = "/t/123/",
    api_end = 1
  ) |>
    testthat::expect_error()

  # if (inherits(data_i, "try-error")) { [...]
  sidra_download_by_year(
    years = 2025,
    api_start = "/t/123/",
    api_end = "/c123"
  ) |>
    testthat::expect_message() |>
    suppressMessages()
})
