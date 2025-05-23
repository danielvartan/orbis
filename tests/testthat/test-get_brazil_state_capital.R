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

  get_brazil_state_capital("pi") |> testthat::expect_equal("Teresina")
  get_brazil_state_capital("piaui") |> testthat::expect_equal("Teresina")

  get_brazil_state_capital("sp") |> testthat::expect_equal("São Paulo")
  get_brazil_state_capital("sao paulo") |> testthat::expect_equal("São Paulo")
  get_brazil_state_capital(35) |> testthat::expect_equal("São Paulo")
  get_brazil_state_capital(3550308) |> testthat::expect_equal("São Paulo")
  get_brazil_state_capital(35503081) |> testthat::expect_equal(NA_character_)
  get_brazil_state_capital(3912345) |> testthat::expect_equal(NA_character_)

  get_brazil_state_code() |>
    unname() |>
    get_brazil_state_capital() |>
    testthat::expect_equal(get_brazil_state_capital() |> unname())
})

testthat::test_that("get_brazil_state_capital() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_state_capital(x = mtcars) |> testthat::expect_error()
})
