# Get URLs to WorldClim data

`worldclim_url()` returns the URL(s) of a
[WorldClim](https://worldclim.org/) data series.

## Usage

``` r
worldclim_url(series, resolution = NULL)
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

## Value

A named [`character`](https://rdrr.io/r/base/character.html) vector with
the URL(s) of the [WorldClim](https://worldclim.org/) data series.

## See also

Other WorldClim functions:
[`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md),
[`worldclim_extract_variable()`](https://danielvartan.github.io/orbis/reference/worldclim_extract_variable.md),
[`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
[`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
[`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md)

## Examples

``` r
worldclim_url("hcd")
#>                       Historical climate data 
#> "https://worldclim.org/data/worldclim21.html" 

worldclim_url("hmwd")
#>              Historical monthly weather data 
#> "https://worldclim.org/data/monthlywth.html" 

worldclim_url("fcd")
#>                              Future climate data (10m) 
#>  "https://worldclim.org/data/cmip6/cmip6_clim10m.html" 
#>                               Future climate data (5m) 
#>   "https://worldclim.org/data/cmip6/cmip6_clim5m.html" 
#>                             Future climate data (2.5m) 
#> "https://worldclim.org/data/cmip6/cmip6_clim2.5m.html" 
#>                              Future climate data (30s) 
#>  "https://worldclim.org/data/cmip6/cmip6_clim30s.html" 

worldclim_url("fcd", "10m")
#>                             Future climate data (10m) 
#> "https://worldclim.org/data/cmip6/cmip6_clim10m.html" 

worldclim_url(c("hcd", "hmwd", "fcd"))
#>                                Historical climate data 
#>          "https://worldclim.org/data/worldclim21.html" 
#>                        Historical monthly weather data 
#>           "https://worldclim.org/data/monthlywth.html" 
#>                              Future climate data (10m) 
#>  "https://worldclim.org/data/cmip6/cmip6_clim10m.html" 
#>                               Future climate data (5m) 
#>   "https://worldclim.org/data/cmip6/cmip6_clim5m.html" 
#>                             Future climate data (2.5m) 
#> "https://worldclim.org/data/cmip6/cmip6_clim2.5m.html" 
#>                              Future climate data (30s) 
#>  "https://worldclim.org/data/cmip6/cmip6_clim30s.html" 

worldclim_url(c("hcd", "hmwd", "fcd"), "5m")
#>                              Historical climate data 
#>        "https://worldclim.org/data/worldclim21.html" 
#>                      Historical monthly weather data 
#>         "https://worldclim.org/data/monthlywth.html" 
#>                             Future climate data (5m) 
#> "https://worldclim.org/data/cmip6/cmip6_clim5m.html" 

worldclim_url(c("hcd", "hmwd", "fcd"), c("5m", "30s"))
#>                               Historical climate data 
#>         "https://worldclim.org/data/worldclim21.html" 
#>                       Historical monthly weather data 
#>          "https://worldclim.org/data/monthlywth.html" 
#>                              Future climate data (5m) 
#>  "https://worldclim.org/data/cmip6/cmip6_clim5m.html" 
#>                             Future climate data (30s) 
#> "https://worldclim.org/data/cmip6/cmip6_clim30s.html" 
```
