# Get Brazilian state latitude

`brazil_state_latitude()` returns a vector with the latitude of
Brazilian state capitals.

## Usage

``` r
brazil_state_latitude(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names of Brazilian states or federal units.
  Municipality and state codes are also supported. If `NULL`, returns a
  vector with all state latitudes (default: `NULL`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
latitude of Brazilian state capitals.

## Details

The data from this function is based on Google's Geocoding API gathered
via the
[`tidygeocoder`](https://jessecambon.github.io/tidygeocoder/reference/tidygeocoder-package.html)
R package.

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
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_state_latitude()
#>                Acre             Alagoas               Amapá 
#>          -9.9765362          -9.6476843           0.0401529 
#>            Amazonas               Bahia               Ceará 
#>          -3.1316333         -12.9822499          -3.7304512 
#>    Distrito Federal      Espírito Santo               Goiás 
#>         -15.7934036         -20.3200917         -16.6808820 
#>            Maranhão         Mato Grosso  Mato Grosso do Sul 
#>          -2.5295265         -15.5986686         -20.4640173 
#>        Minas Gerais                Pará             Paraíba 
#>         -19.9227318          -1.4505600          -7.1215981 
#>              Paraná          Pernambuco               Piauí 
#>         -25.4295963          -8.0584933          -5.0874608 
#>      Rio de Janeiro Rio Grande do Norte   Rio Grande do Sul 
#>         -22.9110137          -5.8053980         -30.0324999 
#>            Rondônia             Roraima      Santa Catarina 
#>          -8.7494525           2.8208478         -27.5973002 
#>           São Paulo             Sergipe           Tocantins 
#>         -23.5506507         -10.9162061         -10.1837852 

brazil_state_latitude("sp")
#> [1] -23.5506507
#> [1] -23.55065 # Expected

brazil_state_latitude("sao paulo")
#> [1] -23.5506507
#> [1] -23.55065 # Expected

brazil_state_latitude(35) # State of São Paulo
#> [1] -23.5506507
#> [1] -23.55065 # Expected

brazil_state_latitude(3550308) # Municipality of São Paulo
#> [1] -23.5506507
#> [1] -23.55065 # Expected

brazil_state_latitude(35503081) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_state_latitude(3912345) # Non-existent state code
#> [1] NA
#> [1] NA # Expected
```
