# Get Brazilian state codes

`brazil_state_code()` returns a vector with the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) codes for
Brazilian states.

## Usage

``` r
brazil_state_code(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names of Brazilian states or federal units.
  Municipality codes are also supported. If `NULL`, returns a vector
  with all state codes (default: `NULL`).

## Value

An [`integer`](https://rdrr.io/r/base/integer.html) vector with the
[IBGE](https://www.ibge.gov.br/) codes of Brazilian states.

## Details

Data from this function is based on data from the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/), n.d.).

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
[`brazil_state()`](https://danielvartan.github.io/orbis/reference/brazil_state.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_state_code()
#>                Acre             Alagoas               Amapá 
#>                  12                  27                  16 
#>            Amazonas               Bahia               Ceará 
#>                  13                  29                  23 
#>    Distrito Federal      Espírito Santo               Goiás 
#>                  53                  32                  52 
#>            Maranhão         Mato Grosso  Mato Grosso do Sul 
#>                  21                  51                  50 
#>        Minas Gerais                Pará             Paraíba 
#>                  31                  15                  25 
#>              Paraná          Pernambuco               Piauí 
#>                  41                  26                  22 
#>      Rio de Janeiro Rio Grande do Norte   Rio Grande do Sul 
#>                  33                  24                  43 
#>            Rondônia             Roraima      Santa Catarina 
#>                  11                  14                  42 
#>           São Paulo             Sergipe           Tocantins 
#>                  35                  28                  17 

brazil_state_code("ac")
#> [1] 12
#> [1] 12 # Expected

brazil_state_code("acre")
#> [1] 12
#> [1] 12 # Expected

brazil_state_code(3550308) # São Paulo
#> [1] 35
#> [1] 35 # Expected

brazil_state_code(35503081) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_state_code(3912345) # Non-existent state code
#> [1] NA
#> [1] NA # Expected
```
