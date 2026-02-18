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

# \dontrun{
  if (is_online()) {
    brazil_municipality_code(municipality = "Belém")
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
    brazil_municipality_code(municipality = "Belém", names = FALSE)
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
    brazil_municipality_code(municipality = "Belém", state = "Pará")
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
    brazil_municipality_code(c("Rio de Janeiro", "São Paulo"))
  }
#> ! The closest map year to 2026 is 2024. Using year 2024 instead.
#> Using year/date 2024
#> Problem connecting to data server. Please try again in a few minutes.
#> Error in dplyr::mutate(dplyr::rename(dplyr::select(dplyr::as_tibble(read_municipality(year = closest_geobr_year(year,     type = "municipality", verbose = FALSE), showProgress = FALSE,     cache = !force)), name_muni, code_muni, code_state, abbrev_state),     municipality = name_muni, municipality_code = code_muni,     state_code = code_state, federal_unit = abbrev_state), municipality = to_title_case_pt(municipality,     articles = TRUE, conjunctions = FALSE, oblique_pronouns = FALSE,     prepositions = FALSE, custom_rules = c(`(.)\\bE( )\\b` = "\\1e\\2",         `(.)\\bÀ(s)?\\b` = "\\1à\\2", `(.)\\bD(((a|o)(s)?)|(e))\\b` = "\\1d\\2",         `(.)\\bE(m)\\b` = "\\1e\\2", `(.)\\bN((a|o)(s)?)\\b` = "\\1n\\2",         `(.)\\bD(el)\\b` = "\\1d\\2")), municipality_code = as.integer(municipality_code),     state = brazil_state(federal_unit), state_code = as.integer(state_code),     region = brazil_region(federal_unit), region_code = brazil_region_code(region)): ℹ In argument: `municipality = to_title_case_pt(...)`.
#> Caused by error:
#> ! `municipality` must be size 0 or 1, not 2.
# }
```
