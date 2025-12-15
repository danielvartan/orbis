# Get Brazilian state names

`brazil_state()` returns a vector with the names of Brazilian states.

## Usage

``` r
brazil_state(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names or numeric codes of Brazilian regions or
  federal units. Municipality codes are also supported. If `NULL`,
  returns a [`character`](https://rdrr.io/r/base/character.html) vector
  with all Brazilian state names (default: `NULL`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
names of Brazilian states.

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
[`brazil_region_code()`](https://danielvartan.github.io/orbis/reference/brazil_region_code.md),
[`brazil_render_address()`](https://danielvartan.github.io/orbis/reference/brazil_render_address.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_state()
#>  [1] "Acre"                "Alagoas"             "Amapá"              
#>  [4] "Amazonas"            "Bahia"               "Ceará"              
#>  [7] "Distrito Federal"    "Espírito Santo"      "Goiás"              
#> [10] "Maranhão"            "Mato Grosso"         "Mato Grosso do Sul" 
#> [13] "Minas Gerais"        "Pará"                "Paraíba"            
#> [16] "Paraná"              "Pernambuco"          "Piauí"              
#> [19] "Rio de Janeiro"      "Rio Grande do Norte" "Rio Grande do Sul"  
#> [22] "Rondônia"            "Roraima"             "Santa Catarina"     
#> [25] "São Paulo"           "Sergipe"             "Tocantins"          

brazil_state("rj")
#> [1] "Rio de Janeiro"
#> [1] "Rio de Janeiro" # Expected

brazil_state("rio de janeiro")
#> [1] "Rio de Janeiro"
#> [1] "Rio de Janeiro" # Expected

brazil_state(33)
#> [1] "Rio de Janeiro"
#> [1] "Rio de Janeiro" # Expected

brazil_state(3302700) # Maricá
#> [1] "Rio de Janeiro"
#> [1] "Rio de Janeiro" # Expected

brazil_state(33027001) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_state(39027001) # Non-existent state code
#> [1] NA
#> [1] NA # Expected

brazil_state("southeast")
#> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" "São Paulo"     
#> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" # Expected
#> [4] "São Paulo"

brazil_state(3)
#> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" "São Paulo"     
#> [1] "Espírito Santo" "Minas Gerais"   "Rio de Janeiro" # Expected
#> [4] "São Paulo"
```
