testthat::test_that("`worldclim_extract_variable()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_variable() |>
    testthat::expect_equal(
      c("tavg", "bioc", "elev", "tmin", "tmax", "bioc")
    )
})

testthat::test_that("`worldclim_extract_resolution()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_resolution() |>
    testthat::expect_equal(
      c("10m", "10m", "10m", "30s", "5m", "10m")
    )
})

testthat::test_that("`worldclim_extract_month()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_month() |>
    testthat::expect_equal(
      c("06", NA, NA, "10", "05", NA)
    )
})

testthat::test_that("`worldclim_extract_year()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_year() |>
    testthat::expect_equal(
      c("1970-2000", "1970-2000", "1970-2000", "1962", "2081-2100", "2021-2040")
    )
})

testthat::test_that("`worldclim_extract_year_month()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_year_month() |>
    testthat::expect_equal(
      c("1970-2000-06", NA, NA, "1962-10", "2081-2100-05", NA)
    )
})

testthat::test_that("`worldclim_extract_year_group()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_year_group() |>
    testthat::expect_equal(
      c("1970-2000", "1970-2000", "1970-2000", NA, "2081-2100", "2021-2040")
    )
})

testthat::test_that("`worldclim_extract_gcm()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_gcm() |>
    testthat::expect_equal(
      c(NA, NA, NA, NA, "GISS-E2-1-G", "ACCESS-CM2")
    )
})

testthat::test_that("`worldclim_extract_ssp()` | General test", {
  files <- c(
    "wc2.1_10m_tavg_1970-2000-06.asc",
    "wc2.1_10m_bioc_1970-2000_01.asc",
    "wc2.1_10m_elev_1970-2000.asc",
    "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
    "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc",
    "wc2.1_10m_bioc_ACCESS-CM2_ssp126_2021-2040_01.asc"
  )

  files |>
    worldclim_extract_ssp() |>
    testthat::expect_equal(
      c(NA, NA, NA, NA, "ssp370", "ssp126")
    )
})
