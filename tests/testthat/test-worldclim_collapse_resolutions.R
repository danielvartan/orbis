testthat::test_that("`worldclim_collapse_resolutions()` | General test", {
  c("10m", "5m", "2.5m", "10m", NA, "30s") |>
    worldclim_collapse_resolutions() |>
    testthat::expect_equal(
      paste(c("10m", "5m", "2.5m", "30s"), collapse = "-")
    )

  NA |>
    worldclim_collapse_resolutions() |>
    testthat::expect_equal(NULL)
})
