# orbis <a href = "https://danielvartan.github.io/brandr/"><img src = "man/figures/logo.png" align="right" width="120" /></a>

<!-- quarto render -->

<!-- badges: start -->
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![](https://www.r-pkg.org/badges/version/orbis)](https://cran.r-project.org/package=orbis)
[![R build
status](https://github.com/danielvartan/orbis/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danielvartan/orbis/actions)
[![](https://codecov.io/gh/danielvartan/orbis/branch/main/graph/badge.svg)](https://app.codecov.io/gh/danielvartan/orbis)
[![License:
GPLv3](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![](https://img.shields.io/badge/Contributor%20Covenant-3.0-4baaaa.svg)](https://www.contributor-covenant.org/version/3/0/code_of_conduct/)
<!-- badges: end -->

## Overview

`orbis` is an [R](https://www.r-project.org/) package that provides a
comprehensive suite of tools for streamlining spatial data analysis
workflows. It follows the [tidyverse
principles](https://tidyverse.tidyverse.org/articles/manifesto.html) and
integrates naturally with the [tidyverse
ecosystem](https://www.tidyverse.org/).

> If you find this project useful, please consider giving it a star!  
> [![GitHub repo
> stars](https://img.shields.io/github/stars/danielvartan/orbis)](https://github.com/danielvartan/orbis/)

## Installation

You can install `orbis` using the
[`remotes`](https://github.com/r-lib/remotes) package:

``` r
# install.packages("remotes")
remotes::install_github("danielvartan/orbis", dependencies = TRUE)
```

## Usage

`orbis` is equipped with several functions to help with your analysis,
such as:

- [`shift_and_rotate()`](https://danielvartan.github.io/orbis/reference/shift_and_rotate.html):
  Shift and rotate raster or vector data.
- [`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.html):
  Remove unique outliers from raster files.
- [`map_fill_data()`](https://danielvartan.github.io/orbis/reference/map_fill_data.html):
  Prepare data to fill a map.
- [`filter_points_on_land()`](https://danielvartan.github.io/orbis/reference/filter_points_on_land.html):
  Filter latitude/longitude points that intersects with a given
  [`sf`](https://r-spatial.github.io/sf/) geometry.
- [`brazil_municipality()`](https://danielvartan.github.io/orbis/reference/brazil_municipality.html):
  Get Brazilian municipalities data.
- [`sidra_download_by_year()`](https://danielvartan.github.io/orbis/reference/sidra_download_by_year.html):
  Get and aggregate data by year from
  [SIDRA](https://sidra.ibge.gov.br/) API (to avoid overloading).
- [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.html):
  Convert [WorldClim](https://worldclim.org/)
  [GeoTIFF](https://www.ogc.org/standards/geotiff/) files to [Esri
  ASCII](https://desktop.arcgis.com/en/arcmap/latest/manage-data/raster-and-images/esri-ascii-raster-format.htm)
  raster format.

Here are some examples of how to use a few of these functions.

### `shift_and_rotate()`

[`shift_and_rotate()`](https://danielvartan.github.io/orbis/reference/shift_and_rotate.html)
was developed to simplify shifting and rotating spatial data, especially
for rasters and vectors that cross the dateline (e.g., Russia).

``` r
library(dplyr)
library(geodata)
library(ggplot2)
library(orbis)
library(terra)
library(tidyterra)
```

``` r
world_shape <- world(path = tempdir())
```

``` r
world_shape |>
  ggplot() +
  geom_spatvector(fill = "#072359", color = "white")
```

![](man/figures/readme-shift-and-rotate-1-1.png)

``` r
russia_shape <- gadm(country = "rus", level = 0, path = tempdir())
```

``` r
russia_shape |>
  ggplot() +
  geom_spatvector(fill = "#3243A6", color = "white")
```

![](man/figures/readme-shift-and-rotate-2-1.png)

``` r
russia_shape |>
  shift_and_rotate(dx = -45) |>
  ggplot() +
  geom_spatvector(fill = "#3243A6", color = "white")
```

![](man/figures/readme-shift-and-rotate-3-1.png)

### `remove_unique_outliers()`

[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.html)
was developed to simplify the removal of abnormal values in raster
files. It can be used with
[GeoTIFF](https://www.ogc.org/standards/geotiff/) and [Esri
ASCII](https://desktop.arcgis.com/en/arcmap/latest/manage-data/raster-and-images/esri-ascii-raster-format.htm)
raster formats.

``` r
library(orbis)
library(readr)
library(terra)
```

``` r
asc_content <- c(
  "ncols         5",
  "nrows         5",
  "xllcorner     0.0",
  "yllcorner     0.0",
  "cellsize      1.0",
  "NODATA_value  -9999",
  "1 2 3 4 5",
  "6 7 8 9 10",
  "11 12 1000 14 15", # Extreme outlier (1000)
  "16 1 18 19 20",
  "21 22 23 24 25"
)
```

``` r
temp_file <- tempfile(fileext = ".asc")

asc_content |> write_lines(temp_file)
```

Values before `remove_unique_outliers()`:

``` r
temp_file |> rast() |> values(mat = FALSE)
#>  [1]    1    2    3    4    5    6    7    8    9   10   11   12 1000   14
#> [15]   15   16    1   18   19   20   21   22   23   24   25
```

Values after `remove_unique_outliers()`:

``` r
temp_file |> remove_unique_outliers()
temp_file |> rast() |> values(mat = FALSE)
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 NA 14 15 16  1 18 19 20 21 22 23 24
#> [25] 25
```

### `map_fill_data()`

[`map_fill_data()`](https://danielvartan.github.io/orbis/reference/map_fill_data.html)
was developed to simplify the preparation of data to fill a map.

``` r
library(dplyr)
library(geodata)
library(ggplot2)
library(orbis)
library(terra)
library(tidyterra)
```

``` r
brazil_states <- geodata::gadm("BRA", level = 1, path = tempdir())
```

``` r
brazil_states |>
  ggplot() +
  geom_spatvector(fill = "#5F45BF", color = "white")
```

![](man/figures/readme-map-fill-data-1-1.png)

``` r
data <- tibble(
  state = sample(brazil_states$NAME_1, size = 1000, replace = TRUE),
  value = sample(1:1000, size = 1000, replace = TRUE)
)

data
#> # A tibble: 1,000 × 2
#>   state              value
#>   <chr>              <int>
#> 1 Minas Gerais         881
#> 2 Mato Grosso do Sul   300
#> 3 Amazonas             778
#> 4 Sergipe              393
#> 5 Acre                 682
#> 6 Roraima              369
#> # ℹ 994 more rows
```

``` r
data <- map_fill_data(data, col_fill = "value", col_code = "state")
#> ! There are duplicated values in state. value will be aggregated using the mean.

data
#> # A tibble: 27 × 2
#>   state                  n
#>   <chr>              <dbl>
#> 1 Minas Gerais        581.
#> 2 Mato Grosso do Sul  538.
#> 3 Amazonas            543.
#> 4 Sergipe             464.
#> 5 Acre                546.
#> 6 Roraima             530.
#> # ℹ 21 more rows
```

``` r
left_join(brazil_states, data, by = c("NAME_1" = "state")) |>
  ggplot() +
  geom_spatvector(aes(fill = n), color = "white") +
  labs(fill = NULL)
```

![](man/figures/readme-map-fill-data-2-1.png)

### `filter_points_on_land()`

[`filter_points_on_land()`](https://danielvartan.github.io/orbis/reference/filter_points_on_land.html)
was developed to filter latitude/longitude points that intersect with a
given [`sf`](https://r-spatial.github.io/sf/) geometry. This is
particularly useful for removing points that fall in the ocean when
working with country or state boundaries.

``` r
library(dplyr)
library(ggplot2)
library(geobr)
library(orbis)
library(sf)
```

``` r
data <- tibble(
  latitude = brazil_state_latitude(),
  longitude = brazil_state_longitude()
)

data
#> # A tibble: 27 × 2
#>   latitude longitude
#>      <dbl>     <dbl>
#> 1  -9.98       -67.8
#> 2  -9.65       -35.7
#> 3   0.0402     -51.1
#> 4  -3.13       -60.0
#> 5 -13.0        -38.5
#> 6  -3.73       -38.5
#> # ℹ 21 more rows
```

``` r
plot_points <- function(data, vector) {
  plot <-
    data |>
    ggplot(aes(x = longitude, y = latitude)) +
    geom_sf(
      data = vector,
      color = "gray75",
      fill = "white",
      inherit.aes = FALSE
    ) +
    geom_point(color = "#3243A6") +
    labs(x = "Longitude", y = "Latitude")

  print(plot)
}
```

``` r
brazil_state_vector <- read_state()
#> Using year/date 2010
```

``` r
data |> plot_points(brazil_state_vector)
```

![](man/figures/readme-filter-points-on-land-1-1.png)

``` r
sp_state_vector <- read_state(code = "SP")
#> Using year/date 2010

sp_state_vector |> st_bbox()
#>         xmin         ymin         xmax         ymax 
#> -53.11011153 -25.31232095 -44.16136516 -19.77988881
```

``` r
data <- filter_points_on_land(data, sp_state_vector |> pull(geom))

data
#> # A tibble: 1 × 2
#>   latitude longitude
#>      <dbl>     <dbl>
#> 1    -23.6     -46.6
```

``` r
data |> plot_points(brazil_state_vector)
```

![](man/figures/readme-filter-points-on-land-2-1.png)

Click [here](https://danielvartan.github.io/orbis/reference/) to see the
full list of functions.

## Citation

If you use this package in your research, please cite it to acknowledge
the effort put into its development and maintenance. Your citation helps
support its continued improvement.

``` r
citation("orbis")
#> To cite orbis in publications use:
#> 
#>   Vartanian, D. (2025). orbis: Spatial data analysis tools [Computer
#>   software]. https://danielvartan.github.io/orbis
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     title = {orbis: Spatial data analysis tools},
#>     author = {Daniel Vartanian},
#>     year = {2025},
#>     url = {https://danielvartan.github.io/orbis},
#>     note = {R package},
#>   }
```

## License

[![](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)

``` text
Copyright (C) 2025 Daniel Vartanian

orbis is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.
```

## Contributing

[![](https://img.shields.io/badge/Contributor%20Covenant-3.0-4baaaa.svg)](https://www.contributor-covenant.org/version/3/0/code_of_conduct/)

Contributions are welcome! Whether you want to report bugs, suggest
features, or improve the code or documentation, your input is highly
valued. Please check the [issues
tab](https://github.com/danielvartan/orbis/issues) for existing issues
or to open a new one.

[![](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/danielvartan)

You can also support the development of `orbis` by becoming a sponsor.
Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please mention `orbis` in your donation message.
