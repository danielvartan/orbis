# Get Brazilian region codes

`brazil_region_code()` returns a vector with the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) codes for
Brazilian regions.

## Usage

``` r
brazil_region_code(x = NULL)
```

## Arguments

- x:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector containing the names of Brazilian regions, states, or federal
  units. If `NULL`, returns a named vector with all Brazilian region
  codes (default: `NULL`).

## Value

An [`integer`](https://rdrr.io/r/base/integer.html) vector with the
[IBGE](https://www.ibge.gov.br/) codes of Brazilian regions.

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
[`brazil_region()`](https://danielvartan.github.io/orbis/reference/brazil_region.md),
[`brazil_render_address()`](https://danielvartan.github.io/orbis/reference/brazil_render_address.md),
[`brazil_state()`](https://danielvartan.github.io/orbis/reference/brazil_state.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_region_code()
#>        North    Northeast    Southeast        South Central-West 
#>            1            2            3            4            5 

brazil_region_code("north")
#> [1] 1
#> [1] 1 # Expected

brazil_region_code(c("north", "central-west"))
#> [1] 1 5
#> [1] 1 5 # Expected

brazil_region_code("sao paulo")
#> [1] 3
#> [1] 3 # Expected

brazil_region_code("sp")
#> [1] 3
#> [1] 3 # Expected
```
