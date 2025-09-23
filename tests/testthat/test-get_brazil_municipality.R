# Error with MacOS Latest: Probably because it can't connect to the internet
# testthat::test_that("get_brazil_municipality() | General test", {
#   brazil_municipalities_file <- file.path(
#     tempdir(), paste0("brazil-municipalities-", 2017, ".rds")
#   )

#   if (checkmate::test_file_exists(brazil_municipalities_file)) {
#     file.remove(brazil_municipalities_file)
#   }

#   get_brazil_municipality(
#     municipality = NULL,
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     checkmate::expect_tibble(ncols = 6)

#   get_brazil_municipality(
#     municipality = "belem",
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal(c("Pará", "Paraíba", "Alagoas"))

#   get_brazil_municipality(
#     municipality = "belem",
#     state = "para",
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal("Pará")

#   get_brazil_municipality(
#     municipality = "Test",
#     state = NULL,
#     year = 2017,
#     force = FALSE
#   ) |>
#     dplyr::pull("state") |>
#     testthat::expect_equal(NA_character_)
# })

testthat::test_that("get_brazil_municipality() | Error test", {
  # assert_internet()

  # checkmate::assert_character(municipality, null.ok = TRUE)
  get_brazil_municipality(
    municipality = 1,
    state = NULL,
    year = 2017,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(state, null.ok = TRUE)
  get_brazil_municipality(
    municipality = NULL,
    state = 1,
    year = 2017,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_integerish(year)
  get_brazil_municipality(
    municipality = NULL,
    state = NULL,
    year = 1.5,
    force = FALSE
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(force)
  get_brazil_municipality(
    municipality = NULL,
    state = NULL,
    year = 2017,
    force = "a"
  ) |>
    testthat::expect_error()
})
