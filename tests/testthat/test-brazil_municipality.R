# Error with MacOS Latest: Probably because it can't connect to the internet
# testthat::test_that("brazil_municipality() | General test", {
#   brazil_municipalities_file <- file.path(
#     tempdir(), paste0("brazil-municipalities-", 2017, ".rds")
#   )

#   if (checkmate::test_file_exists(brazil_municipalities_file)) {
#     file.remove(brazil_municipalities_file)
#   }

#   brazil_municipality(
#     municipality = NULL,
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     checkmate::expect_tibble(ncols = 6)

#   brazil_municipality(
#     municipality = "belem",
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal(c("Pará", "Paraíba", "Alagoas"))

#   brazil_municipality(
#     municipality = "belem",
#     state = "para",
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal("Pará")

#   brazil_municipality(
#     municipality = "Test",
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal(NA_character_)
# })

testthat::test_that("brazil_municipality() | Error test", {
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
