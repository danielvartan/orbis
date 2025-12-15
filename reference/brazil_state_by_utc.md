# Get Brazilian state names by UTC

`brazil_state_by_utc()` returns a vector with the names of Brazilian
states or abbreviations of Brazilian federal units by the
[UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) offset.

## Usage

``` r
brazil_state_by_utc(utc = -3, type = "fu")
```

## Arguments

- utc:

  (optional) An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkInt.html)
  number with the UTC offset. Available choices are `-5`, `-4`, `-3`, or
  `-2` (default: `-3`).

- type:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the type of value to return. Available choices are
  `"state"` or `"fu"` (default: `"fu"`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
names of Brazilian states or abbreviations of Brazilian federal units.

## Details

The data from this function is based on the 2024b dataset (Released
2024-09-04) from the Internet Assigned Numbers Authority
([IANA](https://www.iana.org/time-zones), 2024)

## References

Internet Assigned Numbers Authority. (2024). *Time zone database (No.
2024b)* \[Dataset\]. <https://www.iana.org/time-zones>

## See also

Other Brazil functions:
[`brazil_fu()`](https://danielvartan.github.io/orbis/reference/brazil_fu.md),
[`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md),
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md),
[`brazil_municipality_coords()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_coords.md),
[`brazil_municipality_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_latitude.md),
[`brazil_municipality_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_longitude.md),
[`brazil_region()`](https://danielvartan.github.io/orbis/reference/brazil_region.md),
[`brazil_region_code()`](https://danielvartan.github.io/orbis/reference/brazil_region_code.md),
[`brazil_render_address()`](https://danielvartan.github.io/orbis/reference/brazil_render_address.md),
[`brazil_state()`](https://danielvartan.github.io/orbis/reference/brazil_state.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_state_by_utc(-3, type = "fu")
#>  [1] "AL" "AP" "BA" "CE" "DF" "ES" "GO" "MA" "MG" "PA" "PB" "PR" "PE" "PI"
#> [15] "RJ" "RN" "RS" "SC" "SP" "SE" "TO"

brazil_state_by_utc(-3, type = "state")
#>  [1] "Alagoas"             "Amapá"               "Bahia"              
#>  [4] "Ceará"               "Distrito Federal"    "Espírito Santo"     
#>  [7] "Goiás"               "Maranhão"            "Minas Gerais"       
#> [10] "Pará"                "Paraíba"             "Paraná"             
#> [13] "Pernambuco"          "Piauí"               "Rio de Janeiro"     
#> [16] "Rio Grande do Norte" "Rio Grande do Sul"   "Santa Catarina"     
#> [19] "São Paulo"           "Sergipe"             "Tocantins"          
```
