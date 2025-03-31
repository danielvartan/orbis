get_geocode_by_address <- function(
    address = NULL, # nolint
    method = "qualocep",
    limit = 10, # Inf for all.
    ...
  ) {
  prettycheck::assert_internet()
  checkmate::assert_character(address, null.ok = TRUE)
  checkmate::assert_choice(method, c("osm", "google", "qualocep"))
  checkmate::assert_number(limit)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    address <- address[seq_len(min(length(address), limit))]
  }

  if (method %in% c("osm", "google")) {
    get_geocode_by_address_tidygeocoder(address, method, limit)
  } else if (method == "qualocep") {
    get_geocode_by_address_qualocep(limit, ...)
  }
}

get_geocode_by_address_tidygeocoder <- function( #nolint
    address, #nolint
    method = "osm",
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_character(address)
  checkmate::assert_number(limit)

  # R CMD Check variable bindings fix
  # nolint start
  latitude <- longitude <- NULL
  # nolint end

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    address <- address[seq_len(min(length(address), limit))]
  }

  out <-
    dplyr::tibble(address = address) |>
    tidygeocoder::geocode(
      address = address,
      method = method,
      lat = "latitude",
      long = "longitude"
    )

  if (method == "google") {
    out |>
      dplyr::mutate(
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
  } else {
    out
  }
}

get_geocode_by_address_qualocep <- function( #nolint
    limit = 10, #nolint
    mean_values = TRUE,
    ...
  ) {
  prettycheck::assert_internet()
  checkmate::assert_number(limit)

  # R CMD Check variable bindings fix
  # nolint start
  .data <- latitude <- longitude <- NULL
  # nolint end

  if (length(list(...)) == 0) {
    cli::cli_abort(paste0(
      "You must provide at least one argument to ",
      "{.strong {cli::col_red('...')}} ",
      "when using the {.strong qualocep} method."
    ))
  }

  out <- get_qualocep_data()
  args <- list(...)

  checkmate::assert_subset(names(args), names(out))

  for (i in seq_along(args)) {
    out <- out |> dplyr::filter(.data[[names(args)[i]]] %in% args[[i]])
  }

  address <- args |> unlist() |> list()

  if (length(out) == 0) {
    out |>
      dplyr::transmute(
        address = address,
        latitude = NA_real_,
        longitude = NA_real_
      )
  } else {
    out <-
      out |>
      dplyr::transmute(
        address = address,
        latitude = latitude,
        longitude = longitude
      )

    if (!is.infinite(limit)) {
      limit <- as.integer(ceiling(limit))

      out <- out |> dplyr::slice(seq_len(limit))
    }

    if (isTRUE(mean_values)) {
      out |>
        dplyr::summarise(
          latitude = mean(latitude, na.rm = TRUE),
          longitude = mean(longitude, na.rm = TRUE)
        ) |>
        dplyr::mutate(address = address, .before = latitude) |>
        dplyr::mutate(
          dplyr::across(
            .cols = dplyr::where(is.numeric),
            .fns = ~ dplyr::if_else(is.nan(.x), NA_real_, .x)
          )
        )
    } else {
      out
    }
  }
}
