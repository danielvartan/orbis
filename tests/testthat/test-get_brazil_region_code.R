testthat::test_that("get_brazil_region_code() | General test", {
  get_brazil_region_code(NULL) |>
    testthat::expect_equal(
      c(
        "North" = 1,
        "Northeast" = 2,
        "Southeast" = 3,
        "South" = 4,
        "Central-West" = 5
      ) %>%
        `storage.mode<-`("integer") # methods::as("integer")
    )

  get_brazil_region_code("north") |> testthat::expect_equal(1)
  get_brazil_region_code("northeast") |> testthat::expect_equal(2)
  get_brazil_region_code("southeast") |> testthat::expect_equal(3)
  get_brazil_region_code("south") |> testthat::expect_equal(4)
  get_brazil_region_code("central-west") |> testthat::expect_equal(5)
  get_brazil_region_code("central") |> testthat::expect_equal(5)
  get_brazil_region_code("west") |> testthat::expect_equal(5)
})

testthat::test_that("get_brazil_region_code() | Error test", {
  # checkmate::assert_character(x, null.ok = TRUE)
  get_brazil_region_code(x = 1) |> testthat::expect_error()
})
