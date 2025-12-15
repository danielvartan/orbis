# Extract components from WorldClim file names

`worldclim_extract_*()` extract components present in WorldClim file
names.

## Usage

``` r
worldclim_extract_variable(file)

worldclim_extract_resolution(file)

worldclim_extract_month(file)

worldclim_extract_year(file)

worldclim_extract_year_month(file)

worldclim_extract_year_group(file)

worldclim_extract_gcm(file)

worldclim_extract_ssp(file)
```

## Arguments

- file:

  A [`character`](https://rdrr.io/r/base/character.html) vector with
  WorldClim file names.

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
extracted component.

## See also

Other WorldClim functions:
[`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md),
[`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
[`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
[`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md),
[`worldclim_url()`](https://danielvartan.github.io/orbis/reference/worldclim_url.md)

## Examples

``` r
files <- c(
  "wc2.1_10m_tavg_1970-2000-06.asc",
  "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
  "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc"
)

files |> worldclim_extract_variable()
#> [1] "tavg" "tmin" "tmax"
#> [1] "tavg" "tmin" "tmax" # Expected

files |> worldclim_extract_resolution()
#> [1] "10m" "30s" "5m" 
#> [1] "10m" "30s" "5m" # Expected

files |> worldclim_extract_month()
#> [1] "06" "10" "05"
#> [1] "06" "10" "05" # Expected

files |> worldclim_extract_year()
#> [1] "1970-2000" "1962"      "2081-2100"
#> [1] "1970-2000" "1962"      "2081-2100" # Expected

files |> worldclim_extract_year_month()
#> [1] "1970-2000-06" "1962-10"      "2081-2100-05"
#> [1] "1970-2000-06" "1962-10"      "2081-2100-05" # Expected

files |> worldclim_extract_year_group()
#> [1] "1970-2000" NA          "2081-2100"
#> [1] "1970-2000" NA          "2081-2100" # Expected

files |> worldclim_extract_gcm()
#> [1] NA            NA            "GISS-E2-1-G"
#> [1] NA            NA            "GISS-E2-1-G" # Expected

files |> worldclim_extract_ssp()
#> [1] NA       NA       "ssp370"
#> [1] NA       NA       "ssp370" # Expected
```
