# Prepare data to fill a map

`map_fill_data()` prepares data to be used as fill in a map plot.

## Usage

``` r
map_fill_data(
  data,
  col_fill = NULL,
  col_ref,
  name_col_value = "value",
  name_col_ref = col_ref
)
```

## Arguments

- data:

  A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
  the data to be used as fill.

- col_fill:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string with the column name to be used as fill. If `NULL`, the
  function will count the number of occurrences of each value in
  `col_ref` (default: `NULL`).

- col_ref:

  A [`character`](https://rdrr.io/r/base/character.html) string with the
  column name to be used as reference.

- name_col_value:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string with the name of the column to be used as value (default:
  `"value"`).

- name_col_ref:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string with the name of the column to be used as reference (default:
  `col_ref`).

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
two columns:

- `name_col_ref`: with unique values from `col_ref`.

- `name_col_value`: with the values from `col_fill` or the count of
  occurrences of each value in `col_ref` (if `col_fill` is `NULL`).

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
# Set the Environment -----

library(curl)
library(dplyr)
library(geodata)
#> Loading required package: terra
#> terra 1.8.86
#> 
#> Attaching package: ‘terra’
#> The following objects are masked from ‘package:magrittr’:
#> 
#>     extract, inset
#> The following object is masked from ‘package:knitr’:
#> 
#>     spin
library(ggplot2)
library(terra)
library(tidyterra)
#> 
#> Attaching package: ‘tidyterra’
#> The following object is masked from ‘package:stats’:
#> 
#>     filter

plot_vector_shape <- function(vector) {
  plot <-
    vector |>
    ggplot() +
    geom_spatvector(fill = "white", color = "#3243A6")

  print(plot)
}

plot_vector_data <- function(data, vector) {
  plot <-
    data |>
    ggplot() +
    geom_spatvector(aes(fill = value), color = "white") +
    scale_fill_continuous(
        palette = c("#072359", "#3243A6", "#9483AF"),
        na.value = "white"
    ) +
    labs(fill = NULL)

  print(plot)
}

# Define the Map -----

# \dontrun{
  if (has_internet()) {
    brazil_states_vector <- gadm("BRA", level = 1, path = tempdir())
  }
# }

# Visualize the Map -----

# \dontrun{
  if (has_internet()) {
    brazil_states_vector |> plot_vector_shape()
  }

# }

# Define the Data -----

# \dontrun{
  if (has_internet()) {
    data <- tibble(
      state = sample(
        brazil_states_vector$NAME_1, size = 1000, replace = TRUE
      ),
      value = sample(1:1000, size = 1000, replace = TRUE)
    )

    data
  }
#> # A tibble: 1,000 × 2
#>   state               value
#>   <chr>               <int>
#> 1 Bahia                  45
#> 2 Rio Grande do Norte   224
#> 3 Sergipe                 8
#> 4 Paraná                482
#> 5 Piauí                 925
#> 6 Pernambuco            793
#> # ℹ 994 more rows
# }

# Create the Map Fill Data -----

# \dontrun{
  if (has_internet()) {
    data <- data |> map_fill_data(col_fill = "value", col_ref = "state")

    data
  }
#> ! There are duplicated values in state. value will be aggregated using the mean.
#> # A tibble: 27 × 2
#>   state               value
#>   <chr>               <dbl>
#> 1 Bahia                429 
#> 2 Rio Grande do Norte  528 
#> 3 Sergipe              537.
#> 4 Paraná               465.
#> 5 Piauí                583.
#> 6 Pernambuco           555.
#> # ℹ 21 more rows
# }

# Visualize the Map Fill Data -----

# \dontrun{
  if (has_internet()) {
    brazil_states_vector |>
      left_join(data, by = c("NAME_1" = "state")) |>
      plot_vector_data()
  }

# }
```
