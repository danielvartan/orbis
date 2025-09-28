testthat::test_that("brazil_state_by_utc() | General test", {
  brazil_state_by_utc(utc = -3, type = "fu") |>
    testthat::expect_equal(
      c(
        "AL", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "PA",
        "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "SC", "SP", "SE", "TO"
      )
    )

  brazil_state_by_utc(utc = -3, type = "state") |>
    testthat::expect_equal(
      c(
        "Alagoas", "Amapá", "Bahia", "Ceará", "Distrito Federal",
        "Espírito Santo", "Goiás", "Maranhão", "Minas Gerais", "Pará",
        "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro",
        "Rio Grande do Norte", "Rio Grande do Sul", "Santa Catarina",
        "São Paulo", "Sergipe", "Tocantins"
      )
    )
})

testthat::test_that("brazil_state_by_utc() | Error test", {
  # checkmate::assert_int(utc)
  brazil_state_by_utc(utc = "a", type = "fu") |> testthat::expect_error()

  # checkmate::assert_choice(type, c("fu", "state"))
  brazil_state_by_utc(x = "SP", type = "city") |> testthat::expect_error()

  # if (!utc %in% c(-5, -4, -3, -2)) { ...
  brazil_state_by_utc(utc = -1, type = "fu") |> testthat::expect_error()
})
