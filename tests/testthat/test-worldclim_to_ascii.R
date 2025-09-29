testthat::test_that("`worldclim_to_ascii()` | General test", {
  # General test

  testthat::local_mocked_bindings(
    require_pkg = function(...) TRUE
  )

  asc_content <- c(
    "ncols        5",
    "nrows        5",
    "xllcorner    0.000000000000",
    "yllcorner    0.000000000000",
    "cellsize     1.000000000000",
    "NODATA_value -99",
    "1 2 3 4 5 ",
    "6 7 8 9 10 ",
    "11 12 15 14 15 ",
    "16 1 18 19 20 ",
    "21 22 23 24 25 "
  )

  temp_asc_file_1 <- file.path(tempdir(), "tmin01")
  temp_asc_file_2 <- file.path(tempdir(), "tmin02")

  readr::write_lines(asc_content, temp_asc_file_1)
  readr::write_lines(asc_content, temp_asc_file_2)

  raster_1 <- temp_asc_file_1 |> terra::rast()
  raster_2 <- temp_asc_file_2 |> terra::rast()

  names <- c(
    "wc2.1_10m_vapr_10.tif",
    "wc2.1_10m_bio_7.tif",
    "wc2.1_10m_elev.tif",
    "wc2.1_cruts4.09_10m_tmin_1951-01.tif",
    "wc2.1_10m_prec_EC-Earth3-Veg_ssp126_2021-2040.tif",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp370_2021-2040.tif"
  )

  files <- character()

  for (i in names) {
    i_file <- file.path(tempdir(), i)

    c(raster_1, raster_2) |> terra::writeRaster(i_file, overwrite = TRUE)

    files <- c(files, i_file)
  }

  files |>
    worldclim_to_ascii() |>
    magrittr::extract(1) |>
    readr::read_lines() |>
    testthat::expect_equal(asc_content)

  # if (isTRUE(dateline_fix) && isTRUE(test_dateline(shape))) { [...]

  testthat::local_mocked_bindings(
    require_pkg = function(...) TRUE,
    test_dateline = function(...) TRUE
  )

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

  worldclim_to_ascii(
    file = files[1],
    dir = dirname(files[1]),
    shape = vector,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    suppressMessages()

  # if (!is.null(box)) data_i <- data_i |> terra::crop(box)

  worldclim_to_ascii(
    file = files[1],
    dir = dirname(files[1]),
    shape = NULL,
    box = c(2, 5, 2, 5),
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    suppressMessages()
})

testthat::test_that("`worldclim_to_ascii()` | Error test", {
  testthat::local_mocked_bindings(
    require_pkg = function(...) TRUE
  )

  asc_content <- c(
    "ncols        5",
    "nrows        5",
    "xllcorner    0.000000000000",
    "yllcorner    0.000000000000",
    "cellsize     1.000000000000",
    "NODATA_value -99",
    "1 2 3 4 5 ",
    "6 7 8 9 10 ",
    "11 12 15 14 15 ",
    "16 1 18 19 20 ",
    "21 22 23 24 25 "
  )

  temp_asc_file <- tempfile(fileext = ".asc")

  readr::write_lines(asc_content, temp_asc_file)

  raster <- temp_asc_file |> terra::rast()

  temp_tif_file <- tempfile(fileext = ".tif")

  # checkmate::assert_character(file)
  worldclim_to_ascii(
    file = 1,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_file_exists(file, access = "r", extension = "tif")
  worldclim_to_ascii(
    file = tempfile(),
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  worldclim_to_ascii(
    file = temp_asc_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_directory_exists(dir, access = "rw")
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = "I do not exist 1234567890",
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_class(shape, "SpatVector", null.ok = TRUE)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = 1,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_numeric(box, len = 4, null.ok = TRUE)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = "",
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = 1:3,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(dateline_fix)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = "",
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(extreme_outlier_fix)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = "",
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_flag(overwrite)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = "",
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_number(dx, finite = TRUE)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = "",
    na_flag = -99
  ) |>
    testthat::expect_error()

  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = Inf,
    na_flag = -99
  ) |>
    testthat::expect_error()

  # checkmate::assert_int(na_flag)
  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = NULL,
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = pi
  ) |>
    testthat::expect_error()

  # if (!terra::is.polygons(shape)) { [...]

  worldclim_to_ascii(
    file = temp_tif_file,
    dir = dirname(temp_tif_file[1]),
    shape = rbind(c(-2, 5)) |> terra::vect(type = "point"),
    box = NULL,
    dateline_fix = TRUE,
    extreme_outlier_fix = TRUE,
    overwrite = TRUE,
    dx = -45,
    na_flag = -99
  ) |>
    testthat::expect_error()
})
