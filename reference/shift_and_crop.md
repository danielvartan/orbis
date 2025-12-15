# Shift, rotate, and crop a raster using a vector

`shift_and_crop()` shifts and rotates both a raster and a vector by a
specified horizontal distance, then crops the raster to the extent of
the shifted vector.

This function is particularly useful for working with rasters and
vectors that span the dateline (e.g. the Russian territory).

## Usage

``` r
shift_and_crop(
  raster,
  vector,
  dx = -45,
  precision = 5,
  overlap_tolerance = 0.1,
  ...
)
```

## Arguments

- raster:

  A
  [`SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
  object to be shifted, rotated, and cropped.

- vector:

  A
  [`SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
  object to be shifted and rotated.

- dx:

  A numeric value indicating the amount of the horizontal shift in
  degrees. Positive values shift to the right, negative values shift to
  the left (default: `-45`).

- precision:

  (optional) A numeric value specifying the number of decimal digits to
  use when rounding longitude and latitude coordinates (default: `5`).

- overlap_tolerance:

  (optional) A numeric value specifying the tolerance for overlapping
  geometries when combining vectors. This value controls the allowable
  error when merging overlapping geometries (default: `0.1`).

- ...:

  Additional arguments passed to
  [`crop()`](https://rspatial.github.io/terra/reference/crop.html).

## Value

A
[`SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
object that has been shifted and rotated by the specified amount in
degrees, then cropped to the extent of the provided vector.

## See also

Other raster functions:
[`shift_and_rotate()`](https://danielvartan.github.io/orbis/reference/shift_and_rotate.md)

## Examples

``` r
# Set the Environment -----

library(curl)
library(dplyr)
library(geodata)
library(ggplot2)
library(terra)
library(tidyterra)

plot_vector <- function(vector) {
  plot <-
    vector |>
    ggplot() +
    geom_spatvector(fill = "#3243A6", color = "white")

  print(plot)
}

plot_raster <- function(raster) {
  plot <-
    ggplot() +
    geom_spatraster(data = raster) +
    scale_fill_continuous(
      palette = c("#072359", "#3243A6", "#9483AF"),
      na.value = "white"
    ) +
    labs(fill = NULL)

    print(plot)
}

# Define the Vector -----

# \dontrun{
  if (has_internet()) {
    russia_vector <- gadm(country = "rus", level = 0, path = tempdir())

    russia_vector |> plot_vector()
  }

# }

# Define the Raster -----

# \dontrun{
  if (has_internet()) {
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
  }
# }

# Visualize the Raster Before Shift and Crop -----

# \dontrun{
  if (has_internet()) {
    raster |> plot_raster()
  }

# }

# Shift, Rotate and Crop the Raster -----

# \dontrun{
  if (has_internet()) {
    raster <- raster |> shift_and_crop(russia_vector, -45)
  }
# }

# Visualize the Raster After Shift and Crop -----

# \dontrun{
  if (has_internet()) {
    raster |> plot_raster()
  }

# }
```
