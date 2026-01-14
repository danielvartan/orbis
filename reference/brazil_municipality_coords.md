# Get Brazilian municipalities geographic coordinates

`brazil_municipality_coords()` returns a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with the
latitude and longitude coordinates of Brazilian municipalities.

**Note:** This function requires an internet connection to work and the
[`geobr`](https://ipeagit.github.io/geobr/) or
[`geocodebr`](https://ipeagit.github.io/geocodebr/) package to be
installed, depending on the chosen method for retrieving coordinates.

## Usage

``` r
brazil_municipality_coords(
  municipality_code = NULL,
  year = as.numeric(substr(Sys.Date(), 1, 4)),
  coords_method = "geobr",
  force = FALSE
)
```

## Arguments

- municipality_code:

  (optional) An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  vector with the IBGE codes of Brazilian municipalities. Use
  [`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md)
  to obtain codes from municipality names and states. If `NULL` the
  function returns all municipalities (default: `NULL`).

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

- force:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to force the download of the data again (default:
  `FALSE`).

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
the following columns:

- `municipality_code`: The municipality code.

- `latitude`: The municipality latitude.

- `longitude`: The municipality longitude.

## Details

Data from this function is based on data from the Brazilian Institute of
Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) via the
[`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html) and
[`geocodebr`](https://ipeagit.github.io/geocodebr/reference/geocodebr.html)
R packages.

Both packages are produced by Brazil's Institute for Applied Economic
Research ([IPEA](https://www.ipea.gov.br/)) and access the Brazilian
Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/))
data.

## See also

Other Brazil functions:
[`brazil_fu()`](https://danielvartan.github.io/orbis/reference/brazil_fu.md),
[`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.md),
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/reference/brazil_municipality_code.md),
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
    brazil_municipality_coords()
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> # A tibble: 5,565 × 3
#>   municipality_code latitude longitude
#>               <int>    <dbl>     <dbl>
#> 1           1100015   -11.9      -62.0
#> 2           1100023    -9.91     -63.0
#> 3           1100031   -13.5      -60.5
#> 4           1100049   -11.4      -61.4
#> 5           1100056   -13.2      -60.8
#> 6           1100064   -13.1      -60.6
#> # ℹ 5,559 more rows
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_coords(municipality_code = 3550308)
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> # A tibble: 1 × 3
#>   municipality_code latitude longitude
#>               <int>    <dbl>     <dbl>
#> 1           3550308    -23.6     -46.6
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_coords(municipality_code = 3550)
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> # A tibble: 10 × 3
#>   municipality_code latitude longitude
#>               <int>    <dbl>     <dbl>
#> 1           3550001    -23.2     -45.3
#> 2           3550100    -22.7     -48.6
#> 3           3550209    -23.9     -48.0
#> 4           3550308    -23.6     -46.6
#> 5           3550407    -22.5     -47.9
#> 6           3550506    -22.8     -49.7
#> # ℹ 4 more rows
# }

# \dontrun{
  if (has_internet()) {
    brazil_municipality_coords(municipality_code = c(3550308, 3304557))
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> # A tibble: 2 × 3
#>   municipality_code latitude longitude
#>               <int>    <dbl>     <dbl>
#> 1           3304557    -22.9     -43.2
#> 2           3550308    -23.6     -46.6
# }
```
