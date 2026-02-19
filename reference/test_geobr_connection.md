# Test `geobr` package connection with its server

`test_geobr_connection()` tests if the `geobr` package can successfully
connect to its server and retrieve data.

**Note:** This function requires an active internet connection and the
[`geobr`](https://ipeagit.github.io/geobr/) package to be installed.

## Usage

``` r
test_geobr_connection()
```

## Value

A [`logical`](https://rdrr.io/r/base/logical.html) flag indicating if
the connection was successful.

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_date_line()`](https://danielvartan.github.io/orbis/reference/test_date_line.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
# \dontrun{
  library(geobr)
  library(httr2)

  if (is_online()) {
    test_geobr_connection()
  }
#> [1] TRUE
# }
```
