has_internet <- function(...) curl::has_internet()

require_namespace <- function(x, ..., quietly = TRUE) {
  requireNamespace(x, ..., quietly = quietly)
}
