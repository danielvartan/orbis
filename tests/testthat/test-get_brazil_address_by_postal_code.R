testthat::test_that("get_brazil_address_by_postal_code() | General test", {
  testthat::local_mocked_bindings(
    get_brazil_address_by_postal_code_osm = function(...) TRUE,
    get_brazil_address_by_postal_code_google = function(...) TRUE,
    get_brazil_address_by_postal_code_qualocep = function(...) TRUE,
    get_brazil_address_by_postal_code_viacep = function(...) TRUE
  )

  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "osm",
    fix_code = TRUE,
    limit = 10
  ) |>
    testthat::expect_true()

  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "google",
    fix_code = FALSE,
    limit = Inf
  ) |>
    testthat::expect_true()

  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "qualocep",
    fix_code = TRUE,
    limit = 10
  ) |>
    testthat::expect_true()

  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "viacep",
    fix_code = TRUE,
    limit = 10
  ) |>
    testthat::expect_true()
})

testthat::test_that("get_brazil_address_by_postal_code() | Error test", {
  # prettycheck::assert_internet()

  # checkmate::assert_atomic(postal_code)
  get_brazil_address_by_postal_code(
    postal_code = list(),
    method = "qualocep",
    fix_code = TRUE,
    limit = 10
  ) |>
    testthat::expect_error()

  # checkmate::assert_choice(method, c("osm", "google", "qualocep", "viacep"))
  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "test",
    fix_code = TRUE,
    limit = 10
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(fix_code)
  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "qualocep",
    fix_code = "a",
    limit = 10
  ) |>
    testthat::expect_error()

  # checkmate::assert_number(limit, lower = 0)
  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "qualocep",
    fix_code = TRUE,
    limit = "a"
  ) |>
    testthat::expect_error()

  get_brazil_address_by_postal_code(
    postal_code = "01014908",
    method = "qualocep",
    fix_code = TRUE,
    limit = -1
  ) |>
    testthat::expect_error()
})
