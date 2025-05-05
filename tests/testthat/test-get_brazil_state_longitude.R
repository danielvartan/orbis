testthat::test_that("get_brazil_state_longitude() | General test", {
  get_brazil_state_longitude(NULL) |>
    testthat::expect_equal(
      c(
        "Acre" = -67.8220778, # Rio Branco
        "Alagoas" = -35.7339264, # Maceió
        "Amapá" = -51.0569588, # Macapá
        "Amazonas" = -59.9825041, # Manaus
        "Bahia" = -38.4812772, # Salvador
        "Ceará" = -38.5217989, # Fortaleza
        "Distrito Federal" = -47.8823172, # Brasília
        "Espírito Santo" = -40.3376682, # Vitória
        "Goiás" = -49.2532691, # Goiânia
        "Maranhão" = -44.2963942, # São Luís
        "Mato Grosso" = -56.0991301, # Cuiabá
        "Mato Grosso do Sul" = -54.6162947, # Campo Grande
        "Minas Gerais" = -43.9450948, # Belo Horizonte
        "Pará" = -48.4682453, # Belém
        "Paraíba" = -34.8820280, # João Pessoa
        "Paraná" = -49.2712724, # Curitiba
        "Pernambuco" = -34.8848193, # Recife
        "Piauí" = -42.8049571, # Teresina
        "Rio de Janeiro" = -43.2093727, # Rio de Janeiro
        "Rio Grande do Norte" = -35.2080905, # Natal
        "Rio Grande do Sul" = -51.2303767, # Porto Alegre
        "Rondônia" = -63.8735438, # Porto Velho
        "Roraima" = -60.6719582, # Boa Vista
        "Santa Catarina" = -48.5496098, # Florianópolis
        "São Paulo" = -46.6333824, # São Paulo
        "Sergipe" = -37.0774655, # Aracaju
        "Tocantins" = -48.3336423  # Palmas
      )
    )

  get_brazil_state_longitude("acre") |> testthat::expect_equal(-67.8220778)
  get_brazil_state_longitude("ac") |> testthat::expect_equal(-67.8220778)

  get_brazil_state_longitude("sp") |> testthat::expect_equal(-46.6333824)
  get_brazil_state_longitude("sao paulo") |> testthat::expect_equal(-46.6333824)
  get_brazil_state_longitude(35) |> testthat::expect_equal(-46.6333824)
  get_brazil_state_longitude(3550308) |> testthat::expect_equal(-46.6333824)
  get_brazil_state_longitude(35503081) |> testthat::expect_equal(NA_real_)
  get_brazil_state_longitude(3912345) |> testthat::expect_equal(NA_real_)

  get_brazil_state_code() |>
    unname() |>
    get_brazil_state_longitude() |>
    testthat::expect_equal(get_brazil_state_longitude() |> unname())
})

testthat::test_that("get_brazil_state_longitude() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_state_longitude(x = mtcars) |> testthat::expect_error()
})
