# Get the closest year available in the `geobr` package

`closest_geobr_year()` returns the closest year available in the
[`geobr`](https://ipeagit.github.io/geobr/reference/geobr.html) package
for a specified type of data.

## Usage

``` r
closest_geobr_year(year, type = "country", verbose = TRUE)
```

## Arguments

- year:

  An
  [`integerish`](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  vector with the year to find the closest available year in the `geobr`
  package.

- type:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string indicating the type of data to find the closest year for. It
  can be one of the following: `"municipality"`, `"municipal_seat"`,
  `"state"`, or `"country"` (default: `"country"`).

- verbose:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to print a warning message if the specified year is
  not available in the `geobr` package. Only applicable if `year` is a
  single value (default: `TRUE`).

## Value

A [`numeric`](https://rdrr.io/r/base/numeric.html) vector with the
closest year available in the geobr package for the specified type of
data.

## See also

Other utility functions:
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_date_line()`](https://danielvartan.github.io/orbis/reference/test_date_line.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
closest_geobr_year(2025, type = "municipality")
#> ! The closest map year to 2025 is 2024. Using year 2024 instead.
#> [1] 2024
#> [1] 2024 # Expected

closest_geobr_year(2025, type = "municipal_seat")
#> ! The closest map year to 2025 is 2010. Using year 2010 instead.
#> [1] 2010
#> [1] 2010 # Expected

closest_geobr_year(2025, type = "state")
#> ! The closest map year to 2025 is 2020. Using year 2020 instead.
#> [1] 2020
#> [1] 2020 # Expected

closest_geobr_year(2025, type = "country")
#> ! The closest map year to 2025 is 2020. Using year 2020 instead.
#> [1] 2020
#> [1] 2020 # Expected

closest_geobr_year(c(2025, 1999, NA, 1800), type = "country")
#> [1] 2020 2000   NA 1872
#> [1] 2020 2000   NA 1872 # Expected
```
