#' Return unique outliers
#'
#' @description
#'
#' `unique_outliers()` returns the unique outliers of a
#' [`numeric`][base::numeric()] vector based on the interquartile range
#' ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)).
#'
#' This function first removes duplicated values from the input vector `x`
#' to ensure that outlier detection is based on unique values. It then
#' calculates the first (Q1) and third (Q3) quartiles, as well as the IQR.
#' Outliers are defined as values that fall below `Q1 - n_iqr * IQR` or above
#' `Q3 + n_iqr * IQR`, where `n_iqr` is a user-defined multiplier
#' (default is 1.5).
#'
#' @param x An [`numeric`][base::numeric()] vector with at least 4 values.
#' @param n_iqr (optional) A number specifying the multiplier of the
#'   interquartile range
#'   ([IQR](https://en.wikipedia.org/wiki/Interquartile_range))
#'   to define outliers (default: `1.5`).
#'
#' @return A [`numeric`][base::numeric()] vector with the outliers of `x`.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' c(1:10) |> unique_outliers()
#' #> integer(0) # Expected
#'
#' c(1:10, 100L, 100L) |> unique_outliers()
#' #> [1] 100 # Expected
#'
#' c(1:10, 100L) |> unique_outliers(n_iqr = 1000)
#' #> integer(0) # Expected
unique_outliers <- function(x, n_iqr = 1.5) {
  require_package("stats")

  checkmate::assert_numeric(x, min.len = 4)
  checkmate::assert_number(n_iqr, lower = 0)

  x <- x[!duplicated(x)]

  q_1 <- stats::quantile(x, 0.25, na.rm = TRUE)
  q_3 <- stats::quantile(x, 0.75, na.rm = TRUE)
  iqr <- stats::IQR(x, na.rm = TRUE)

  x[x < (q_1 - n_iqr * iqr) | x > (q_3 + n_iqr * iqr)]
}
