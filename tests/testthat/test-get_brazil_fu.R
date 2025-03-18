testthat::test_that("get_brazil_fu() | General test", {
  get_brazil_fu(x = NULL) |>
    testthat::expect_equal(c(
      "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT",
      "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO",
      "RR", "SC", "SE", "SP", "TO"
    ))

  get_brazil_fu(x = "Sao Paulo") |>
    testthat::expect_equal("SP")

  get_brazil_fu(x = "southeast") |>
    testthat::expect_equal(c("ES", "MG", "RJ", "SP"))
})

testthat::test_that("get_brazil_fu() | Error test", {
  # checkmate::assert_character(x, null.ok = TRUE)
  get_brazil_fu(x = 1) |> testthat::expect_error()
})
