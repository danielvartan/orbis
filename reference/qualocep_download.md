# Get Qual o CEP data

`qualocep_download()` retrieves a validated dataset from [Qual o
CEP](https://www.qualocep.com) hosted on the package's [OSF
repository](https://osf.io/9ky4g/).

[Qual o CEP](https://www.qualocep.com) is a database of Brazilian
addresses and postal codes, geocoded using the Google Geocoding API.
Users should verify the year of the data, as some values may be
outdated.

When possible, consider using the
[`geocodebr`](https://ipeagit.github.io/geocodebr/) package, which
provides more up-to-date geocoded information.

**Note:** This function requires an internet connection to work and the
[`osfr`](https://docs.ropensci.org/osfr/) package to be installed.

## Usage

``` r
qualocep_download(file = NULL, pattern = "2024-11-12.rds", force = FALSE)
```

## Arguments

- file:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string with the path to a Qual o CEP dataset file. If `NULL`, the
  dataset will be downloaded from the package's [OSF
  repository](https://osf.io/9ky4g/). (default: `NULL`).

- pattern:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string with the pattern of the Qual o CEP dataset file to download.
  Click [here](https://osf.io/k5hyq/files/osfstorage) to see the
  available patterns (default: `"2024-11-12.rds"`).

- force:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag to
  force the download of the Qual o CEP dataset file. If `TRUE`, the
  dataset will be downloaded even if it already exists in the temporary
  directory (default: `FALSE`).

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html)
containing the [Qual o CEP](https://www.qualocep.com) with the following
columns:

- `postal_code`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the postal codes.

- `street_type`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the type of streets.

- `street_name`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the streets.

- `street`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the full name of the streets.

- `complement`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the complement of the addresses.

- `place`: A [`character`](https://rdrr.io/r/base/character.html) vector
  with the place of the addresses.

- `neighborhood`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the neighborhoods

- `municipality_code`: An
  [`integer`](https://rdrr.io/r/base/integer.html) vector with the codes
  of the Brazilian Institute of Geography and Statistics
  ([IBGE](https://www.ibge.gov.br/)) for Brazilian municipalities.

- `municipality`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the name of the municipalities.

- `state_code`: An [`integer`](https://rdrr.io/r/base/integer.html)
  vector with the codes of the Brazilian Institute of Geography and
  Statistics ([IBGE](https://www.ibge.gov.br/)) for the Brazilian state.

- `state`: A [`character`](https://rdrr.io/r/base/character.html) vector
  with the name of the states.

- `federal_unit`: A [`character`](https://rdrr.io/r/base/character.html)
  vector with the abbreviations of the Brazilian federal unit.

- `latitude`: A [`numeric`](https://rdrr.io/r/base/numeric.html) vector
  with the latitude values of the postal codes (retrieved using Google
  Geocoding API).

- `longitude`: A [`numeric`](https://rdrr.io/r/base/numeric.html) vector
  with the longitude values of the postal codes (retrieved using Google
  Geocoding API).

## Examples

``` r
library(curl)
library(dplyr)

# \dontrun{
  if (has_internet()) {
    qualocep_download() |> glimpse()
  }
#> ℹ Downloading Qual o CEP data from OSF
#> ✔ Downloading Qual o CEP data from OSF [14.2s]
#> 
#> Rows: 1,396,087
#> Columns: 14
#> $ postal_code       <chr> "69945000", "69945959", "69945970", "69935000", "…
#> $ street_type       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ street_name       <chr> NA, "Avenida Paraná, 296 Clique e Retire Correios…
#> $ street            <chr> "NA NA", "NA Avenida Paraná, 296 Clique e Retire …
#> $ complement        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ place             <chr> NA, "AC A C Retire", "AC Acrelândia", NA, "AC A B…
#> $ neighborhood      <chr> NA, "Centro", "Centro", NA, "Centro", "Centro", N…
#> $ municipality_code <int> 1200013, 1200013, 1200013, 1200054, 1200054, 1200…
#> $ municipality      <chr> "Acrelândia", "Acrelândia", "Acrelândia", "Assis …
#> $ state_code        <int> 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 1…
#> $ state             <chr> "Acre", "Acre", "Acre", "Acre", "Acre", "Acre", "…
#> $ federal_unit      <chr> "AC", "AC", "AC", "AC", "AC", "AC", "AC", "AC", "…
#> $ latitude          <dbl> -10.0764608, -10.0766582, -10.0764270, -10.931854…
#> $ longitude         <dbl> -67.0586512, -67.0557312, -67.0555998, -69.563862…
# }
```
