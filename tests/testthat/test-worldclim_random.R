testthat::test_that("`worldclim_random()` | General test", {
  worldclim_random("hcd") |>
    names() |>
    checkmate::expect_subset(
      c(
        "series", "resolution", "variable", "bioclimatic_variable", "month",
        "year"
      )
    )

  worldclim_random("hcd") |>
    lapply(names) |>
    unlist() |>
    unname() |>
    checkmate::expect_subset(
      c(
        "Historical Climate Data",
        "10 Minutes (~340 km2 at the Equator)",
        "5 Minutes (~85 km2 at the Equator)",
        "2.5 Minutes (~21 km2 at the Equator)",
        "30 Seconds (~1 km2  at the Equator)",
        "Average Maximum Temperature (\u00b0C)",
        "Average Minimum Temperature (\u00b0C)",
        "Average Temperature (\u00b0C)",
        "Bioclimatic Variables",
        "Elevation",
        "Solar Radiation (kJ m^-2 day^-1)",
        "Total Precipitation (mm)",
        "Water Vapor Pressure (kPa)",
        "Wind Speed (m s^-1)",
        "BIO1 - Annual Mean Temperature",
        "BIO2 - Mean Diurnal Range (Mean of Monthly (Max Temp - Min Temp))",
        "BIO3 - Isothermality (BIO2 / BIO7) (\u00d7100)",
        "BIO4 - Temperature Seasonality (Standard Deviation \u00d7100)",
        "BIO5 - Max Temperature of Warmest Month",
        "BIO6 - Min Temperature of Coldest Month",
        "BIO7 - Temperature Annual Range (BIO5 - BIO6)",
        "BIO8 - Mean Temperature of Wettest Quarter",
        "BIO9 - Mean Temperature of Driest Quarter",
        "BIO10 - Mean Temperature of Warmest Quarter",
        "BIO11 - Mean Temperature of Coldest Quarter",
        "BIO12 - Annual Precipitation",
        "BIO13 - Precipitation of Wettest Month",
        "BIO14 - Precipitation of Driest Month",
        "BIO15 - Precipitation Seasonality (Coefficient of Variation)",
        "BIO16 - Precipitation of Wettest Quarter",
        "BIO17 - Precipitation of Driest Quarter",
        "BIO18 - Precipitation of Warmest Quarter",
        "BIO19 - Precipitation of Coldest Quarter",
        month.name,
        "1970-2000"
      )
    )

  worldclim_random("hmwd") |>
    names() |>
    checkmate::expect_subset(
      c("series", "resolution", "variable",  "month", "year")
    )

  worldclim_random("hmwd") |>
    lapply(names) |>
    unlist() |>
    unname() |>
    checkmate::expect_subset(
      c(
        "Historical Monthly Weather Data",
        "10 Minutes (~340 km2 at the Equator)",
        "5 Minutes (~85 km2 at the Equator)",
        "2.5 Minutes (~21 km2 at the Equator)",
        "Average Maximum Temperature (\u00b0C)",
        "Average Minimum Temperature (\u00b0C)",
        "Total Precipitation (mm)",
        month.name,
        "1950-1959",
        "1960-1969",
        "1970-1979",
        "1980-1989",
        "1990-1999",
        "2000-2009",
        "2010-2019",
        "2020-2024"
      )
    )

  worldclim_random("fcd") |>
    names() |>
    checkmate::expect_subset(
      c(
        "series", "resolution", "variable", "bioclimatic_variable", "model",
        "ssp", "month", "year"
      )
    )

  worldclim_random("fcd") |>
    lapply(names) |>
    unlist() |>
    unname() |>
    checkmate::expect_subset(
      c(
        "Future Climate Data",
        "10 Minutes (~340 km2 at the Equator)",
        "5 Minutes (~85 km2 at the Equator)",
        "2.5 Minutes (~21 km2 at the Equator)",
        "30 Seconds (~1 km2  at the Equator)",
        "Average Maximum Temperature (\u00b0C)",
        "Average Minimum Temperature (\u00b0C)",
        "Bioclimatic Variables",
        "Total Precipitation (mm)",
        "BIO1 - Annual Mean Temperature",
        "BIO2 - Mean Diurnal Range (Mean of Monthly (Max Temp - Min Temp))",
        "BIO3 - Isothermality (BIO2 / BIO7) (\u00d7100)",
        "BIO4 - Temperature Seasonality (Standard Deviation \u00d7100)",
        "BIO5 - Max Temperature of Warmest Month",
        "BIO6 - Min Temperature of Coldest Month",
        "BIO7 - Temperature Annual Range (BIO5 - BIO6)",
        "BIO8 - Mean Temperature of Wettest Quarter",
        "BIO9 - Mean Temperature of Driest Quarter",
        "BIO10 - Mean Temperature of Warmest Quarter",
        "BIO11 - Mean Temperature of Coldest Quarter",
        "BIO12 - Annual Precipitation",
        "BIO13 - Precipitation of Wettest Month",
        "BIO14 - Precipitation of Driest Month",
        "BIO15 - Precipitation Seasonality (Coefficient of Variation)",
        "BIO16 - Precipitation of Wettest Quarter",
        "BIO17 - Precipitation of Driest Quarter",
        "BIO18 - Precipitation of Warmest Quarter",
        "BIO19 - Precipitation of Coldest Quarter",
        "Australian Community Climate and Earth-System Simulator, Australia",
        "Beijing Climate Center Climate System Model, China",
        "Centro Euro-Mediterraneo sui Cambiamenti Climatici, Italy",
        "European Consortium Earth System Model, Europe",
        "First Institute of Oceanography Earth System Model, China",
        "Geophysical Fluid Dynamics Laboratory, USA",
        "NASA Goddard Institute for Space Studies, USA",
        "UK Met Office Hadley Centre, UK",
        "Institute for Numerical Mathematics, Russia",
        "Institut Pierre-Simon Laplace, France",
        "Model for Interdisciplinary Research on Climate, Japan",
        "Max Planck Institute for Meteorology, Germany",
        "Meteorological Research Institute, Japan",
        "UK Earth System Model, UK",
        "SSP-126",
        "SSP-245",
        "SSP-370",
        "SSP-585",
        month.name,
        "2021-2040",
        "2041-2060",
        "2061-2080",
        "2081-2100"
      )
    )
})
