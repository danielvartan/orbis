# Get file paths to WorldClim data

`worldclim_file()` returns the file path(s) of a
[WorldClim](https://worldclim.org/) data series.

## Usage

``` r
worldclim_file(
  series,
  resolution = NULL,
  variable = NULL,
  model = NULL,
  ssp = NULL,
  year = NULL
)
```

## Arguments

- series:

  A [`character`](https://rdrr.io/r/base/character.html) vector with the
  name of the WorldClim data series (default: `"hcd"`). The following
  options are available:

  - `"hcd"` = Historical Climate Data

  - `"hmwd"` = Historical Monthly Weather Data

  - `"fcd"` = Future Climate Data

- resolution:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the resolution of the WorldClim data series (default:
  `NULL`). The following options are available:

  - `"10m"` = 10 Minutes (~340 km2 at the Equator)

  - `"5m"` = 5 Minutes (~85 km2 at the Equator)

  - `"2.5m"` = 2.5 Minutes (~21 km2 at the Equator)

  - `"30s"` = 30 Seconds (~1 km2 at the Equator) (not available for the
    `"hmwd"` series)

- variable:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the variable of the WorldClim data series (default:
  `NULL`).

  The following options are available for the *Historical Climate Data*
  series:

  - `"tmin"` = Average Minimum Temperature (°C)

  - `"tavg"` = Average Temperature (°C)

  - `"tmax"` = Average Maximum Temperature (°C)

  - `"srad"` = Solar Radiation (kJ m^-2 day^-1)

  - `"prec"` = Total Precipitation (mm)

  - `"vapr"` = Water Vapor Pressure (kPa)

  - `"wind"` = Wind Speed (m s^-1)

  - `"bioc"` = Bioclimatic Variables

  - `"elev"` = Elevation

  The following options are available for the *Historical Monthly
  Weather Data* series:

  - `"tmin"` = Average Minimum Temperature (°C)

  - `"tmax"` = Average Maximum Temperature (°C)

  - `"prec"` = Total Precipitation (mm)

  The following options are available for the *Future Climate Data*
  series:

  - `"tmin"` = Average Minimum Temperature (°C)

  - `"tmax"` = Average Maximum Temperature (°C)

  - `"prec"` = Total Precipitation (mm)

  - `"bioc"` = Bioclimatic Variables

- model:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the global climate model of the WorldClim data series
  (default: `NULL`).

  The following options are available for the *Future Climate Data*
  series:

  - `"ACCESS-CM2"` = Australian Community Climate and Earth-System
    Simulator, Australia

  - `"BCC-CSM2-MR"` = Beijing Climate Center Climate System Model, China

  - `"CMCC-ESM2"` = Canadian Earth System Model, Italy

  - `"EC-Earth3-Veg"` = European Consortium Earth System Model, Europe

  - \`"FIO-ESM-2-0"“ = First Institute of Oceanography Earth System
    Model, China

  - `"GFDL-ESM4"` = Geophysical Fluid Dynamics Laboratory Earth System
    Model, USA

  - `"GISS-E2-1-G"` = NASA Goddard Institute for Space Studies Model,
    USA

  - `"HadGEM3-GC31-LL"` = Hadley Global Environment Model, UK

  - `"INM-CM5-0"` = Institute of Numerical Mathematics Climate Model,
    Russia

  - `"IPSL-CM6A-LR"` = Institut Pierre-Simon Laplace Climate Model,
    France

  - `"MIROC6"` = Model for Interdisciplinary Research on Climate, Japan

  - `"MPI-ESM1-2-HR"` = Max Planck Institute for Meteorology Earth
    System Model, Germany

  - `"MRI-ESM2-0"` = Meteorological Research Institute Earth System
    Model, Japan

  - `"UKESM1-0-LL"` = UK Earth System Model, UK

- ssp:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the shared socioeconomic pathway (SSP) of the WorldClim
  data series (default: `NULL`).

  The following options are available for the *Future Climate Data*
  series:

  - `"ssp126"` = Sustainability (Taking the Green Road)

  - `"ssp245"` = Middle of the Road

  - `"ssp370"` = Regional Rivalry (A Rocky Road)

  - `"ssp585"` = Fossil-fueled Development (Taking the Highway)

- year:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the year group of the WorldClim data series (default:
  `NULL`). This is only available for the *Historical Monthly Weather
  Data* and *Future Climate Data* series:

  - *Historical Monthly Weather Data*: `"1960-1959"`, `"1970-1979"`,
    `"1980-1989"`, `"1990-1999"`, `"2000-2009"`, `"2010-2019"`,
    `"2020-2024"`

  - *Future Climate Data*: `"2021-2040"`, `"2041-2060"`, `"2061-2080"`,
    `"2081-2100"`

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
file path(s) of the [WorldClim](https://worldclim.org/) data series.

## See also

Other WorldClim functions:
[`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md),
[`worldclim_extract_variable()`](https://danielvartan.github.io/orbis/reference/worldclim_extract_variable.md),
[`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
[`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md),
[`worldclim_url()`](https://danielvartan.github.io/orbis/reference/worldclim_url.md)

## Examples

``` r
library(curl)

# \dontrun{
  if (has_internet()) {
    worldclim_file(series = "hcd")
  }
#>  [1] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_tmin.zip" 
#>  [2] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_tmin.zip"  
#>  [3] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_tmin.zip"
#>  [4] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_tmin.zip" 
#>  [5] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_tmax.zip" 
#>  [6] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_tmax.zip"  
#>  [7] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_tmax.zip"
#>  [8] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_tmax.zip" 
#>  [9] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_tavg.zip" 
#> [10] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_tavg.zip"  
#> [11] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_tavg.zip"
#> [12] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_tavg.zip" 
#> [13] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_prec.zip" 
#> [14] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_prec.zip"  
#> [15] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_prec.zip"
#> [16] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_prec.zip" 
#> [17] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_srad.zip" 
#> [18] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_srad.zip"  
#> [19] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_srad.zip"
#> [20] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_srad.zip" 
#> [21] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_wind.zip" 
#> [22] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_wind.zip"  
#> [23] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_wind.zip"
#> [24] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_wind.zip" 
#> [25] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_vapr.zip" 
#> [26] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_vapr.zip"  
#> [27] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_vapr.zip"
#> [28] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_vapr.zip" 
#> [29] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_bio.zip"  
#> [30] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_bio.zip"   
#> [31] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_bio.zip" 
#> [32] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_bio.zip"  
#> [33] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_elev.zip" 
#> [34] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_5m_elev.zip"  
#> [35] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_elev.zip"
#> [36] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_elev.zip" 
# }

# \dontrun{
  if (has_internet()) {
    worldclim_file(
      series = "hcd",
      resolution = c("10m", "30s"),
      variable = c("tmin", "tavg"))
  }
#> [1] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_tmin.zip"
#> [2] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_tmin.zip"
#> [3] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_10m_tavg.zip"
#> [4] "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_tavg.zip"
# }

# \dontrun{
  if (has_internet()) {
    worldclim_file(
      series = "hmwd",
      resolution = c("10m", "5m"),
      variable = "tmin",
      year = c("1950-1959", "2020-2024")
    )
  }
#> [1] "https://geodata.ucdavis.edu/climate/worldclim/2_1/hist/cts4.09/wc2.1_cruts4.09_10m_tmin_1950-1959.zip"
#> [2] "https://geodata.ucdavis.edu/climate/worldclim/2_1/hist/cts4.09/wc2.1_cruts4.09_5m_tmin_1950-1959.zip" 
#> [3] "https://geodata.ucdavis.edu/climate/worldclim/2_1/hist/cts4.09/wc2.1_cruts4.09_10m_tmin_2020-2024.zip"
#> [4] "https://geodata.ucdavis.edu/climate/worldclim/2_1/hist/cts4.09/wc2.1_cruts4.09_5m_tmin_2020-2024.zip" 
# }

# \dontrun{
  if (has_internet()) {
    worldclim_file(
      series = "fcd",
      resolution = c("2.5m", "30s"),
      variable = c("tmin"),
      model = c("MIROC6", "GISS-E2-1-G"),
      ssp = c("ssp126", "ssp585"),
      year = "2021-2040"
    )
  }
#> [1] "https://geodata.ucdavis.edu/cmip6/2.5m/MIROC6/ssp126/wc2.1_2.5m_tmin_MIROC6_ssp126_2021-2040.tif"          
#> [2] "https://geodata.ucdavis.edu/cmip6/2.5m/GISS-E2-1-G/ssp126/wc2.1_2.5m_tmin_GISS-E2-1-G_ssp126_2021-2040.tif"
#> [3] "https://geodata.ucdavis.edu/cmip6/30s/MIROC6/ssp126/wc2.1_30s_tmin_MIROC6_ssp126_2021-2040.tif"            
#> [4] "https://geodata.ucdavis.edu/cmip6/30s/GISS-E2-1-G/ssp126/wc2.1_30s_tmin_GISS-E2-1-G_ssp126_2021-2040.tif"  
#> [5] "https://geodata.ucdavis.edu/cmip6/2.5m/MIROC6/ssp585/wc2.1_2.5m_tmin_MIROC6_ssp585_2021-2040.tif"          
#> [6] "https://geodata.ucdavis.edu/cmip6/2.5m/GISS-E2-1-G/ssp585/wc2.1_2.5m_tmin_GISS-E2-1-G_ssp585_2021-2040.tif"
#> [7] "https://geodata.ucdavis.edu/cmip6/30s/MIROC6/ssp585/wc2.1_30s_tmin_MIROC6_ssp585_2021-2040.tif"            
#> [8] "https://geodata.ucdavis.edu/cmip6/30s/GISS-E2-1-G/ssp585/wc2.1_30s_tmin_GISS-E2-1-G_ssp585_2021-2040.tif"  
# }
```
