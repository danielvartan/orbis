testthat::test_that("`brazil_municipality_get()` | General test", {
  test_data <- dplyr::tibble(
    region_code = 1L,
    region = "North",
    state_code = 11L,
    state = "Rondônia",
    federal_unit = "RO",
    municipality_code = 1100015,
    municipality = "Alta Floresta D'Oeste"
  )

  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    brazil_municipality = function(...) test_data
  )

  brazil_municipality_get(
    x = 1100015,
    col_filter = "municipality_code",
    col_return = "region",
    year = 2025,
    names = TRUE,
    coords_method = "geobr",
  ) |>
    testthat::expect_equal(c("Alta Floresta D'Oeste-RO" = "North"))

  brazil_municipality_get(
    x = 1100015,
    col_filter = "municipality_code",
    col_return = "region",
    year = 2025,
    names = FALSE,
    coords_method = "geobr",
  ) |>
    testthat::expect_equal("North")
})
