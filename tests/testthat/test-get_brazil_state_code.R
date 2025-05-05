testthat::test_that("get_brazil_state_code() | General test", {
  get_brazil_state_code(NULL) |>
    testthat::expect_equal(
      c(
        "Acre" = 12,
        "Alagoas" = 27,
        "Amapá" = 16,
        "Amazonas" = 13,
        "Bahia" = 29,
        "Ceará" = 23,
        "Distrito Federal" = 53,
        "Espírito Santo" = 32,
        "Goiás" = 52,
        "Maranhão" = 21,
        "Mato Grosso" = 51,
        "Mato Grosso do Sul" = 50,
        "Minas Gerais" = 31,
        "Pará" = 15,
        "Paraíba" = 25,
        "Paraná" = 41,
        "Pernambuco" = 26,
        "Piauí" = 22,
        "Rio de Janeiro" = 33,
        "Rio Grande do Norte" = 24,
        "Rio Grande do Sul" = 43,
        "Rondônia" = 11,
        "Roraima" = 14,
        "Santa Catarina" = 42,
        "São Paulo" = 35,
        "Sergipe" = 28,
        "Tocantins" = 17
      ) |>
        methods::as("integer")
    )

  get_brazil_state_code("ac") |> testthat::expect_equal(12)
  get_brazil_state_code("acre") |> testthat::expect_equal(12)
  get_brazil_state_code(355) |> testthat::expect_equal(35)
  get_brazil_state_code(3550308) |> testthat::expect_equal(35)
  get_brazil_state_code(35503081) |> testthat::expect_equal(NA_integer_)
  get_brazil_state_code(390) |> testthat::expect_equal(NA_integer_)
})

testthat::test_that("get_brazil_state_code() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_state_code(x = mtcars) |> testthat::expect_error()
})
