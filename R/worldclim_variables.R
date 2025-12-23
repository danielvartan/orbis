worldclim_variables <- list(
  series = c(
    "Historical Climate Data" = "hcd",
    "Historical Monthly Weather Data" = "hmwd",
    "Future Climate Data" = "fcd"
  ),
  series_choices = c(
    "hcd",
    "historical-climate-data",
    "historical climate data",
    "hmwd",
    "historical-monthly-weather-data",
    "historical monthly weather data",
    "fcd",
    "future-climate-data",
    "future climate data"
  ),
  resolutions = c(
    "10 Minutes (~340 km2 at the Equator)" = "10m",
    "5 Minutes (~85 km2 at the Equator)" = "5m",
    "2.5 Minutes (~21 km2 at the Equator)" = "2.5m",
    "30 Seconds (~1 km2  at the Equator)" = "30s"
  ),
  resolution_choices = c("10m", "5m", "2.5m", "30s"),
  hcd_variables = c(
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Temperature (\u00b0C)" = "tavg",
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Solar Radiation (kJ m^-2 day^-1)" = "srad",
    "Total Precipitation (mm)" = "prec",
    "Water Vapor Pressure (kPa)" = "vapr",
    "Wind Speed (m s^-1)" = "wind",
    "Bioclimatic Variables" = "bioc",
    "Elevation" = "elev"
  ),
  hcd_years = 1970:2000 |>
    magrittr::set_names(rep("1970-2000", length(1970:2000))),
  hcd_year_group = "1970-2000",
  hmwd_variables = c(
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Total Precipitation (mm)" = "prec"
  ),
  hmwd_years = 1950:2024 |>
    magrittr::set_names(
      c(
        rep("1950-1959", 10),
        rep("1960-1969", 10),
        rep("1970-1979", 10),
        rep("1980-1989", 10),
        rep("1990-1999", 10),
        rep("2000-2009", 10),
        rep("2010-2019", 10),
        rep("2020-2024", 5)
      )
    ),
  fcd_variables = c(
    "Average Minimum Temperature (\u00b0C)" = "tmin",
    "Average Maximum Temperature (\u00b0C)" = "tmax",
    "Total Precipitation (mm)" = "prec",
    "Bioclimatic Variables" = "bioc"
  ),
  fcd_years = 2021:2100 |>
    magrittr::set_names(
      c(
        rep("2021-2040", 20),
        rep("2041-2060", 20),
        rep("2061-2080", 20),
        rep("2081-2100", 20)
      )
    ),
  fcd_year_groups = c("2021-2040", "2041-2060", "2061-2080", "2081-2100"),
  bioclimatic_variables = c(
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
  ),
  # fmt: skip
  models = c(
    "Australian Community Climate and Earth-System Simulator, Australia" =
      "ACCESS-CM2",
    "Beijing Climate Center Climate System Model, China" = "BCC-CSM2-MR",
    "Centro Euro-Mediterraneo sui Cambiamenti Climatici, Italy" = "CMCC-ESM2",
    "European Consortium Earth System Model, Europe" = "EC-Earth3-Veg",
    "First Institute of Oceanography Earth System Model, China" = "FIO-ESM-2-0",
    "Geophysical Fluid Dynamics Laboratory, USA" = "GFDL-ESM4",
    "NASA Goddard Institute for Space Studies, USA" = "GISS-E2-1-G",
    "UK Met Office Hadley Centre, UK" = "HadGEM3-GC31-LL",
    "Institute for Numerical Mathematics, Russia" = "INM-CM5-0",
    "Institut Pierre-Simon Laplace, France" = "IPSL-CM6A-LR",
    "Model for Interdisciplinary Research on Climate, Japan" = "MIROC6",
    "Max Planck Institute for Meteorology, Germany" = "MPI-ESM1-2-HR",
    "Meteorological Research Institute, Japan" = "MRI-ESM2-0",
    "UK Earth System Model, UK" = "UKESM1-0-LL"
  ),
  ssps = c(
    "SSP-126" = "ssp126",
    "SSP-245" = "ssp245",
    "SSP-370" = "ssp370",
    "SSP-585" = "ssp585"
  ),
  months = 1:12 |> magrittr::set_names(month.name)
)
