#' @param series A [`character`][base::character()] vector with the name of the
#'   WorldClim data series (default: `"hcd"`).
#'   The following options are available:
#'   - `"hcd"` = Historical Climate Data
#'   - `"hmwd"` = Historical Monthly Weather Data
#'   - `"fcd"` = Future Climate Data
#' @param resolution (optional) A [`character`][base::character()] vector with
#'   the resolution of the WorldClim data series (default: `NULL`).
#'   The following options are available:
#'   - `"10m"` = 10 Minutes (~340 km2 at the Equator)
#'   - `"5m"` = 5 Minutes (~85 km2 at the Equator)
#'   - `"2.5m"` = 2.5 Minutes (~21 km2 at the Equator)
#'   - `"30s"` = 30 Seconds (~1 km2  at the Equator) (not available for the
#'     `"hmwd"` series)
#' @param variable (optional) A [`character`][base::character()] vector with the
#'   variable of the WorldClim data series (default: `NULL`).
#'
#'   The following options are available for the *Historical Climate Data*
#'   series:
#'   - `"tmin"` = Average Minimum Temperature (°C)
#'   - `"tavg"` = Average Temperature (°C)
#'   - `"tmax"` = Average Maximum Temperature (°C)
#'   - `"srad"` = Solar Radiation (kJ m^-2 day^-1)
#'   - `"prec"` = Total Precipitation (mm)
#'   - `"vapr"` = Water Vapor Pressure (kPa)
#'   - `"wind"` = Wind Speed (m s^-1)
#'   - `"bioc"` = Bioclimatic Variables
#'   - `"elev"` = Elevation
#'
#'   The following options are available for the *Historical Monthly Weather
#'   Data* series:
#'
#'   - `"tmin"` = Average Minimum Temperature (°C)
#'   - `"tmax"` = Average Maximum Temperature (°C)
#'   - `"prec"` = Total Precipitation (mm)
#'
#'   The following options are available for the *Future Climate Data* series:
#'
#'   - `"tmin"` = Average Minimum Temperature (°C)
#'   - `"tmax"` = Average Maximum Temperature (°C)
#'   - `"prec"` = Total Precipitation (mm)
#'   - `"bioc"` = Bioclimatic Variables
#' @param model (optional) A [`character`][base::character()] vector with the
#'   global climate model of the WorldClim data series (default: `NULL`).
#'
#'   The following options are available for the *Future Climate Data* series:
#'   - `"ACCESS-CM2"` = Australian Community Climate and Earth-System Simulator,
#'     Australia
#'   - `"BCC-CSM2-MR"` = Beijing Climate Center Climate System Model, China
#'   - `"CMCC-ESM2"` = Canadian Earth System Model, Italy
#'   - `"EC-Earth3-Veg"` = European Consortium Earth System Model, Europe
#'   - `"FIO-ESM-2-0"`` = First Institute of Oceanography Earth System Model,
#'     China
#'   - `"GFDL-ESM4"` = Geophysical Fluid Dynamics Laboratory Earth System Model,
#'     USA
#'   - `"GISS-E2-1-G"` = NASA Goddard Institute for Space Studies Model, USA
#'   - `"HadGEM3-GC31-LL"` = Hadley Global Environment Model, UK
#'   - `"INM-CM5-0"` = Institute of Numerical Mathematics Climate Model, Russia
#'   - `"IPSL-CM6A-LR"` = Institut Pierre-Simon Laplace Climate Model, France
#'   - `"MIROC6"` = Model for Interdisciplinary Research on Climate, Japan
#'   - `"MPI-ESM1-2-HR"` = Max Planck Institute for Meteorology Earth System
#'     Model, Germany
#'   - `"MRI-ESM2-0"` = Meteorological Research Institute Earth System Model,
#'     Japan
#'   - `"UKESM1-0-LL"` = UK Earth System Model, UK
#' @param ssp (optional) A [`character`][base::character()] vector with the
#'   shared socioeconomic pathway (SSP) of the WorldClim data series
#'   (default: `NULL`).
#'
#'   The following options are available for the *Future Climate Data* series:
#'   - `"ssp126"` = Sustainability (Taking the Green Road)
#'   - `"ssp245"` = Middle of the Road
#'   - `"ssp370"` = Regional Rivalry (A Rocky Road)
#'   - `"ssp585"` = Fossil-fueled Development (Taking the Highway)
#' @param year (optional) A [`character`][base::character()] vector with the
#'   year group of the WorldClim data series (default: `NULL`). This is only
#'   available for the *Historical Monthly Weather Data* and *Future Climate
#'   Data* series:
#'   - *Historical Monthly Weather Data*: `"1960-1959"`, `"1970-1979"`,
#'     `"1980-1989"`, `"1990-1999"`,
#'     `"2000-2009"`, `"2010-2019"`, `"2020-2024"`
#'   - *Future Climate Data*: `"2021-2040"`, `"2041-2060"`, `"2061-2080"`,
#'     `"2081-2100"`
