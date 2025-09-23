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
[![](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)
<!-- badges: end -->

## Overview

`orbis` is an R package that offers a suite of tools for simplifying
spatial data analysis.

> If you find this project useful, please consider giving it a star!  
> [![GitHub repo
> stars](https://img.shields.io/github/stars/danielvartan/orbis)](https://github.com/danielvartan/orbis/)

## Installation

You can install `orbis` using the
[`remotes`](https://github.com/r-lib/remotes) package:

``` r
remotes::install_github("danielvartan/orbis")
```

## Usage

`orbis` is equipped with several functions to help with your analysis,
such as:

- [`filter_points_on_land`](https://danielvartan.github.io/orbis/reference/Filter_points_on_land.html):
  Filters latitude/longitude points that intersects with a given
  [`sf`](https://r-spatial.github.io/sf/) geometry.
- [`get_brazil_municipality`](https://danielvartan.github.io/orbis/reference/get_brazil_municipality.html):
  Get Brazilian municipalities data.
- [`get_sidra_by_year`](https://danielvartan.github.io/orbis/reference/get_sidra_by_year.html):
  Get and aggregate data by year from
  [SIDRA](https://sidra.ibge.gov.br/) API (to avoid overloading).
- [`shift_and_rotate`](https://danielvartan.github.io/orbis/reference/shift_and_rotate.html):
  Shift and rotate raster or vector data.
- [`shift and_crop`](https://danielvartan.github.io/orbis/reference/shift_and_crop.html):
  Shift, rotate, and crop a raster using a vector.
- [`wc_to_ascii`](https://danielvartan.github.io/orbis/reference/wc_to_ascii.html):
  Convert [WorldClim](https://worldclim.org/)
  [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to
  [ASCII](https://en.wikipedia.org/wiki/Esri_grid) raster format.

Example:

``` r
library(dplyr)
library(geodata)
library(orbis)
library(terra)
```

``` r
raster <-
  expand.grid(
    seq(-179.75, 179.75, by = 0.5),
    seq(-89.75, 89.75, by = 0.5)
  ) |>
  as_tibble() |>
  rename(x = Var1, y = Var2) |>
  mutate(value = rnorm(259200)) |>
  rast(type = "xyz") %>%
  `crs<-`("epsg:4326")

world_shape <- world(path = tempdir())
raster <- raster |> crop(world_shape, mask = TRUE)

raster |> plot()
```

![](man/figures/readme-shift-and-crop-1-1.png)

``` r
vector <- gadm(country = "rus", level = 0, path = tempdir())

vector |> plot()
```

![](man/figures/readme-shift-and-crop-2-1.png)

``` r
raster |>
  shift_and_crop(vector, dx = -45) |>
  plot()
```

![](man/figures/readme-shift-and-crop-3-1.png)

Click [here](https://danielvartan.github.io/orbis/reference/) to see the
full list of functions.

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

[![](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Contributions are welcome! Whether you want to report bugs, suggest
features, or improve the code or documentation, your input is highly
valued. Please check the [issues
tab](https://github.com/danielvartan/orbis/issues) for existing issues
or to open a new one.

[![](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/danielvartan)

You can also support the development of `orbis` by becoming a sponsor.
Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please mention `orbis` in your donation message.
