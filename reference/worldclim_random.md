# Return a random WorldClim data selection

`worldclim_random()` returns a random selection of parameters for
downloading [WorldClim](https://worldclim.org/) data.

## Usage

``` r
worldclim_random(series = "hcd")
```

## Arguments

- series:

  A string indicating the [WorldClim](https://worldclim.org/) data
  series to use. The following options are available:

  - `'hcd'` (Historical Climate Data).

  - `'hmwd'` (Historical Monthly Weather Data).

  - `'fcd'` (Future Climate Data).

## Value

A [`list`](https://rdrr.io/r/base/list.html) with a random selection of
parameters for downloading WorldClim data. The list contains the
following elements:

- `series`: The selected data series.

- `resolution`: The selected spatial resolution.

- `variable`: The selected climate variable.

- `bioclimatic_variable`: The selected bioclimatic variable (only for
  Historical Climate Data and Future Climate Data when `variable` is set
  to `"bioc"`).

- `model`: The selected climate model (only for Future Climate Data).

- `ssp`: The selected Shared Socioeconomic Pathway (only for Future
  Climate Data).

- `year`: The selected year or year range.

- `month`: The selected month.

## See also

Other WorldClim functions:
[`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md),
[`worldclim_extract_variable()`](https://danielvartan.github.io/orbis/reference/worldclim_extract_variable.md),
[`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
[`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md),
[`worldclim_url()`](https://danielvartan.github.io/orbis/reference/worldclim_url.md)

## Examples

``` r
worldclim_random("hcd")
#> $series
#> Historical Climate Data 
#>                   "hcd" 
#> 
#> $resolution
#> 5 Minutes (~85 km2 at the Equator) 
#>                               "5m" 
#> 
#> $variable
#> Total Precipitation (mm) 
#>                   "prec" 
#> 
#> $year
#> 1970-2000 
#>      1971 
#> 
#> $month
#> February 
#>        2 
#> 

worldclim_random("hmwd")
#> $series
#> Historical Monthly Weather Data 
#>                          "hmwd" 
#> 
#> $resolution
#> 2.5 Minutes (~21 km2 at the Equator) 
#>                               "2.5m" 
#> 
#> $variable
#> Average Maximum Temperature (°C) 
#>                           "tmax" 
#> 
#> $year
#> 2010-2019 
#>      2011 
#> 
#> $month
#> September 
#>         9 
#> 

worldclim_random("fcd")
#> $series
#> Future Climate Data 
#>               "fcd" 
#> 
#> $resolution
#> 2.5 Minutes (~21 km2 at the Equator) 
#>                               "2.5m" 
#> 
#> $variable
#> Average Minimum Temperature (°C) 
#>                           "tmin" 
#> 
#> $model
#> Model for Interdisciplinary Research on Climate, Japan 
#>                                               "MIROC6" 
#> 
#> $ssp
#>  SSP-585 
#> "ssp585" 
#> 
#> $year
#> 2021-2040 
#>      2023 
#> 
#> $month
#> August 
#>      8 
#> 
```
