# Get Brazilian state longitude

`brazil_state_longitude()` returns a vector with the longitude of
Brazilian state capitals.

## Usage

``` r
brazil_state_longitude(x = NULL)
```

## Arguments

- x:

  (optional) An [`atomic`](https://rdrr.io/r/base/is.recursive.html)
  vector containing the names of Brazilian states or federal units.
  Municipality and state codes are also supported. If `NULL`, returns a
  vector with all state longitudes (default: `NULL`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
longitude of Brazilian state capitals.

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
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md)

## Examples

``` r
brazil_state_longitude()
#>                Acre             Alagoas               Amapá 
#>         -67.8220778         -35.7339264         -51.0569588 
#>            Amazonas               Bahia               Ceará 
#>         -59.9825041         -38.4812772         -38.5217989 
#>    Distrito Federal      Espírito Santo               Goiás 
#>         -47.8823172         -40.3376682         -49.2532691 
#>            Maranhão         Mato Grosso  Mato Grosso do Sul 
#>         -44.2963942         -56.0991301         -54.6162947 
#>        Minas Gerais                Pará             Paraíba 
#>         -43.9450948         -48.4682453         -34.8820280 
#>              Paraná          Pernambuco               Piauí 
#>         -49.2712724         -34.8848193         -42.8049571 
#>      Rio de Janeiro Rio Grande do Norte   Rio Grande do Sul 
#>         -43.2093727         -35.2080905         -51.2303767 
#>            Rondônia             Roraima      Santa Catarina 
#>         -63.8735438         -60.6719582         -48.5496098 
#>           São Paulo             Sergipe           Tocantins 
#>         -46.6333824         -37.0774655         -48.3336423 

brazil_state_longitude("sp")
#> [1] -46.6333824
#> [1] -46.63338 # Expected

brazil_state_longitude("sao paulo")
#> [1] -46.6333824
#> [1] -46.63338 # Expected

brazil_state_longitude(35) # State of São Paulo
#> [1] -46.6333824
#> [1] -46.63338 # Expected

brazil_state_longitude(3550308) # Municipality of São Paulo
#> [1] -46.6333824
#> [1] -46.63338 # Expected

brazil_state_longitude(35503081) # >7 digits
#> [1] NA
#> [1] NA # Expected

brazil_state_longitude(3912345) # Non-existent state code
#> [1] NA
#> [1] NA # Expected
```
