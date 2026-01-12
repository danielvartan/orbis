# Get and aggregate data by year from SIDRA API

`sidra_download_by_year()` retrieves data from the Brazilian Institute
of Geography and Statistics ([IBGE](https://www.ibge.gov.br/)) Automatic
Retrieval System ([SIDRA](https://sidra.ibge.gov.br/)) API for a
specified range of years.

This function addresses the SIDRA API's limitations on the volume of
data that can be downloaded in a single request. It downloads data for
each year individually and then combines the results into a single data
frame.

**Note:** This function requires an active internet connection and the
[`sidrar`](https://CRAN.R-project.org/package=sidrar) package to be
installed.

## Usage

``` r
sidra_download_by_year(years, api_start, api_end)
```

## Arguments

- years:

  An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  vector with the years to download.

- api_start:

  A string specifying the initial part of the SIDRA API URL, up to (but
  not including) the year segment. See the Details section for guidance.

- api_end:

  A string specifying the final part of the SIDRA API URL, immediately
  following the year segment. See the Details section for guidance.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html)
containing the combined data for all requested years, as retrieved from
the SIDRA API.

## Details

To construct the API call, follow these steps:

1.  Visit the SIDRA website.

2.  Locate the desired table containing your data.

3.  Configure the parameters for data retrieval (e.g., variable, sex,
    years).

4.  Click the share button (link symbol) at the end of the page.

5.  If a checkbox labeled *Usar períodos relativos, quando possível.*
    appears, uncheck it, reload the page, and click the share button
    again.

6.  Copy the portion of the *Parâmetros para a API* URL that starts with
    `/t` (e.g., `/t/6407...`).

You need to provide the function with separate parts of the API URL. For
example:

    |-------- Start ------|--- Years ----|----- End -----|
    /t/6407/n6/all/v/606/p/2021,2022,2023/c2/6794/c58/1140

If you have difficulty identifying the correct segments, try adjusting
the table settings, selecting different years, and examining how the URL
changes.

## Examples

``` r
library(curl)
library(dplyr)

# \dontrun{
  if (has_internet()) {
    sidra_download_by_year(
      years = 2010:2011,
      api_start = "/t/1612/n6/all/v/109/p/",
      api_end = "/c81/2692"
    ) |>
      glimpse()
  }
#> ⠙ Downloading data from 2010
#> All others arguments are desconsidered when 'api' is informed
#> ✔ Downloading data from 2010 [20.7s]
#> 
#> ⠙ Downloading data from 2011
#> All others arguments are desconsidered when 'api' is informed
#> ✔ Downloading data from 2011 [20.6s]
#> 
#> Rows: 11,126
#> Columns: 13
#> $ `Nível Territorial (Código)`                <chr> "6", "6", "6", "6", "6"…
#> $ `Nível Territorial`                         <chr> "Município", "Município…
#> $ `Unidade de Medida (Código)`                <chr> "1006", "1006", "1006",…
#> $ `Unidade de Medida`                         <chr> "Hectares", "Hectares",…
#> $ Valor                                       <dbl> 750, 5706, 700, 1230, 3…
#> $ `Município (Código)`                        <chr> "1100015", "1100023", "…
#> $ Município                                   <chr> "Alta Floresta D'Oeste …
#> $ `Variável (Código)`                         <chr> "109", "109", "109", "1…
#> $ Variável                                    <chr> "Área plantada", "Área …
#> $ `Ano (Código)`                              <chr> "2010", "2010", "2010",…
#> $ Ano                                         <chr> "2010", "2010", "2010",…
#> $ `Produto das lavouras temporárias (Código)` <chr> "2692", "2692", "2692",…
#> $ `Produto das lavouras temporárias`          <chr> "Arroz (em casca)", "Ar…
# }
```
