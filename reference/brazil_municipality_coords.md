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

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string indicating the method to retrieve the latitude and longitude
  coordinates of the municipalities (default: `"geobr"`). Options are:

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
library(httr2)

# \dontrun{
  if (is_online()) {
    brazil_municipality_coords()
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::as_tibble(geobr::read_municipal_seat(year = closest_geobr_year(year,     type = "municipal_seat"), showProgress = FALSE, cache = !force)),     municipality_code = code_muni), municipality_code = as.integer(municipality_code),     geom = as.list(dplyr::as_tibble(terra::crds(terra::vect(geom))) %>%         split(., seq_len(nrow(.)))), latitude = purrr::map_dbl(geom,         function(x) x$y), longitude = purrr::map_dbl(geom, function(x) x$x)): ℹ In argument: `geom = as.list(...)`.
#> Caused by error in `h()`:
#> ! error in evaluating the argument 'x' in selecting a method for function 'crds': unable to find an inherited method for function ‘vect’ for signature ‘x = "NULL"’
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality_coords(municipality_code = 3550308)
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::as_tibble(geobr::read_municipal_seat(year = closest_geobr_year(year,     type = "municipal_seat"), showProgress = FALSE, cache = !force)),     municipality_code = code_muni), municipality_code = as.integer(municipality_code),     geom = as.list(dplyr::as_tibble(terra::crds(terra::vect(geom))) %>%         split(., seq_len(nrow(.)))), latitude = purrr::map_dbl(geom,         function(x) x$y), longitude = purrr::map_dbl(geom, function(x) x$x)): ℹ In argument: `geom = as.list(...)`.
#> Caused by error in `h()`:
#> ! error in evaluating the argument 'x' in selecting a method for function 'crds': unable to find an inherited method for function ‘vect’ for signature ‘x = "NULL"’
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality_coords(municipality_code = 3550)
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::as_tibble(geobr::read_municipal_seat(year = closest_geobr_year(year,     type = "municipal_seat"), showProgress = FALSE, cache = !force)),     municipality_code = code_muni), municipality_code = as.integer(municipality_code),     geom = as.list(dplyr::as_tibble(terra::crds(terra::vect(geom))) %>%         split(., seq_len(nrow(.)))), latitude = purrr::map_dbl(geom,         function(x) x$y), longitude = purrr::map_dbl(geom, function(x) x$x)): ℹ In argument: `geom = as.list(...)`.
#> Caused by error in `h()`:
#> ! error in evaluating the argument 'x' in selecting a method for function 'crds': unable to find an inherited method for function ‘vect’ for signature ‘x = "NULL"’
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality_coords(municipality_code = c(3550308, 3304557))
  }
#> ! The closest map year to 2026 is 2010. Using year 2010 instead.
#> Using year/date 2010
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::as_tibble(geobr::read_municipal_seat(year = closest_geobr_year(year,     type = "municipal_seat"), showProgress = FALSE, cache = !force)),     municipality_code = code_muni), municipality_code = as.integer(municipality_code),     geom = as.list(dplyr::as_tibble(terra::crds(terra::vect(geom))) %>%         split(., seq_len(nrow(.)))), latitude = purrr::map_dbl(geom,         function(x) x$y), longitude = purrr::map_dbl(geom, function(x) x$x)): ℹ In argument: `municipality_code = as.integer(municipality_code)`.
#> Caused by error:
#> ! `municipality_code` must be size 0 or 1, not 2.
# }
```
