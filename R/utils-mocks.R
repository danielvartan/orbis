get_sidra <- function(...) sidrar::get_sidra(...)

is_online <- function(...) httr2::is_online()

read_country <- function(...) geobr::read_country(...)

read_municipality <- function(...) geobr::read_municipality(...)

require_namespace <- function(x, ..., quietly = TRUE) {
  requireNamespace(x, ..., quietly = quietly)
}
