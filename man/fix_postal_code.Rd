% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fix_postal_code.R
\name{fix_postal_code}
\alias{fix_postal_code}
\title{Fix postal code numbers}
\usage{
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
}
\arguments{
\item{postal_code}{A \code{\link[base:character]{character}} vector with postal code
numbers.}

\item{min_char}{(optional) An \link[checkmate:checkIntegerish]{integerish}
number with the minimum number of characters (default: \code{3}).}

\item{max_char}{(optional) An \link[checkmate:checkIntegerish]{integerish}
number with the maximum number of characters (default: \code{8}).}

\item{squish}{(optional) A \code{\link[base:logical]{logical}} flag indicating
whether to squish (i.e., remove leading, trailing, and extra spaces)
the postal code numbers (default: \code{TRUE}).}

\item{remove_non_numeric}{(optional) A \code{\link[base:logical]{logical}} flag
indicating whether to remove non-numeric characters from the postal
code numbers (default: \code{TRUE}).}

\item{remove_number_sequences}{(optional) A \code{\link[base:logical]{logical}}
flag indicating whether to remove number sequences from the postal
code numbers. This is useful to remove postal code numbers like
\code{11111111} (default: \code{TRUE}).}

\item{trunc}{(optional) A \code{\link[base:logical]{logical}} flag indicating
whether to truncate the postal code numbers to \code{max_char} width
(default: \code{TRUE}).}

\item{pad}{(optional) A \code{\link[base:logical]{logical}} flag indicating
whether to pad the postal code numbers with zeros to \code{max_char}
width (default: \code{TRUE}).}

\item{zero_na}{(optional) A \code{\link[base:logical]{logical}} flag indicating
whether to replace \code{NA} values with zeros (default: \code{FALSE}).}
}
\value{
A \code{\link[base:character]{character}} vector with fixed postal code
numbers.
}
\description{
\code{fix_postal_code()} provides tools to fix postal code numbers.
}
\examples{
fix_postal_code("  01014908  ", squish = TRUE)
#> [1] "01014908" # Expected

fix_postal_code("01014908", min_char = 10)
#> [1] NA # Expected

fix_postal_code("01014908", max_char = 5, trunc = FALSE)
#> [1] NA # Expected

fix_postal_code("A1C14D08", remove_non_numeric = TRUE, pad = TRUE)
#> [1] "11408000" # Expected

fix_postal_code("123456789", remove_number_sequences = TRUE)
#> [1] NA # Expected

fix_postal_code("01014908", max_char = 5, trunc = TRUE)
#> [1] "01014" # Expected

fix_postal_code("01253", max_char = 8, pad = TRUE)
#> [1] "01253000" # Expected

fix_postal_code(NA, max_char = 8, zero_na = TRUE)
#> [1] "00000000" # Expected
}
\seealso{
Other utility functions: 
\code{\link{get_closest_geobr_year}()},
\code{\link{get_map_fill_data}()}
}
\concept{utility functions}
