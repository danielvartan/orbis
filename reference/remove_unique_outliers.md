# Remove unique outliers from raster files

`remove_unique_outliers()` removes unique outliers from raster files
([GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) or [Esri
ASCII](https://en.wikipedia.org/wiki/Esri_grid) raster format) based on
the interquartile range
([IQR](https://en.wikipedia.org/wiki/Interquartile_range)).

This function processes each raster file by reading its values,
identifying unique outliers using the
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
function, and replacing those outlier values with `NA`. The modified
raster is then saved back to the same file, effectively overwriting the
original data.

**Note:** This function requires the [`fs`](https://fs.r-lib.org/)
package to be installed.

## Usage

``` r
remove_unique_outliers(file, n_iqr = 1.5)
```

## Arguments

- file:

  A [`character`](https://rdrr.io/r/base/character.html) vector with the
  file paths of the raster files to be processed. Supported file formats
  are [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) (`.tif` or
  `.tiff`) and [Esri ASCII](https://en.wikipedia.org/wiki/Esri_grid)
  raster (`.asc`).

- n_iqr:

  (optional) A number specifying the multiplier of the interquartile
  range ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)) to
  define outliers. See
  [`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
  to learn more (default: `1.5`).

## Value

An invisible `NULL` value. This function is used for its side effects.

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`map_fill_data()`](https://danielvartan.github.io/orbis/reference/map_fill_data.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
# Set the Environment -----

library(readr)
#> 
#> Attaching package: ‘readr’
#> The following object is masked from ‘package:curl’:
#> 
#>     parse_date
library(terra)

# Create a Fictional Esri ASCII File -----

asc_content <- c(
  "ncols         5",
  "nrows         5",
  "xllcorner     0.0",
  "yllcorner     0.0",
  "cellsize      1.0",
  "NODATA_value  -9999",
  "1 2 3 4 5 ",
  "6 7 8 9 10 ",
  "11 12 1000 14 15 ", # Extreme outlier (1000)
  "16 1 18 19 20 ",
  "21 22 23 24 25 "
)

temp_file <- tempfile(fileext = ".asc")

asc_content |> write_lines(temp_file)

# Visualize Values Before `remove_unique_outliers()` -----

temp_file |> rast() |> values(mat = FALSE)
#>  [1]    1    2    3    4    5    6    7    8    9   10   11   12 1000   14
#> [15]   15   16    1   18   19   20   21   22   23   24   25

# Visualize Values After `remove_unique_outliers()` -----

temp_file |> remove_unique_outliers()

temp_file |> rast() |> values(mat = FALSE)
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 NA 14 15 16  1 18 19 20 21 22 23 24
#> [25] 25
```
