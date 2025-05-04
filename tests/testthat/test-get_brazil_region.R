testthat::test_that("get_brazil_region() | General test", {
  get_brazil_region(NULL) |>
    testthat::expect_equal(
      c("North", "Northeast", "South", "Southeast", "Central-West")
    )

  get_brazil_region("sao paulo") |>
    testthat::expect_equal("Southeast")

  get_brazil_region("sp") |>
    testthat::expect_equal("Southeast")
})

testthat::test_that("get_brazil_region() | Error test", {
  # checkmate::assert_character(x, null.ok = TRUE)
  get_brazil_region(x = 1) |> testthat::expect_error()
})
