#' Return a random WorldClim data selection
#'
#' @description
#'
#' `worldclim_random()` returns a random selection of parameters for
#' downloading WorldClim data.
#'
#' @param series A string indicating the WorldClim data series to use. Choices
#'   are: `'hcd'` (Historical Climate Data), `'hmwd'` (Historical Monthly
#'   Weather Data), or `'fcd'` (Future Climate Data) (default: `"hcd"`).
#'
#' @return A [`list`][base::list()] with a random selection of parameters for
#'   downloading WorldClim data. The list contains the following elements:
#'   - `series`: The selected data series.
#'   - `resolution`: The selected spatial resolution.
#'   - `variable`: The selected climate variable.
#'   - `bioclimatic_variable`: The selected bioclimatic variable (only for
#'      Historical Climate Data and Future Climate Data when `variable` is
#'      set to `"bioc"`).
#'   - `model`: The selected climate model (only for Future Climate Data).
#'   - `ssp`: The selected Shared Socioeconomic Pathway (only for Future
#'      Climate Data).
#'   - `month`: The selected month.
#'   - `year`: The selected year or year range.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' worldclim_random("hcd")
#'
#' worldclim_random("hmwd")
#'
#' worldclim_random("fcd")
worldclim_random <- function(series = "hcd") {
  series_choices <- c(
    "hcd", "historical-climate-data", "historical climate data",
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data",
    "fcd", "future-climate-data", "future climate data"
  )

  checkmate::assert_choice(tolower(series), series_choices)

  resolution_choices <- c(
    "10 Minutes (~340 km2 at the Equator)" = "10m",
    "5 Minutes (~85 km2 at the Equator)" = "5m",
    "2.5 Minutes (~21 km2 at the Equator)" = "2.5m",
    "30 Seconds (~1 km2  at the Equator)" = "30s"
  )

  hcd_variable_choices <- c(
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Temperature (\u00b0C)" = "tavg",
    "Bioclimatic Variables" = "bioc",
    "Elevation" = "elev",
    "Solar Radiation (kJ m^-2 day^-1)" = "srad",
    "Total Precipitation (mm)" = "prec",
    "Water Vapor Pressure (kPa)" = "vapr",
    "Wind Speed (m s^-1)" = "wind"
  )

  hmwd_variable_choices <- c(
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Total Precipitation (mm)" = "prec"
  )

  fcd_variable_choices <- c(
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Total Precipitation (mm)" = "prec",
    "Bioclimatic Variables" = "bioc"
  )

  bioclimatic_variable_choices <- c(
    "BIO1 - Annual Mean Temperature" = 1L,
    "BIO2 - Mean Diurnal Range (Mean of Monthly (Max Temp - Min Temp))" = 2L,
    "BIO3 - Isothermality (BIO2 / BIO7) (\u00d7100)" = 3L,
    "BIO4 - Temperature Seasonality (Standard Deviation \u00d7100)" = 4L,
    "BIO5 - Max Temperature of Warmest Month" = 5L,
    "BIO6 - Min Temperature of Coldest Month" = 6L,
    "BIO7 - Temperature Annual Range (BIO5 - BIO6)" = 7L,
    "BIO8 - Mean Temperature of Wettest Quarter" = 8L,
    "BIO9 - Mean Temperature of Driest Quarter" = 9L,
    "BIO10 - Mean Temperature of Warmest Quarter" = 10L,
    "BIO11 - Mean Temperature of Coldest Quarter" = 11L,
    "BIO12 - Annual Precipitation" = 12L,
    "BIO13 - Precipitation of Wettest Month" = 13L,
    "BIO14 - Precipitation of Driest Month" = 14L,
    "BIO15 - Precipitation Seasonality (Coefficient of Variation)" = 15L,
    "BIO16 - Precipitation of Wettest Quarter" = 16L,
    "BIO17 - Precipitation of Driest Quarter" = 17L,
    "BIO18 - Precipitation of Warmest Quarter" = 18L,
    "BIO19 - Precipitation of Coldest Quarter" = 19L
  )

  model_choices <- c(
    "ACCESS-CM2", "BCC-CSM2-MR", "CMCC-ESM2", "EC-EARTH3-VEG", "FIO-ESM-2-0",
    "GFDL-ESM4", "GISS-E2-1-G", "HADGEM3-GC31-LL", "INM-CM5-0", "IPSL-CM6A-LR",
    "MIROC6", "MPI-ESM1-2-HR", "MRI-ESM2-0", "UKESM1-0-LL"
  )

  ssp_choices <- c(
    "SSP-126" = "ssp126",
    "SSP-245" = "ssp245",
    "SSP-370" = "ssp370",
    "SSP-585" = "ssp585"
  )

  resolution <- resolution_choices |> sample(1)

  month <- 1:12 |> sample(1)
  month <- month |> magrittr::set_names(month.name[month])

  if (series %in% c(
    "hcd", "historical-climate-data", "historical climate data"
  )) {
    out <- list(
      series = c("Historical Climate Data" = "historical-climate-data"),
      resolution = resolution,
      variable = hcd_variable_choices |> sample(1),
      month = month,
      year = 1970:2000 |> sample(1) |> magrittr::set_names("1970-2000")
    )

    if (out$variable == "bioc") {
      append(
        out,
        list(bioclimatic_variable = bioclimatic_variable_choices |> sample(1)),
        after = 3
      )
    } else {
      out
    }
  } else if (series %in% c(
    "hmwd", "historical-monthly-weather-data",
    "historical monthly weather data"
  )) {
    list(
      series = c(
        "Historical Monthly Weather Data" = "historical-monthly-weather-data"
      ),
      resolution = resolution,
      variable = hmwd_variable_choices |> sample(1),
      month = month,
      year = 1951:2024 |> sample(1)
    )
  } else if (series %in% c(
    "fcd", "future-climate-data", "future climate data"
  )) {
    year <- 2021:2100 |> sample(1)

    if (dplyr::between(year, 2021, 2040)) {
      year <- year |> magrittr::set_names("2021-2040")
    } else if (dplyr::between(year, 2041, 2060)) {
      year <- year |> magrittr::set_names("2041-2060")
    } else if (dplyr::between(year, 2061, 2080)) {
      year <- year |> magrittr::set_names("2061-2080")
    } else if (dplyr::between(year, 2081, 2100)) {
      year <- year |> magrittr::set_names("2081-2100")
    }

    out <- list(
      series = c("Future Climate Data" = "future-climate-data"),
      resolution = resolution,
      variable = fcd_variable_choices |> sample(1),
      model = model_choices |> sample(1),
      ssp = ssp_choices |> sample(1),
      month = month,
      year = year
    )

    if (out$variable == "bioc") {
      append(
        out,
        list(bioclimatic_variable = bioclimatic_variable_choices |> sample(1)),
        after = 3
      )
    } else {
      out
    }
  }
}
