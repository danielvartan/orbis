# Return unique outliers

`unique_outliers()` returns the unique outliers of a
[`numeric`](https://rdrr.io/r/base/numeric.html) vector based on the
interquartile range
([IQR](https://en.wikipedia.org/wiki/Interquartile_range)).

This function first removes duplicated values from the input vector `x`
to ensure that outlier detection is based on unique values. It then
calculates the first (Q1) and third (Q3) quartiles, as well as the IQR.
Outliers are defined as values that fall below `Q1 - n_iqr * IQR` or
above `Q3 + n_iqr * IQR`, where `n_iqr` is a user-defined multiplier
(default is 1.5).

## Usage

``` r
unique_outliers(x, n_iqr = 1.5)
```

## Arguments

- x:

  An [`numeric`](https://rdrr.io/r/base/numeric.html) vector with at
  least 4 values.

- n_iqr:

  (optional) A number specifying the multiplier of the interquartile
  range ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)) to
  define outliers (default: `1.5`).

## Value

A [`numeric`](https://rdrr.io/r/base/numeric.html) vector with the
outliers of `x`.

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`fix_postal_code()`](https://danielvartan.github.io/orbis/reference/fix_postal_code.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_date_line()`](https://danielvartan.github.io/orbis/reference/test_date_line.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md)

## Examples

``` r
c(1:10) |> unique_outliers()
#> integer(0)
#> integer(0) # Expected

c(1:10, 100L, 100L) |> unique_outliers()
#> [1] 100
#> [1] 100 # Expected

c(1:10, 100L) |> unique_outliers(n_iqr = 1000)
#> integer(0)
#> integer(0) # Expected
```
