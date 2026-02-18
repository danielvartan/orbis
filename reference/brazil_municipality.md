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
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::select(dplyr::as_tibble(read_municipality(year = closest_geobr_year(year,     type = "municipality", verbose = FALSE), showProgress = FALSE,     cache = !force)), name_muni, code_muni, code_state, abbrev_state),     municipality = name_muni, municipality_code = code_muni,     state_code = code_state, federal_unit = abbrev_state), municipality = to_title_case_pt(municipality,     articles = TRUE, conjunctions = FALSE, oblique_pronouns = FALSE,     prepositions = FALSE, custom_rules = c(`(.)\\bE( )\\b` = "\\1e\\2",         `(.)\\bÀ(s)?\\b` = "\\1à\\2", `(.)\\bD(((a|o)(s)?)|(e))\\b` = "\\1d\\2",         `(.)\\bE(m)\\b` = "\\1e\\2", `(.)\\bN((a|o)(s)?)\\b` = "\\1n\\2",         `(.)\\bD(el)\\b` = "\\1d\\2")), municipality_code = as.integer(municipality_code),     state = brazil_state(federal_unit), state_code = as.integer(state_code),     region = brazil_region(federal_unit), region_code = brazil_region_code(region)): ℹ In argument: `municipality = to_title_case_pt(...)`.
#> Caused by error in `to_title_case_pt()`:
#> ! Assertion on 'x' failed: Must be of type 'character', not 'NULL'.
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém") |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Using year/date 2024
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::select(dplyr::as_tibble(read_municipality(year = closest_geobr_year(year,     type = "municipality", verbose = FALSE), showProgress = FALSE,     cache = !force)), name_muni, code_muni, code_state, abbrev_state),     municipality = name_muni, municipality_code = code_muni,     state_code = code_state, federal_unit = abbrev_state), municipality = to_title_case_pt(municipality,     articles = TRUE, conjunctions = FALSE, oblique_pronouns = FALSE,     prepositions = FALSE, custom_rules = c(`(.)\\bE( )\\b` = "\\1e\\2",         `(.)\\bÀ(s)?\\b` = "\\1à\\2", `(.)\\bD(((a|o)(s)?)|(e))\\b` = "\\1d\\2",         `(.)\\bE(m)\\b` = "\\1e\\2", `(.)\\bN((a|o)(s)?)\\b` = "\\1n\\2",         `(.)\\bD(el)\\b` = "\\1d\\2")), municipality_code = as.integer(municipality_code),     state = brazil_state(federal_unit), state_code = as.integer(state_code),     region = brazil_region(federal_unit), region_code = brazil_region_code(region)): ℹ In argument: `state = brazil_state(federal_unit)`.
#> Caused by error:
#> ! `state` must be size 0 or 1, not 27.
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = "Belém", state = "Pará") |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Using year/date 2024
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::select(dplyr::as_tibble(read_municipality(year = closest_geobr_year(year,     type = "municipality", verbose = FALSE), showProgress = FALSE,     cache = !force)), name_muni, code_muni, code_state, abbrev_state),     municipality = name_muni, municipality_code = code_muni,     state_code = code_state, federal_unit = abbrev_state), municipality = to_title_case_pt(municipality,     articles = TRUE, conjunctions = FALSE, oblique_pronouns = FALSE,     prepositions = FALSE, custom_rules = c(`(.)\\bE( )\\b` = "\\1e\\2",         `(.)\\bÀ(s)?\\b` = "\\1à\\2", `(.)\\bD(((a|o)(s)?)|(e))\\b` = "\\1d\\2",         `(.)\\bE(m)\\b` = "\\1e\\2", `(.)\\bN((a|o)(s)?)\\b` = "\\1n\\2",         `(.)\\bD(el)\\b` = "\\1d\\2")), municipality_code = as.integer(municipality_code),     state = brazil_state(federal_unit), state_code = as.integer(state_code),     region = brazil_region(federal_unit), region_code = brazil_region_code(region)): ℹ In argument: `state = brazil_state(federal_unit)`.
#> Caused by error:
#> ! `state` must be size 0 or 1, not 27.
# }

# \dontrun{
  if (is_online()) {
    brazil_municipality(municipality = c("Belém", "São Paulo")) |> glimpse()
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Using year/date 2024
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::select(dplyr::as_tibble(read_municipality(year = closest_geobr_year(year,     type = "municipality", verbose = FALSE), showProgress = FALSE,     cache = !force)), name_muni, code_muni, code_state, abbrev_state),     municipality = name_muni, municipality_code = code_muni,     state_code = code_state, federal_unit = abbrev_state), municipality = to_title_case_pt(municipality,     articles = TRUE, conjunctions = FALSE, oblique_pronouns = FALSE,     prepositions = FALSE, custom_rules = c(`(.)\\bE( )\\b` = "\\1e\\2",         `(.)\\bÀ(s)?\\b` = "\\1à\\2", `(.)\\bD(((a|o)(s)?)|(e))\\b` = "\\1d\\2",         `(.)\\bE(m)\\b` = "\\1e\\2", `(.)\\bN((a|o)(s)?)\\b` = "\\1n\\2",         `(.)\\bD(el)\\b` = "\\1d\\2")), municipality_code = as.integer(municipality_code),     state = brazil_state(federal_unit), state_code = as.integer(state_code),     region = brazil_region(federal_unit), region_code = brazil_region_code(region)): ℹ In argument: `municipality = to_title_case_pt(...)`.
#> Caused by error:
#> ! `municipality` must be size 0 or 1, not 2.
# }
```
