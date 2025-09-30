testthat::test_that("`filter_points()` | Error test", {
  # checkmate::assert_tibble(data)
  filter_points(
    data = 1,
    geometry = NULL
  ) |>
    testthat::expect_error()

  # checkmate::assert_subset(c("longitude", "latitude"), names(data))
  filter_points(
    data = dplyr::tibble(a = 1, b = 2),
    geometry = NULL
  ) |>
    testthat::expect_error()

  # checkmate::assert_class(geometry, "sfc_MULTIPOLYGON")
  filter_points(
    data = dplyr::tibble(latitude = 1, longitude = 2),
    geometry = NULL
  ) |>
    testthat::expect_error()
})
