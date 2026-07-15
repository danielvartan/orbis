# Get Brazilian municipalities data

`brazil_municipality()` returns a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with data
about Brazilian municipalities.

This function normalizes names and objects from the
[`read_municipality()`](https://rdrr.io/pkg/geobr/man/read_municipality.html)
function of the [`geobr`](https://rdrr.io/pkg/geobr/man/geobr.html)
package, adding latitude and longitude coordinates for each
municipality.

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
    [`read_municipal_seat()`](https://rdrr.io/pkg/geobr/man/read_municipal_seat.html)
    from the [`geobr`](https://rdrr.io/pkg/geobr/man/geobr.html) package
    to retrieve the coordinates.

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
[`geobr`](https://rdrr.io/pkg/geobr/man/geobr.html) and
[`geocodebr`](https://ipeagit.github.io/geocodebr/reference/geocodebr.html)
R packages.

Both packages are produced by Brazil's Institute for Applied Economic
Research ([IPEA](https://www.ipea.gov.br/)) and access the Brazilian
Institute of Geography and Statistics ([IBGE](https://www.ibge.gov.br/))
data.

## See also

Other Brazil functions:
[`brazil_fu()`](https://danielvartan.github.io/orbis/dev/reference/brazil_fu.md),
[`brazil_municipality_code()`](https://danielvartan.github.io/orbis/dev/reference/brazil_municipality_code.md),
[`brazil_municipality_coords()`](https://danielvartan.github.io/orbis/dev/reference/brazil_municipality_coords.md),
[`brazil_municipality_latitude()`](https://danielvartan.github.io/orbis/dev/reference/brazil_municipality_latitude.md),
[`brazil_municipality_longitude()`](https://danielvartan.github.io/orbis/dev/reference/brazil_municipality_longitude.md),
[`brazil_region()`](https://danielvartan.github.io/orbis/dev/reference/brazil_region.md),
[`brazil_region_code()`](https://danielvartan.github.io/orbis/dev/reference/brazil_region_code.md),
[`brazil_render_address()`](https://danielvartan.github.io/orbis/dev/reference/brazil_render_address.md),
[`brazil_state()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state.md),
[`brazil_state_by_utc()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state_by_utc.md),
[`brazil_state_capital()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state_capital.md),
[`brazil_state_code()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state_code.md),
[`brazil_state_latitude()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state_latitude.md),
[`brazil_state_longitude()`](https://danielvartan.github.io/orbis/dev/reference/brazil_state_longitude.md)

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
#> ! The closest map year to 2026 is 2025. Using year 2025 instead.
#> duckdb is keeping downloaded extensions in a temporary directory:
#> ℹ /tmp/RtmpHTVud2/duckdb/extensions
#> This is removed when the R session ends, so extensions are re-downloaded each session.
#> ℹ To keep them, point `options(duckdb.extension_directory =)` or the `DUCKDB_EXTENSION_DIRECTORY` environment variable at a permanent path.
#> ℹ Using year/date 2025
#> Rows: 5,571
#> Columns: 9
#> $ municipality      <chr> "Alta Floresta D'Oeste", "Ariquemes", "Cabixi", "…
#> $ municipality_code <int> 1100015, 1100023, 1100031, 1100049, 1100056, 1100…
#> $ state             <chr> "Rondônia", "Rondônia", "Rondônia", "Rondônia", "…
#> $ state_code        <int> 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 1…
#> $ federal_unit      <chr> "RO", "RO", "RO", "RO", "RO", "RO", "RO", "RO", "…
#> $ region            <chr> "North", "North", "North", "North", "North", "Nor…
#> $ region_code       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
#> $ latitude          <dbl> -11.933005, -9.911969, -13.494500, -11.435600, -1…
#> $ longitude         <dbl> -62.003686, -63.033808, -60.542900, -61.451200, -…
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém") |> glimpse()
  }
#> ! The closest map year to 2026 is 2025. Using year 2025 instead.
#> Rows: 3
#> Columns: 9
#> $ municipality      <chr> "Belém", "Belém", "Belém"
#> $ municipality_code <int> 1501402, 2501906, 2700805
#> $ state             <chr> "Pará", "Paraíba", "Alagoas"
#> $ state_code        <int> 15, 25, 27
#> $ federal_unit      <chr> "PA", "PB", "AL"
#> $ region            <chr> "North", "Northeast", "Northeast"
#> $ region_code       <int> 1, 2, 2
#> $ latitude          <dbl> -1.455383, -6.696600, -9.570500
#> $ longitude         <dbl> -48.505145, -35.537800, -36.493200
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém", state = "Pará") |> glimpse()
  }
#> ! The closest map year to 2026 is 2025. Using year 2025 instead.
#> Rows: 1
#> Columns: 9
#> $ municipality      <chr> "Belém"
#> $ municipality_code <int> 1501402
#> $ state             <chr> "Pará"
#> $ state_code        <int> 15
#> $ federal_unit      <chr> "PA"
#> $ region            <chr> "North"
#> $ region_code       <int> 1
#> $ latitude          <dbl> -1.455383
#> $ longitude         <dbl> -48.505145
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = c("Belém", "São Paulo")) |> glimpse()
  }
#> ! The closest map year to 2026 is 2025. Using year 2025 instead.
#> Rows: 4
#> Columns: 9
#> $ municipality      <chr> "Belém", "Belém", "Belém", "São Paulo"
#> $ municipality_code <int> 1501402, 2501906, 2700805, 3550308
#> $ state             <chr> "Pará", "Paraíba", "Alagoas", "São Paulo"
#> $ state_code        <int> 15, 25, 27, 35
#> $ federal_unit      <chr> "PA", "PB", "AL", "SP"
#> $ region            <chr> "North", "Northeast", "Northeast", "Southeast"
#> $ region_code       <int> 1, 2, 2, 3
#> $ latitude          <dbl> -1.455383, -6.696600, -9.570500, -23.554753
#> $ longitude         <dbl> -48.505145, -35.537800, -36.493200, -46.579009
# }
```
