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

  get_brazil_state("sao paulo") |> testthat::expect_equal("São Paulo")
  get_brazil_state("sp") |> testthat::expect_equal("São Paulo")
  get_brazil_state(35) |> testthat::expect_equal("São Paulo")
  get_brazil_state(3550308) |> testthat::expect_equal("São Paulo")
  get_brazil_state(35503081) |> testthat::expect_equal(NA_character_)

  get_brazil_state("southeast") |>
    testthat::expect_equal(
      c("Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo")
    )

  get_brazil_state(3) |>
    testthat::expect_equal(
      c("Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo")
    )

  get_brazil_state_code() |>
    unname() |>
    get_brazil_state() |>
    testthat::expect_equal(get_brazil_state())
})

testthat::test_that("get_brazil_state() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_state(x = mtcars) |> testthat::expect_error()

  # If(length(x) > 1 && ...
  get_brazil_state(c("north", "north")) |> testthat::expect_error()
  get_brazil_state(1:2) |> testthat::expect_error()

})
