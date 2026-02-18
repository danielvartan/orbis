# Download WorldClim data

`worldclim_download()` downloads and unzips data from the
[WorldClim](https://worldclim.org/) website.

See
[`worldclim_global()`](https://rdrr.io/pkg/geodata/man/worldclim.html),
[`worldclim_country()`](https://rdrr.io/pkg/geodata/man/worldclim.html),
and [`worldclim_tile()`](https://rdrr.io/pkg/geodata/man/worldclim.html)
from the [geodata](https://cran.r-project.org/package=geodata) package
for alternative ways to download WorldClim data.

**Note:** This function requires an active internet connection and the
[`fs`](https://CRAN.R-project.org/package=fs),
[`httr2`](https://CRAN.R-project.org/package=httr2),
[`rvest`](https://CRAN.R-project.org/package=rvest), and
[`zip`](https://CRAN.R-project.org/package=zip) packages to be
installed.

## Usage

``` r
worldclim_download(
  series,
  resolution = NULL,
  variable = NULL,
  model = NULL,
  ssp = NULL,
  year = NULL,
  dir = here::here("data"),
  connection_timeout = 60,
  max_tries = 3,
  retry_on_failure = TRUE,
  backoff = function(attempt) 5^attempt
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

- dir:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the directory where to save the downloaded files
  (default: `here::here("data")`).

- connection_timeout:

  (optional) A [`numeric`](https://rdrr.io/r/base/numeric.html) value
  specifying the connection timeout in seconds for HTTP requests
  (default: `60`).

- max_tries:

  (optional) A [`numeric`](https://rdrr.io/r/base/numeric.html) value
  specifying the maximum number of retry attempts (default: `3`).

- retry_on_failure:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) value
  indicating whether to retry on failure (default: `TRUE`).

- backoff:

  (optional) A [`function`](https://rdrr.io/r/base/function.html) that
  takes the current attempt number as input and returns the number of
  seconds to wait before the next attempt (default:
  `\(attempt) 5^attempt`).

## Value

An invisible [`character`](https://rdrr.io/r/base/character.html) vector
with the file path(s) of the downloaded data.

## See also

Other WorldClim functions:
[`worldclim_extract_variable()`](https://danielvartan.github.io/orbis/reference/worldclim_extract_variable.md),
[`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
[`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
[`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md),
[`worldclim_url()`](https://danielvartan.github.io/orbis/reference/worldclim_url.md)

## Examples

``` r
# \dontrun{
  if (FALSE) {
    worldclim_download(
      series = "hcd",
      resolution = "10m",
      variable = "prec"
    )
  }
# }

# \dontrun{
  if (FALSE) {
    worldclim_download(
      series = "fcd",
      resolution = "10m",
      variable = "tmin",
      model = "ACCESS-CM2",
      ssp = "ssp245",
      year = "2041-2060"
    )
  }
# }
```
