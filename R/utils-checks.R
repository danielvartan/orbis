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
