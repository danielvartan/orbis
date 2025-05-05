testthat::test_that("get_brazil_region() | General test", {
  get_brazil_region(NULL) |>
    testthat::expect_equal(
      c("North", "Northeast", "South", "Southeast", "Central-West")
    )

  get_brazil_region("sao paulo") |> testthat::expect_equal("Southeast")
  get_brazil_region("sp") |> testthat::expect_equal("Southeast")
  get_brazil_region(3) |> testthat::expect_equal("Southeast")
  get_brazil_region(33) |> testthat::expect_equal("Southeast")
  get_brazil_region(3550308) |> testthat::expect_equal("Southeast")
  get_brazil_region(35503080) |> testthat::expect_equal(NA_character_)
})

testthat::test_that("get_brazil_region() | Error test", {
  # checkmate::assert_atomic(x)
  get_brazil_region(x = mtcars) |> testthat::expect_error()
})
