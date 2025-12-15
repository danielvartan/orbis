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
#> 30 Seconds (~1 km2  at the Equator) 
#>                               "30s" 
#> 
#> $variable
#> Average Temperature (°C) 
#>                   "tavg" 
#> 
#> $year
#> 1970-2000 
#>      1973 
#> 
#> $month
#> June 
#>    6 
#> 

worldclim_random("hmwd")
#> $series
#> Historical Monthly Weather Data 
#>                          "hmwd" 
#> 
#> $resolution
#> 10 Minutes (~340 km2 at the Equator) 
#>                                "10m" 
#> 
#> $variable
#> Total Precipitation (mm) 
#>                   "prec" 
#> 
#> $year
#> 1980-1989 
#>      1980 
#> 
#> $month
#> August 
#>      8 
#> 

worldclim_random("fcd")
#> $series
#> Future Climate Data 
#>               "fcd" 
#> 
#> $resolution
#> 10 Minutes (~340 km2 at the Equator) 
#>                                "10m" 
#> 
#> $variable
#> Total Precipitation (mm) 
#>                   "prec" 
#> 
#> $model
#> Centro Euro-Mediterraneo sui Cambiamenti Climatici, Italy 
#>                                               "CMCC-ESM2" 
#> 
#> $ssp
#>  SSP-585 
#> "ssp585" 
#> 
#> $year
#> 2061-2080 
#>      2061 
#> 
#> $month
#> July 
#>    7 
#> 
```
