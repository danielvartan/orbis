# Error with MacOS Latest: Probably because it can't connect to the internet
# testthat::test_that("filter_points_on_land() | General test", {
#   data <- tibble(
#     latitude = get_brazil_state_latitude(),
#     longitude = get_brazil_state_longitude()
#   )

#   geometry <-
#     geobr::read_state(code = "SP", showProgress = FALSE) |>
#     dplyr::pull(geom) |>
#     rutils::shush()

#   filter_points_on_land(data, geometry) |>
#     tidyr::pivot_longer(cols = everything()) |>
#     dplyr::pull(value) |>
#     unname() |>
#     testthat::expect_equal(
#       c(
#         get_brazil_state_latitude("sp"),
#         get_brazil_state_longitude("sp")
#       )
#     )
# })

testthat::test_that("filter_points_on_land() | Error test", {
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
