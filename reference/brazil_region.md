# Get Brazilian regions

`brazil_region()` returns a vector with the names of [Brazilian
regions](https://en.wikipedia.org/wiki/Regions_of_Brazil).

## Usage

``` r
brazil_region(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names, abbreviations, or numeric codes of
  Brazilian states or federal units. Region and municipality codes are
  also supported. If `NULL`, returns a vector with all Brazilian
  regions. (default: `NULL`)

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
names of Brazilian regions.

## Details

The data from this function is based on data from the Brazilian
Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/),
n.d.).

## References

Instituto Brasileiro de Geografia e Estatística. (n.d.). *Território*
\[Territory\] \[Dataset\]. SIDRA. <https://sidra.ibge.gov.br/territorio>

## See also

Other Brazil functions:
[`brazil_fu()`](https://danielvartan.github.io/orbis/reference/brazil_fu.md),
[`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md),
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md),
[`brazil_municipality_coords()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_coords.md),
[`brazil_municipality_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_latitude.md),
[`brazil_municipality_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_longitude.md),
[`brazil_region_code()`](https://danielvartan.github.io/orbis/reference/brazil_region_code.md),
[`brazil_render_address()`](https://danielvartan.github.io/orbis/reference/brazil_render_address.md),
[`brazil_state()`](https://danielvartan.github.io/orbis/reference/brazil_state.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_region()
#> [1] "North"        "Northeast"    "South"        "Southeast"   
#> [5] "Central-West"
#> [1] "North" "Northeast" "South" "Southeast" "Central-West" # Expected

brazil_region("sp")
#> [1] "Southeast"
#> [1] "Southeast" # Expected

brazil_region("sao paulo")
#> [1] "Southeast"
#> [1] "Southeast" # Expected

brazil_region(c(1, 4))
#> [1] "North" "South"
#> [1] "North" "South" # Expected

brazil_region(35) # State of São Paulo
#> [1] "Southeast"
#> [1] "Southeast" # Expected

brazil_region(3550308) # Municipality of São Paulo
#> [1] "Southeast"
#> [1] "Southeast" # Expected

brazil_region(35503081) # >7 digits
#> [1] NA
#> [1] NA # Expected
```
