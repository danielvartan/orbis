extract_wc_variable <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=(m|s)_)[a-z]*(?=_)")
}

extract_wc_resolution <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=wc2.1_).*(m|s)(?=_)")
}

extract_wc_month <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=-)[0-9]{2}(?=.[A-Za-z])")
}

extract_wc_year <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=_)[0-9]{4}(?=-[0-9]{2}.[A-Za-z])")
}

extract_wc_year_month <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=_)[0-9]{4}-[0-9]{2}(?=.[A-Za-z])")
}

extract_wc_year_group <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("[0-9]{4}-[0-9]{4}")
}

extract_wc_gcm <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("(?<=_)[A-Z].+(?=_ssp[0-9]{3})")
}

extract_wc_ssp <- function(file) {
  checkmate::assert_character(file)

  file |> stringr::str_extract("ssp[0-9]{3}")
}
