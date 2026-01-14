# Get Brazilian federative unit abbreviations

`brazil_fu()` returns a vector with the abbreviations of Brazilian
federal units.

## Usage

``` r
brazil_fu(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names or numeric codes of Brazilian regions or
  federal units. Municipality codes are also supported. If `NULL`,
  returns a [`character`](https://rdrr.io/r/base/character.html) vector
  with all Brazilian federal unit abbreviations (default: `NULL`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
abbreviations of Brazilian federal units.

## Details

Data from this function is based on data from the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/), n.d.).

## References

Instituto Brasileiro de Geografia e Estatística. (n.d.). *Território*
\[Territory\] \[Dataset\]. SIDRA. <https://sidra.ibge.gov.br/territorio>

## See also

Other Brazil functions:
[`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md),
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md),
[`brazil_municipality_coords()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_coords.md),
[`brazil_municipality_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_latitude.md),
[`brazil_municipality_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_longitude.md),
[`brazil_region()`](https://danielvartan.github.io/orbis/reference/brazil_region.md),
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
brazil_fu()
#>  [1] "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" "MG" "PA"
#> [15] "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO"

brazil_fu("sp")
#> [1] "SP"
#> [1] "SP" # Expected

brazil_fu("sao paulo")
#> [1] "SP"
#> [1] "SP" # Expected

brazil_fu(35)
#> [1] "SP"
#> [1] "SP" # Expected

brazil_fu(3550308) # Municipality of São Paulo
#> [1] "SP"
#> [1] "SP" # Expected

brazil_fu(35503081) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_fu(39027001) # Non-existent state code
#> [1] NA
#> [1] NA # Expected

brazil_fu("southeast")
#> [1] "ES" "MG" "RJ" "SP"
#> [1] "ES" "MG" "RJ" "SP" # Expected

brazil_fu(3)
#> [1] "ES" "MG" "RJ" "SP"
#> [1] "ES" "MG" "RJ" "SP" # Expected
```
