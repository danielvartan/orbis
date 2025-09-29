testthat::test_that("`filter_points_on_land()` | Error test", {
  # checkmate::assert_tibble(data)
  filter_points_on_land(
    data = 1,
    geometry = NULL
  ) |>
    testthat::expect_error()

  # checkmate::assert_subset(c("longitude", "latitude"), names(data))
  filter_points_on_land(
    data = dplyr::tibble(a = 1, b = 2),
    geometry = NULL
  ) |>
    testthat::expect_error()

  # checkmate::assert_class(geometry, "sfc_MULTIPOLYGON")
  filter_points_on_land(
    data = dplyr::tibble(latitude = 1, longitude = 2),
    geometry = NULL
  ) |>
    testthat::expect_error()
})
