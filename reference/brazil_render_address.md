# Render Brazilian addresses

`brazil_render_address()` returns a vector with formatted Brazilian
addresses.

**Note:** This function requires the
[`glue`](https://glue.tidyverse.org/) package to be installed.

## Usage

``` r
brazil_render_address(
  street = NA_character_,
  complement = NA_character_,
  neighborhood = NA_character_,
  municipality = NA_character_,
  state = NA_character_,
  postal_code = NA_character_
)
```

## Arguments

- street:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the street names (default: `NA_character`).

- complement:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the complement of the address (default: `NA_character`).

- neighborhood:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the neighborhood names (default: `NA_character`).

- municipality:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the municipalities (default: `NA_character`).

- state:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the states (default: `NA_character`).

- postal_code:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the postal codes (default: `NA_character`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with the
formatted address.

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
[`brazil_state()`](https://danielvartan.github.io/orbis/reference/brazil_state.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
brazil_render_address(
  street = c("Viaduto do Chá, 15", "Alameda Ribeiro da Silva, 919"),
  complement = c("", "Ap. 502"),
  neighborhood = c("Centro", "Campos Elíseos"),
  municipality = c("São Paulo", "São Paulo"),
  state = c("SP", "SP"),
  postal_code = c("01002-020", "01217-010")
)
#> [1] "Viaduto do Chá, 15, Centro, São Paulo-SP, 01002-020, Brasil"                            
#> [2] "Alameda Ribeiro da Silva, 919, Ap. 502, Campos Elíseos, São Paulo-SP, 01217-010, Brasil"
```
