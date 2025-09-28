testthat::test_that("brazil_state() | General test", {
  brazil_state(NULL) |>
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

  brazil_state("sao paulo") |> testthat::expect_equal("São Paulo")
  brazil_state("sp") |> testthat::expect_equal("São Paulo")
  brazil_state(35) |> testthat::expect_equal("São Paulo")
  brazil_state(3550308) |> testthat::expect_equal("São Paulo")
  brazil_state(35503081) |> testthat::expect_equal(NA_character_)

  brazil_state("southeast") |>
    testthat::expect_equal(
      c("Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo")
    )

  brazil_state(3) |>
    testthat::expect_equal(
      c("Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo")
    )

  brazil_state_code() |>
    unname() |>
    brazil_state() |>
    testthat::expect_equal(brazil_state())

  brazil_state(NA) |> testthat::expect_equal(NA_character_)
})

testthat::test_that("brazil_state() | Error test", {
  # checkmate::assert_atomic(x)
  brazil_state(x = mtcars) |> testthat::expect_error()

  # If (length(x) > 1 && ...
  brazil_state(c("north", "north")) |> testthat::expect_error()
  brazil_state(1:2) |> testthat::expect_error()

})
