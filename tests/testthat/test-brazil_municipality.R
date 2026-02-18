testthat::test_that("`brazil_municipality()` | General test", {
  test_data_1 <- dplyr::tibble(
    code_muni = 1100015,
    name_muni = "Alta Floresta D'oeste",
    code_state = "11",
    abbrev_state = "RO"
  )

  test_data_2 <- dplyr::tibble(
    municipality_code = 1100015
  )

  testthat::local_mocked_bindings(
    require_package = function(...) TRUE,
    assert_internet = function(...) TRUE,
    read_municipality = function(...) test_data_1,
    brazil_municipality_coords = function(...) test_data_2
  )

  brazil_municipality(
    municipality = NULL,
    state = NULL,
    year = Sys.Date() |> substr(1, 4) |> as.numeric(),
    coords_method = "geobr",
    force = TRUE
  ) |>
    testthat::expect_equal(
      dplyr::tibble(
        municipality = "Alta Floresta D'Oeste",
        municipality_code = 1100015,
        state = "Rondônia",
        state_code = 11L,
        federal_unit = "RO",
        region = "North",
        region_code = 1L
      )
    ) |>
    suppressMessages()
})

testthat::test_that("`brazil_municipality()` | Error test", {
  # assert_internet()

  # checkmate::assert_character(municipality, null.ok = TRUE)
  brazil_municipality(
    municipality = 1,
    state = NULL,
    year = 2017,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(state, null.ok = TRUE)
  brazil_municipality(
    municipality = NULL,
    state = 1,
    year = 2017,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_integerish(year)
  brazil_municipality(
    municipality = NULL,
    state = NULL,
    year = 1.5,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(force)
  brazil_municipality(
    municipality = NULL,
    state = NULL,
    year = 2017,
    force = "a"
  ) |>
    testthat::expect_error()
})
