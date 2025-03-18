testthat::test_that("render_brazil_address() | General test", {
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = NA_character_
  ) |>
    testthat::expect_equal("Brasil")

  render_brazil_address(
    street = c("Viaduto do Chá, 15", "Alameda Ribeiro da Silva, 919"),
    complement = c("", "Ap. 502"),
    neighborhood = c("Centro", "Campos Elíseos"),
    municipality = c("São Paulo", "São Paulo"),
    state = c("SP", "SP"),
    postal_code = c("01002-020", "01217-010")
  ) |>
    testthat::expect_equal(
      c(
        "Viaduto do Chá, 15, Centro, São Paulo-SP, 01002-020, Brasil",
        paste0(
          "Alameda Ribeiro da Silva, 919, Ap. 502, Campos Elíseos, ",
          "São Paulo-SP, 01217-010, Brasil"
        )
      )
    )
})

testthat::test_that("render_brazil_address() | Error test", {
  # checkmate::assert_character(street)
  render_brazil_address(
    street = 1,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = NA_character_
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(complement)
  render_brazil_address(
    street = NA_character_,
    complement = 1,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = NA_character_
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(neighborhood)
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = 1,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = NA_character_
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(municipality)
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = 1,
    state = NA_character_,
    postal_code = NA_character_
  ) |>
    testthat::expect_error()

  # checkmate::assert_character(state)
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = 1,
    postal_code = NA_character_
  ) |>
    testthat::expect_error()

  # checkmate::assert_character( ...
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = 1
  ) |>
    testthat::expect_error()

  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = 137914564564
  ) |>
    testthat::expect_error()

  # prettycheck::assert_identical( ...
  render_brazil_address(
    street = NA_character_,
    complement = NA_character_,
    neighborhood = NA_character_,
    municipality = NA_character_,
    state = NA_character_,
    postal_code = c(NA_character_, NA_character_)
  ) |>
    testthat::expect_error()
})
