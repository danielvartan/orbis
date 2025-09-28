testthat::test_that("`remove_unique_outliers()` | General test", {
  asc_content <- c(
    "ncols         5",
    "nrows         5",
    "xllcorner     0.0",
    "yllcorner     0.0",
    "cellsize      1.0",
    "NODATA_value  -9999",
    "1 2 3 4 5",
    "6 7 8 9 10",
    "11 12 1000 14 15", # Extreme outlier (1000)
    "16 1 18 19 20",
    "21 22 23 24 25"
  )

  # `remove_extreme_outliers.tif()`

  temp_file <- tempfile(fileext = ".asc")

  asc_content |> readr::write_lines(temp_file)

  data <- temp_file |>  terra::rast()

  temp_file <- tempfile(fileext = ".tif")

  data |>
    terra::writeRaster(
      filename = temp_file,
      overwrite = TRUE,
      filetype = "GTiff"
    )

  values_before <- temp_file |> terra::rast() |> terra::values(mat = FALSE)

  temp_file |> remove_unique_outliers()

  values_after <- temp_file |> terra::rast() |> terra::values(mat = FALSE)

  values_before |>
    magrittr::inset(13, NA) |>
    testthat::expect_equal(values_after)

  # `remove_extreme_outliers.asc()`

  temp_file <- tempfile(fileext = ".asc")

  asc_content |> readr::write_lines(temp_file)
  values_before <- temp_file |> terra::rast() |> terra::values(mat = FALSE)

  temp_file |> remove_unique_outliers()

  values_after <- temp_file |> terra::rast() |> terra::values(mat = FALSE)

  values_before |>
    magrittr::inset(13, NA) |>
    testthat::expect_equal(values_after)
})
