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

test_geometry <- function(geometry) {
  require_pkg("sf")

  test <-
    geometry |>
    sf::st_geometry() |>
    try(silent = TRUE) |>
    suppressMessages() |>
    suppressWarnings()

  if (!inherits(test, "try-error")) {
    TRUE
  } else {
    FALSE
  }
}

check_geometry <- function(geometry, .name = NULL) {
  if (isFALSE(test_geometry(geometry))) {
    paste0(
      "{.strong {cli::col_red(",
      ifelse(is.null(.name), "'geometry'", ".name"),
      ")}} is not a valid ",
      "{.strong sf} object."
    )
  } else {
    TRUE
  }
}

assert_geometry <- function(geometry) {
  require_pkg("sf")

  .name <- deparse(substitute(geometry))

  if (isFALSE(test_geometry(geometry))) {
    geometry |>
      check_geometry(.name) |>
      cli::cli_abort()
  }
}

assert_identical <- function(..., type = "value") {
  values <- list(...)

  assert_length(values, lower = 2)
  checkmate::assert_choice(type, choices = c("value", "length", "class"))

  reference <- values[[1]]

  for (i in seq_along(values)[-1]) {
    current <- values[[i]]

    if ((type == "value") && (!identical(reference, current))) {
      cli::cli_abort("Objects are not identical in value.")
    } else if ((type == "length") && (length(reference) != length(current))) {
      cli::cli_abort("Objects do not have the same length.")
    } else if (
      (type == "class") &&
        (!identical(class(reference), class(current)))
    ) {
      cli::cli_abort("Objects do not have the same class.")
    }
  }

  invisible()
}

assert_length <- function(x, n = NULL, lower = NULL) {
  checkmate::assert_int(n, lower = 1, null.ok = TRUE)
  checkmate::assert_int(lower, null.ok = TRUE)

  .name <- deparse(substitute(x)) #nolint

  if (!is.null(n) && !is.null(lower)) {
    cli::cli_abort("Only one of {.var n} or {.var lower} can be provided.")
  }

  if (!is.null(n)) {
    if (!length(x) == n) {
      cli::cli_abort(
        paste0(
          "{.strong {cli::col_red(.name)}} must have length {.val {n}}."
        )
      )
    }
  }

  if (!is.null(lower)) {
    if (length(x) < lower) {
      cli::cli_abort(
        paste0(
          "{.strong {cli::col_red(.name)}} must have at least ",
          "{.val {lower}} elements."
        )
      )
    }
  }

  invisible()
}
