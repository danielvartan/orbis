# Borrowed from `rutils`: github.com/danielvartan/rutils
shush <- function(x, quiet = TRUE) {
  if (isTRUE(quiet)) {
    suppressMessages(suppressWarnings(x))
  } else {
    x
  }
}

# Borrowed from `groomr`: github.com/danielvartan/groomr
to_ascii <- function(x, from = "UTF-8") {
  checkmate::assert_character(x)
  checkmate::assert_string(from)

  x |> iconv(to = "ASCII//TRANSLIT")
}
