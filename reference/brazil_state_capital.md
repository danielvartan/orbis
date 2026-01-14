# Get Brazilian state capital names

`brazil_state_capital()` returns a vector with the capital names of
Brazilian states or federal units.

## Usage

``` r
brazil_state_capital(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names of Brazilian states or federal units.
  Municipality and state codes are also supported. If `NULL`, returns a
  vector with all state capital names (default: `NULL`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
names of Brazilian state capitals.

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
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_state_capital()
#>                Acre             Alagoas               Amapá 
#>        "Rio Branco"            "Maceió"            "Macapá" 
#>            Amazonas               Bahia               Ceará 
#>            "Manaus"          "Salvador"         "Fortaleza" 
#>    Distrito Federal      Espírito Santo               Goiás 
#>          "Brasília"           "Vitória"           "Goiânia" 
#>            Maranhão         Mato Grosso  Mato Grosso do Sul 
#>          "São Luís"            "Cuiabá"      "Campo Grande" 
#>        Minas Gerais                Pará             Paraíba 
#>    "Belo Horizonte"             "Belém"       "João Pessoa" 
#>              Paraná          Pernambuco               Piauí 
#>          "Curitiba"            "Recife"          "Teresina" 
#>      Rio de Janeiro Rio Grande do Norte   Rio Grande do Sul 
#>    "Rio de Janeiro"             "Natal"      "Porto Alegre" 
#>            Rondônia             Roraima      Santa Catarina 
#>       "Porto Velho"         "Boa Vista"     "Florianópolis" 
#>           São Paulo             Sergipe           Tocantins 
#>         "São Paulo"           "Aracaju"            "Palmas" 

brazil_state_capital("pi")
#> [1] "Teresina"
#> [1] "Teresina" # Expected

brazil_state_capital("piaui")
#> [1] "Teresina"
#> [1] "Teresina" # Expected

brazil_state_capital(22)
#> [1] "Teresina"
#> [1] "Teresina" # Expected

brazil_state_capital(2211001) # Teresina
#> [1] "Teresina"
#> [1] "Teresina" # Expected

brazil_state_capital(22110011) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_state_capital(3912345) # Non-existent state code
#> [1] NA
#> [1] NA # Expected
```
