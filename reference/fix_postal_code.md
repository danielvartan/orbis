# Fix postal code numbers

`fix_postal_code()` provides tools to fix postal code numbers.

## Usage

``` r
fix_postal_code(
  postal_code,
  min_char = 3,
  max_char = 8,
  squish = TRUE,
  remove_non_numeric = TRUE,
  remove_number_sequences = TRUE,
  trunc = TRUE,
  pad = TRUE,
  zero_na = FALSE
)
```

## Arguments

- postal_code:

  A [`character`](https://rdrr.io/r/base/character.html) vector with
  postal code numbers.

- min_char:

  (optional) An
  [integerish](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  number with the minimum number of characters (default: `3`).

- max_char:

  (optional) An
  [integerish](https://mllg.github.io/checkmate/reference/checkIntegerish.html)
  number with the maximum number of characters (default: `8`).

- squish:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to squish (i.e., remove leading, trailing, and
  extra spaces) the postal code numbers (default: `TRUE`).

- remove_non_numeric:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to remove non-numeric characters from the postal
  code numbers (default: `TRUE`).

- remove_number_sequences:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to remove number sequences from the postal code
  numbers. This is useful to remove postal code numbers like `11111111`
  (default: `TRUE`).

- trunc:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to truncate the postal code numbers to `max_char`
  width (default: `TRUE`).

- pad:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to pad the postal code numbers with zeros to
  `max_char` width (default: `TRUE`).

- zero_na:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to replace `NA` values with zeros (default:
  `FALSE`).

## Value

A [`character`](https://rdrr.io/r/base/character.html) vector with fixed
postal code numbers.

## See also

Other utility functions:
[`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md),
[`map_fill_data()`](https://danielvartan.github.io/orbis/reference/map_fill_data.md),
[`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md),
[`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md),
[`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)

## Examples

``` r
fix_postal_code("  01014908  ", squish = TRUE)
#> [1] "01014908"
#> [1] "01014908" # Expected

fix_postal_code("01014908", min_char = 10)
#> [1] NA
#> [1] NA # Expected

fix_postal_code("01014908", max_char = 5, trunc = FALSE)
#> [1] NA
#> [1] NA # Expected

fix_postal_code("A1C14D08", remove_non_numeric = TRUE, pad = TRUE)
#> [1] "11408000"
#> [1] "11408000" # Expected

fix_postal_code("123456789", remove_number_sequences = TRUE)
#> [1] NA
#> [1] NA # Expected

fix_postal_code("01014908", max_char = 5, trunc = TRUE)
#> [1] "01014"
#> [1] "01014" # Expected

fix_postal_code("01253", max_char = 8, pad = TRUE)
#> [1] "01253000"
#> [1] "01253000" # Expected

fix_postal_code(NA, max_char = 8, zero_na = TRUE)
#> [1] "00000000"
#> [1] "00000000" # Expected
```
