testthat::test_that("`shift_and_rotate()` | General test", {
  raster <-
    expand.grid(
      seq(-5, 5, by = 1),
      seq(-5, 5, by = 1)
    ) |>
    dplyr::as_tibble() |>
    dplyr::rename(x = Var1, y = Var2) |>
    dplyr::mutate(value = rep(seq(1, 11), 11)) |>
    terra::rast(type = "xyz") %>%
    terra::`crs<-`("epsg:4326")

  # terra::ext(raster): -5.5, 5.5, -5.5, 5.5 (xmin, xmax, ymin, ymax)

  raster |>
    shift_and_rotate(dx = -1) |>
    terra::values() |>
    testthat::expect_equal(
      raster |>
        terra::values() |>
        dplyr::lead() |>
        magrittr::inset2(121, 1)
    )

  raster |>
    shift_and_rotate(dx = 0) |>
    testthat::expect_equal(raster)

  raster |>
    shift_and_rotate(dx = 1) |>
    terra::values() |>
    testthat::expect_equal(
      raster |>
        terra::values() |>
        dplyr::lag() |>
        magrittr::inset2(1, 11)
    )

  # raster |> terra::plot()
  # raster |> shift_and_rotate(dx = -1) |> terra::plot()
  # raster |> shift_and_rotate(dx = 1) |> terra::plot()
})
