testthat::test_that("`shift_and_crop()` | General test", {
  library(magrittr)

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

  vector <-
    rbind(
      c(-2, 5), # top-left
      c(2, 5), # top-right
      c(2, -5), # bottom-right
      c(-2, -5), # bottom-left
      c(-2, 5) # closing back at top-left
    ) |>
    terra::vect(type = "polygon") %>%
    terra::`crs<-`("epsg:4326")

  raster |>
    shift_and_crop(dx = -1, vector, overlap_tolerance = 0) |>
    terra::values() |>
    testthat::expect_equal(
      raster |>
        terra::values() |>
        dplyr::lead() |>
        magrittr::inset2(121, 1) |>
        dplyr::as_tibble() |>
        dplyr::filter(dplyr::between(value, 5, 9)) |>
        as.matrix()
    )

  raster |>
    shift_and_crop(dx = 0, vector, overlap_tolerance = 0) |>
    terra::values() |>
    testthat::expect_equal(
      raster |>
        terra::values() |>
        dplyr::as_tibble() |>
        dplyr::filter(dplyr::between(value, 4, 8)) |>
        as.matrix()
    )

  raster |>
    shift_and_crop(dx = 1, vector, overlap_tolerance = 0) |>
    terra::values() |>
    testthat::expect_equal(
      raster |>
        terra::values() |>
        dplyr::lag() |>
        magrittr::inset2(1, 11) |>
        dplyr::as_tibble() |>
        dplyr::filter(dplyr::between(value, 3, 7)) |>
        as.matrix()
    )

  # raster |> terra::plot()
  # vector |> terra::plot()
  # raster |> shift_and_rotate(dx = -1) |> terra::plot()
  # raster |> shift_and_rotate(dx = 1) |> terra::plot()

  # raster |>
  #   shift_and_crop(dx = -1, vector, overlap_tolerance = 0) |>
  #   terra::plot()
})
