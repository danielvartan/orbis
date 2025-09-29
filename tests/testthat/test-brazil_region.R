testthat::test_that("`brazil_region`() | General test", {
  brazil_region(NULL) |>
    testthat::expect_equal(
      c("North", "Northeast", "South", "Southeast", "Central-West")
    )

  brazil_region("sao paulo") |> testthat::expect_equal("Southeast")
  brazil_region("sp") |> testthat::expect_equal("Southeast")
  brazil_region(3) |> testthat::expect_equal("Southeast")
  brazil_region(33) |> testthat::expect_equal("Southeast")
  brazil_region(3550308) |> testthat::expect_equal("Southeast")
  brazil_region(35503080) |> testthat::expect_equal(NA_character_)
})

testthat::test_that("`brazil_region`() | Error test", {
  # checkmate::assert_atomic(x)
  brazil_region(x = mtcars) |> testthat::expect_error()
})
