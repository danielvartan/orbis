# Get Brazilian municipalities latitude

`brazil_municipality_latitude()` returns the latitude of Brazilian
municipalities.

**Note:** This function requires an internet connection to work and the
[`geobr`](https://ipeagit.github.io/geobr/) or
[`geocodebr`](https://ipeagit.github.io/geocodebr/) package to be
installed, depending on the chosen method for retrieving coordinates.

## Usage

``` r
brazil_municipality_latitude(
  municipality_code,
  year = as.numeric(substr(Sys.Date(), 1, 4)),
  coords_method = "geobr",
  names = TRUE,
  ...
)
```

## Arguments

- municipality_code:

  An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  vector with the IBGE codes of Brazilian municipalities. Use
  [`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md)
  to obtain codes from municipality names and states.

- year:

  (optional) An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkInt.html)
  number indicating the year of the data regarding the municipalities
  (default: `Sys.Date() |> substr(1, 4) |> as.numeric()`).

- coords_method:

  (optional) A string indicating the method to retrieve the latitude and
  longitude coordinates of the municipalities (default: `"geobr"`).
  Options are:

  - `"geobr"`: Uses
    [`read_municipal_seat()`](https://ipeagit.github.io/geobr/reference/read_municipal_seat.html)
    from the
    [`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html)
    package to retrieve the coordinates.

  - `"geocodebr"`: Uses the
    [`geocode()`](https://ipeagit.github.io/geocodebr/reference/geocode.html)
    from the
    [`geocodebr`](https://ipeagit.github.io/geocodebr/reference/geocodebr.html)
    package to retrieve the coordinates.

- names:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to return the names of the municipalities as names
  of the vector (default: `TRUE`).

- ...:

  (optional) Additional arguments passed to
  [`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md).

## Value

A [`numeric`](https://rdrr.io/r/base/numeric.html) vector with the
latitude of the Brazilian municipalities.

## Details

Data from this function is based on data from the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) via the
[`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html) R
package.

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
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md),
[`brazil_municipality_coords()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_coords.md),
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
    brazil_municipality_latitude(3550308)
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> São Paulo-SP 
#>  -23.5673865 
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_latitude(c(3550308, 3500204))
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> São Paulo-SP    Adolfo-SP 
#> -23.56738650 -21.23272978 
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_latitude(c(3550308, 1000, 3500204))
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> São Paulo-SP         <NA>    Adolfo-SP 
#> -23.56738650           NA -21.23272978 
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_latitude(c(3550308, NA, 3500204))
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> São Paulo-SP         <NA>    Adolfo-SP 
#> -23.56738650           NA -21.23272978 
# }
```
