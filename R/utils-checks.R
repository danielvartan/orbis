test_dateline <- function(vector) {
  checkmate::assert_class(vector, "SpatVector")

  vector_x_min <- round(terra::ext(vector)[1])
  vector_x_max <- round(terra::ext(vector)[2])

  if ((vector_x_max - vector_x_min) > 270) {
    if ("GID_0" %in% names(vector)) {
      if ("Antarctica" %in% vector$GID_0) {
        FALSE
      } else {
        TRUE
      }
    } else {
      TRUE
    }
  } else {
    FALSE
  }
}

assert_identical <- function(..., type = "value") {
  checkmate::assert_choice(type, choices = c("value", "length", "class"))

  values <- list(...)

  if (length(values) < 2) {
    cli::cli_abort("At least two objects must be provided for comparison.")
  }

  reference <- values[[1]]

  for (i in seq_along(values)[-1]) {
    current <- values[[i]]

    if (type == "value" && !identical(reference, current)) {
      cli::cli_abort("Objects are not identical in value.")
    } else if (type == "length" && length(reference) != length(current)) {
      cli::cli_abort("Objects do not have the same length.")
    } else if (type == "class" && !identical(class(reference), class(current))) {
      cli::cli_abort("Objects do not have the same class.")
    }
  }

  invisible()
}
