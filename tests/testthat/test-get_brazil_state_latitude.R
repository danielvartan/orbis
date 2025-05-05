testthat::test_that("get_brazil_state_latitude() | General test", {
  get_brazil_state_latitude(NULL) |>
    testthat::expect_equal(
      c(
        "Acre" = -9.9765362,
        "Alagoas" = -9.6476843,
        "Amapá" = 0.0401529,
        "Amazonas" = -3.1316333,
        "Bahia" = -12.9822499,
        "Ceará" = -3.7304512,
        "Distrito Federal" = -15.7934036,
        "Espírito Santo" = -20.3200917,
        "Goiás" = -16.6808820,
        "Maranhão" = -2.5295265,
        "Mato Grosso" = -15.5986686,
        "Mato Grosso do Sul" = -20.4640173,
        "Minas Gerais" = -19.9227318,
        "Pará" = -1.4505600,
        "Paraíba" = -7.1215981,
        "Paraná" = -25.4295963,
        "Pernambuco" = -8.0584933,
        "Piauí" = -5.0874608,
        "Rio de Janeiro" = -22.9110137,
        "Rio Grande do Norte" = -5.8053980,
        "Rio Grande do Sul" = -30.0324999,
        "Rondônia" = -8.7494525,
        "Roraima" = 2.8208478,
        "Santa Catarina" = -27.5973002,
        "São Paulo" = -23.5506507,
        "Sergipe" = -10.9162061,
        "Tocantins" = -10.1837852
      )
    )

  get_brazil_state_latitude("ac") |> testthat::expect_equal(-9.9765362)
  get_brazil_state_latitude("acre") |>  testthat::expect_equal(-9.9765362)

  get_brazil_state_latitude("sp") |> testthat::expect_equal(-23.5506507)
  get_brazil_state_latitude("sao paulo") |> testthat::expect_equal(-23.5506507)
  get_brazil_state_latitude(35) |> testthat::expect_equal(-23.5506507)
  get_brazil_state_latitude(3550308) |> testthat::expect_equal(-23.5506507)
  get_brazil_state_latitude(35503081) |> testthat::expect_equal(NA_real_)
  get_brazil_state_latitude(3912345) |> testthat::expect_equal(NA_real_)

  get_brazil_state_code() |>
    unname() |>
    get_brazil_state_latitude() |>
    testthat::expect_equal(get_brazil_state_latitude() |> unname())
})

testthat::test_that("get_brazil_state_latitude() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_state_latitude(x = mtcars) |> testthat::expect_error()
})
