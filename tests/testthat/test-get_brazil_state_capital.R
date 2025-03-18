testthat::test_that("get_brazil_state_capital() | General test", {
  get_brazil_state_capital(NULL) |>
    testthat::expect_equal(
      c(
        "Acre" = "Rio Branco",
        "Alagoas" = "Maceió",
        "Amapá" = "Macapá",
        "Amazonas" = "Manaus",
        "Bahia" = "Salvador",
        "Ceará" = "Fortaleza",
        "Distrito Federal" = "Brasília",
        "Espírito Santo" = "Vitória",
        "Goiás" = "Goiânia",
        "Maranhão" = "São Luís",
        "Mato Grosso" = "Cuiabá",
        "Mato Grosso do Sul" = "Campo Grande",
        "Minas Gerais" = "Belo Horizonte",
        "Pará" = "Belém",
        "Paraíba" = "João Pessoa",
        "Paraná" = "Curitiba",
        "Pernambuco" = "Recife",
        "Piauí" = "Teresina",
        "Rio de Janeiro" = "Rio de Janeiro",
        "Rio Grande do Norte" = "Natal",
        "Rio Grande do Sul" = "Porto Alegre",
        "Rondônia" = "Porto Velho",
        "Roraima" = "Boa Vista",
        "Santa Catarina" = "Florianópolis",
        "São Paulo" = "São Paulo",
        "Sergipe" = "Aracaju",
        "Tocantins" = "Palmas"
      )
    )

  get_brazil_state_capital("piaui") |> testthat::expect_equal("Teresina")

  get_brazil_state_capital("pi") |> testthat::expect_equal("Teresina")
})

testthat::test_that("get_brazil_state_capital() | Error test", {
  # checkmate::assert_character(x, null.ok = TRUE)
  get_brazil_state_capital(x = 1) |> testthat::expect_error()
})
