#' Extract components from WorldClim filenames
#'
#' @description
#'
#' `worldclim_extract_*()` extract components present in WorldClim filenames.
#'
#'
#' @param file A [`character`][base::character()] vector with WorldClim
#'   filenames.
#'
#' @return A [`character`][base::character()] vector with the extracted
#'   component.
#'
#' @family WorldClim functions
#' @export
#'
#' @examples
#' files <- c(
#'   "wc2.1_10m_tavg_1970-2000-06.asc",
#'   "wc2.1_cruts4.09_30s_tmin_1962-10.asc",
#'   "wc2.1_5m_tmax_GISS-E2-1-G_ssp370_2081-2100-05.asc"
#' )
#'
#' files |> worldclim_extract_variable()
#' #> [1] "tavg" "tmin" "tmax" # Expected
#'
#' files |> worldclim_extract_resolution()
#' #> [1] "10m" "30s" "5m" # Expected
#'
#' files |> worldclim_extract_month()
#' #> [1] "06" "10" "05" # Expected
#'
#' files |> worldclim_extract_year()
#' #> [1] "1970-2000" "1962"      "2081-2100" # Expected
#'
#' files |> worldclim_extract_year_month()
#' #> [1] "1970-2000-06" "1962-10"      "2081-2100-05" # Expected
#'
#' files |> worldclim_extract_year_group()
#' #> [1] NA         NA         "2081-2100" # Expected
#'
#' files |> worldclim_extract_gcm()
#' #> [1] NA            NA            "GISS-E2-1-G" # Expected
#'
#' files |> worldclim_extract_ssp()
#' #> [1] NA       NA       "ssp370" # Expected
worldclim_extract_variable <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=(m|s)_)[a-z]*(?=_)")
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_resolution <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=_)\\d.*(m|s)(?=_)")
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_month <- function(file) {
  checkmate::assert_character(file)

  ifelse(
    worldclim_extract_variable(file) %in% c("bioc", "elev"),
    NA_character_,
    file |> stringr::str_extract("(?<=-)\\d{2}(?=.[A-Za-z])")
  )
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_year <- function(file) {
  checkmate::assert_character(file)

  ifelse(
    is.na(worldclim_extract_year_group(file)),
    file |> stringr::str_extract("(?<=_)\\d{4}(?=-\\d{2}.[A-Za-z])"),
    worldclim_extract_year_group(file)
  )
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_year_month <- function(file) {
  checkmate::assert_character(file)

  year <- ifelse(
    is.na(worldclim_extract_year_group(file)),
    file |> stringr::str_extract("(?<=_)\\d{4}(?=-\\d{2}.[A-Za-z])"),
    worldclim_extract_year_group(file)
  )

  month <- worldclim_extract_month(file)

  ifelse(
    worldclim_extract_variable(file) %in% c("bioc", "elev"),
    NA_character_,
    paste(year, month, sep = "-")
  )
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_year_group <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("\\d{4}-\\d{4}")
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_gcm <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=_)[A-Z].+(?=_ssp\\d{3})")
}

#' @rdname worldclim_extract_variable
#' @export
worldclim_extract_ssp <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("ssp\\d{3}")
}
