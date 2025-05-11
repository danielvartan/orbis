testthat::test_that("get_brazil_fu() | General test", {
  get_brazil_fu(x = NULL) |>
    testthat::expect_equal(c(
      "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT",
      "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO",
      "RR", "SC", "SP", "SE", "TO"
    ))

  get_brazil_fu("sao paulo") |> testthat::expect_equal("SP")
  get_brazil_fu("sp") |> testthat::expect_equal("SP")
  get_brazil_fu(35) |> testthat::expect_equal("SP")
  get_brazil_fu(3550308) |> testthat::expect_equal("SP")
  get_brazil_fu(35503081) |> testthat::expect_equal(NA_character_)

  get_brazil_fu(x = "southeast") |>
    testthat::expect_equal(c("ES", "MG", "RJ", "SP"))

  get_brazil_fu(3) |> testthat::expect_equal(c("ES", "MG", "RJ", "SP"))

  get_brazil_state_code() |>
    unname() |>
    get_brazil_fu() |>
    testthat::expect_equal(get_brazil_fu())

  get_brazil_fu(NA) |> testthat::expect_equal(NA_character_)
})

testthat::test_that("get_brazil_fu() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_fu(x = mtcars) |> testthat::expect_error()
})
