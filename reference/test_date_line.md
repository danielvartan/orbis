# Test if a spatial object crosses the international date line

`test_date_line()` checks whether a given spatial object crosses the
international date line
([IDL](https://en.wikipedia.org/wiki/International_Date_Line)) by
examining its longitude extent.

## Usage

``` r
test_date_line(x)
```

## Arguments

- x:

  A [`sf`](https://r-spatial.github.io/sf/reference/st_as_sf.html),
  [`SpatVector`](https://rspatial.github.io/terra/reference/vect.html),
  or
  [`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html)
  object to be tested.

## Value

A [`logical`](https://rdrr.io/r/base/logical.html) flag indicating if
the object crosses the international date line.

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
# \dontrun{
   library(geodata)

   brazil_shape <- gadm(country = "BRA", level = 0)
   russia_shape <- gadm(country = "RUS", level = 0)

   test_date_line(brazil_shape)
#> [1] FALSE
   test_date_line(russia_shape)
#> [1] TRUE
# }
```
