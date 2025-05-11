get_geocode_by_postal_code <- function(
  postal_code,
  method = "qualocep",
  fix_code = TRUE, # Just for Brazilian postal codes.
  limit = 10, # Inf for all.
  suffix = ", Brazil"
) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_choice(method, c("osm", "google", "qualocep"))
  checkmate::assert_flag(fix_code)
  checkmate::assert_number(limit)
  checkmate::assert_string(suffix)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  if (isTRUE(fix_code)) {
    postal_code <- postal_code |> orbis::fix_postal_code(zero_na = TRUE)
  }

  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")

  if (method %in% c("osm", "google")) {
    get_geocode_by_postal_code_tidygeocoder(
      postal_code, method, limit, suffix
    )
  } else if (method == "qualocep") {
    get_geocode_by_postal_code_qualocep(postal_code, limit)
  }
}

get_geocode_by_postal_code_tidygeocoder <- function( #nolint
    postal_code, #nolint
    method = "osm",
    limit = 10,
    suffix = ", Brazil"
) {
  postal_code <- orbis::fix_postal_code(postal_code, zero_na = FALSE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

  # R CMD Check variable bindings fix
  # nolint start
  address <- latitude <- longitude <- NULL
  # nolint end

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  if (method == "osm") {
    dplyr::tibble(postal_code = postal_code) |>
      tidygeocoder::geocode(
        postalcode = postal_code,
        method = method,
        lat = "latitude",
        long = "longitude"
      )
  } else {
    dplyr::tibble(address = paste0(postal_code, suffix)) |>
      tidygeocoder::geocode(
        address = address,
        method = method,
        lat = "latitude",
        long = "longitude"
      ) |>
      dplyr::transmute(
        postal_code = postal_code,
        latitude = dplyr::if_else(
          latitude == -14.235004,
          NA_real_,
          latitude
        ),
        longitude = dplyr::if_else(
          longitude == -51.92528,
          NA_real_,
          longitude
        )
      )
  }
}

get_geocode_by_postal_code_qualocep <- function( #nolint
    postal_code, #nolint
    limit = 10
  ) {
  postal_code <- postal_code |> orbis::fix_postal_code(zero_na = TRUE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

  # R CMD Check variable bindings fix
  # nolint start
  latitude <- longitude <- NULL
  # nolint end

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  qualocep_data <- get_qualocep_data()

  out <-
    dplyr::tibble(postal_code = postal_code) |>
    dplyr::left_join(
      qualocep_data,
      by = "postal_code"
    )

  if (any(c("latitude", "longitude") %in% names(qualocep_data), na.rm = TRUE)) {
    out |> dplyr::select(postal_code, latitude, longitude)
  } else {
    out |>
      dplyr::transmute(
        postal_code = postal_code,
        latitude = NA_real_,
        longitude = NA_real_
      )
  }
}
