# Get Brazilian municipalities codes

`brazil_municipality_code()` returns a vector with codes of the
Brazilian Institute of Geography and Statistics
([IBGE](https://www.ibge.gov.br/)) for Brazilian municipalities.

**Note:** This function requires an active internet connection and the
[`geobr`](https://ipeagit.github.io/geobr/) package to be installed.

## Usage

``` r
brazil_municipality_code(
  municipality,
  state = NULL,
  year = as.numeric(substr(Sys.Date(), 1, 4)),
  names = TRUE,
  ...
)
```

## Arguments

- municipality:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the municipalities. If `NULL` the function
  returns all municipalities (default: `NULL`).

- state:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the states (default: `NULL`).

- year:

  (optional) An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkInt.html)
  number indicating the year of the data regarding the municipalities
  (default: `Sys.Date() |> substr(1, 4) |> as.numeric()`).

- names:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to return the names of the municipalities as names
  of the vector (default: `TRUE`).

- ...:

  (optional) Additional arguments passed to
  [`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md).

## Value

An [`integer`](https://rdrr.io/r/base/integer.html) vector with the IBGE
codes of Brazilian municipalities.

## Details

The data from this function is based on data from the Brazilian
Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/))
via the [`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html)
R package.

The [`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html)
package is produced by Brazil's Institute for Applied Economic Research
([IPEA](https://www.ipea.gov.br/)) and access the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) data. You
can see a list of all
[`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html) datasets
by running
[`geobr::list_geobr()`](https://ipeagit.github.io/geobr/reference/list_geobr.html).

## See also

Other Brazil functions:
[`brazil_fu()`](https://danielvartan.github.io/orbis/reference/brazil_fu.md),
[`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md),
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
library(curl)

# \dontrun{
  if (has_internet()) {
    brazil_municipality_code(municipality = "Belém")
  }
#> Belém-PA Belém-PB Belém-AL 
#>  1501402  2501906  2700805 
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_code(municipality = "Belém", names = FALSE)
  }
#> [1] 1501402 2501906 2700805
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_code(municipality = "Belém", state = "Pará")
  }
#> Belém-PA 
#>  1501402 
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_code(c("Rio de Janeiro", "São Paulo"))
  }
#> Rio de Janeiro-RJ      São Paulo-SP 
#>           3304557           3550308 
# }
```
