#' Get country names
#'
#' @description
#'
#' `get_country_names()` returns a vector with the names or codes of all
#' countries present in the ISO 3166-1 standard.
#'
#' **Note:** This function requires the
#' [`ISOcodes`](https://CRAN.R-project.org/package=ISOcodes ) package to be
#' installed.
#'
#' @details
#'
#' The data from this function is based on data from the International
#' Organization for Standardization (ISO) (ISO 3166-1) via the
#' [`ISOcodes`][ISOcodes::ISO_3166_1] R package. Click
#' [here](https://www.iso.org/iso-3166-country-codes.html) to learn more.
#'
#' The [`ISOcodes`][ISOcodes::ISO_3166_1] R package uses XML files provided by
#' Debian's [`iso-codes`](https://salsa.debian.org/iso-codes-team/iso-codes)
#' package for the data.
#'
#' @param format (optional) A [`character`][base::character] string indicating
#'   the format to be returned. The options are:
#'   - `"name"`: The name of the country.
#'   - `"common name"`: The common name of the country.
#'   - `"official name"`: The official name of the country.
#'   - `"alpha 2"`: The two-letter country code.
#'   - `"alpha 3"`: The three-letter country code.
#'   - `"numeric"`: The numeric country code.
#'
#' @return A [`character`][base::character] vector with the names or codes of
#'   all countries present in the ISO 3166-1 standard.
#'
#' @family World functions
#' @export
#'
#' @examples
#' get_country_names(format = "alpha 3")
get_country_names <- function(format = "common name") {
  format_options <- c(
    "alpha 2", "alpha 3", "numeric", "name", "official name", "common name"
  )

  checkmate::assert_choice(format, format_options)

  require_pkg("ISOcodes")

  # R CMD Check variable bindings fix
  # nolint start
  name <- NULL
  # nolint end

  out <-
    ISOcodes::ISO_3166_1 |>
    magrittr::set_names(format_options) |>
    dplyr::as_tibble()

  if (format %in% c("official name", "common name")) {
    out <-
      out |>
      dplyr::mutate(
        !!as.symbol(format) := dplyr::if_else(
          is.na(!!as.symbol(format)),
          `name`,
          !!as.symbol(format)
        )
      )
  }

  if (format %in% c("alpha 2", "alpha 3", "numeric")) {
    out |>
      dplyr::pull(format) |>
      magrittr::set_names(out |> dplyr::pull("name"))
  } else {
    out |> dplyr::pull(format)
  }
}
