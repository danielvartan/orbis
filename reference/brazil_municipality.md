# Get Brazilian municipalities data

`brazil_municipality()` returns a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with data
about Brazilian municipalities.

This function normalizes names and objects from the
[`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html)
function of the
[`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html) package,
adding latitude and longitude coordinates for each municipality.

**Note:** This function requires an internet connection to work and the
[`geobr`](https://ipeagit.github.io/geobr/) or
[`geocodebr`](https://ipeagit.github.io/geocodebr/) package to be
installed, depending on the chosen method for retrieving coordinates.

## Usage

``` r
brazil_municipality(
  municipality = NULL,
  state = NULL,
  year = as.numeric(substr(Sys.Date(), 1, 4)),
  coords_method = "geobr",
  force = FALSE
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

- `municipality`: The municipality name.

- `municipality_code`: The municipality code.

- `state`: The state name.

- `state_code`: The state code.

- `federal_unit`: The state abbreviation.

- `region`: The region name.

- `region_code`: The region code.

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
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/reference/brazil_state_longitude.md)

## Examples

``` r
library(httr2)
#> 
#> Attaching package: ‘httr2’
#> The following object is masked from ‘package:xml2’:
#> 
#>     url_parse
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union

# \dontrun{
  if (is_online()) {
    brazil_municipality() |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Using year/date 2024
#> Rows: 5,571
#> Columns: 9
#> $ municipality      <chr> "Alta Floresta D'Oeste", "Ariquemes", "Cabixi", "…
#> $ municipality_code <int> 1100015, 1100023, 1100031, 1100049, 1100056, 1100…
#> $ state             <chr> "Rondônia", "Rondônia", "Rondônia", "Rondônia", "…
#> $ state_code        <int> 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 1…
#> $ federal_unit      <chr> "RO", "RO", "RO", "RO", "RO", "RO", "RO", "RO", "…
#> $ region            <chr> "North", "North", "North", "North", "North", "Nor…
#> $ region_code       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
#> $ latitude          <dbl> -11.935540305, -9.908462867, -13.499763460, -11.4…
#> $ longitude         <dbl> -61.99982390, -63.03326928, -60.54431358, -61.442…
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém") |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Rows: 3
#> Columns: 9
#> $ municipality      <chr> "Belém", "Belém", "Belém"
#> $ municipality_code <int> 1501402, 2501906, 2700805
#> $ state             <chr> "Pará", "Paraíba", "Alagoas"
#> $ state_code        <int> 15, 25, 27
#> $ federal_unit      <chr> "PA", "PB", "AL"
#> $ region            <chr> "North", "Northeast", "Northeast"
#> $ region_code       <int> 1, 2, 2
#> $ latitude          <dbl> -1.459845000, -6.694042610, -9.568648231
#> $ longitude         <dbl> -48.48782569, -35.53627408, -36.49449799
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém", state = "Pará") |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Rows: 1
#> Columns: 9
#> $ municipality      <chr> "Belém"
#> $ municipality_code <int> 1501402
#> $ state             <chr> "Pará"
#> $ state_code        <int> 15
#> $ federal_unit      <chr> "PA"
#> $ region            <chr> "North"
#> $ region_code       <int> 1
#> $ latitude          <dbl> -1.459845
#> $ longitude         <dbl> -48.48782569
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = c("Belém", "São Paulo")) |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Rows: 4
#> Columns: 9
#> $ municipality      <chr> "Belém", "Belém", "Belém", "São Paulo"
#> $ municipality_code <int> 1501402, 2501906, 2700805, 3550308
#> $ state             <chr> "Pará", "Paraíba", "Alagoas", "São Paulo"
#> $ state_code        <int> 15, 25, 27, 35
#> $ federal_unit      <chr> "PA", "PB", "AL", "SP"
#> $ region            <chr> "North", "Northeast", "Northeast", "Southeast"
#> $ region_code       <int> 1, 2, 2, 3
#> $ latitude          <dbl> -1.459845000, -6.694042610, -9.568648231, -23.567…
#> $ longitude         <dbl> -48.48782569, -35.53627408, -36.49449799, -46.570…
# }
```
