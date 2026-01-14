# Shift and rotate a SpatVector or a SpatRaster

`shift_and_rotate()` shifts a
[`SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
or a
[`SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
by a specified horizontal distance and rotates the data around the
[International Date
Line](https://en.wikipedia.org/wiki/International_Date_Line).

This function is particularly useful for working with rasters and
vectors that span the date line (e.g., the Russian territory).

## Usage

``` r
shift_and_rotate(x, dx = -45, precision = 5, overlap_tolerance = 0.1)
```

## Arguments

- x:

  A
  [`SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
  or
  [`SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
  object to be shifted and rotated.

- dx:

  (optional) A number indicating the amount of the horizontal shift in
  degrees. Positive values shift to the right, negative values shift to
  the left (default: `-45`).

- precision:

  (optional) An integer number specifying the number of decimal digits
  to use when rounding longitude and latitude coordinates (default:
  `5`).

- overlap_tolerance:

  (optional) A number specifying the tolerance for overlapping
  geometries when combining vectors. This value controls the allowable
  error when merging overlapping geometries (default: `0.1`).

## Value

A object of the same class as `x` that has been shifted and rotated by
the specified amount in degrees.

## See also

Other terra functions:
[`shift_and_crop()`](https://danielvartan.github.io/orbis/reference/shift_and_crop.md)

## Examples

``` r
# Set the Environment -----

library(curl)
library(dplyr)
library(geodata)
library(ggplot2)
library(magrittr)
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
    labs(fill = NULL) +
    theme(
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank()
    )

    print(plot)
}

# Vector Example -----

## Define the Vector

# \dontrun{
  if (has_internet()) {
    russia_vector <- gadm(country = "rus", level = 0, path = tempdir())
  }
# }

## Visualize the Vector

# \dontrun{
  if (has_internet()) {
    russia_vector |> plot_vector()
  }

# }

## Shift and Rotate the Vector -45 Degrees to the Left

# \dontrun{
  if (has_internet()) {
    russia_vector |> shift_and_rotate(-45) |> plot_vector()
  }

# }

## Shift and Rotate the Vector 45 Degrees to the Right

# \dontrun{
  if (has_internet()) {
    russia_vector |> shift_and_rotate(45) |> plot_vector()
  }

# }

# Raster Example -----

## Define the Raster

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

## Visualize the Raster

# \dontrun{
  if (has_internet()) {
    raster |> plot_raster()
  }

# }

## Shift and Rotate the Vector -45 Degrees to the Left

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(-45) |> plot_raster()
  }

# }

## Shift and Rotate the Vector -90 Degrees to the Left

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(-90) |> plot_raster()
  }

# }

## Shift and Rotate the Vector -135 Degrees to the Left

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(-135) |> plot_raster()
  }

# }

## Shift and Rotate the Vector -180 Degrees to the Left

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(-180) |> plot_raster()
  }

# }

## Visualize the Raster

# \dontrun{
  if (has_internet()) {
    raster |> plot_raster()
  }

# }

## Shift and Rotate the Vector 45 Degrees to the Right

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(45) |> plot_raster()
  }

# }

## Shift and Rotate the Vector 90 Degrees to the Right

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(90) |> plot_raster()
  }

# }

## Shift and Rotate the Vector 135 Degrees to the Right

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(135) |> plot_raster()
  }

# }

## Shift and Rotate the Vector 180 Degrees to the Right

# \dontrun{
  if (has_internet()) {
    raster |> shift_and_rotate(180) |> plot_raster()
  }

# }
```
