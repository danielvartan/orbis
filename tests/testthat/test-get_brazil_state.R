testthat::test_that("get_brazil_state() | General test", {
  get_brazil_state(NULL) |>
    testthat::expect_equal(
      c(
        "Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceará",
        "Distrito Federal", "Espírito Santo", "Goiás", "Maranhão",
        "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará",
        "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro",
        "Rio Grande do Norte", "Rio Grande do Sul", "Rondônia", "Roraima",
        "Santa Catarina", "São Paulo", "Sergipe", "Tocantins"
      )
    )

  get_brazil_state("sp") |>
    testthat::expect_equal("São Paulo")

  get_brazil_state("southeast") |>
    testthat::expect_equal(
      c(
        "Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo"
      )
    )
})

testthat::test_that("get_brazil_state() | Error test", {
  # checkmate::assert_character(x, null.ok = TRUE)
  get_brazil_state(x = 1) |> testthat::expect_error()
})
