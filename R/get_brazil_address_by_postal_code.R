#' Get a Brazilian address by its postal code via reverse geocoding
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `get_brazil_address_by_postal_code()` is a function that retrieves a
#' Brazilian address based on a postal code. It uses reverse geocoding to
#' approximate the address based on the postal code.
#'
#' Please note that the accuracy of the results may vary depending on the
#' method used.
#'
#' @details
#'
#' The source of the data will depend on the method used. Run
#' [`?tidygeocoder::geo`][tidygeocoder::geo()] to learn more. The only exception
#' is the `"qualocep"` and `"viacep"` method. These methods will return the
#' address data from the [QualoCEP](https://www.qualocep.com/) database and the
#' [ViaCEP](https://viacep.com.br/) API, respectively.
#'
#' @param postal_code A [`character`][base::character()] vector with the postal
#'   code(s) to be used to. The postal code must be in the format `XXXXX-XXX` or
#'   `XXXXXXXX`, where `X` is a digit.
#' @param method A [`character`][base::character()] value indicating the method
#'   to be used to retrieve the address data. The available options are `"osm"`,
#'   `"google"`,`"qualocep"`, and `"viacep"` (default: `qualocep`).
#' @param fix_code A [`logical`][base::logical()] flag indicating if the postal
#'  code must be fixed before being used (default: `TRUE`).
#' @param limit A [`numeric`][base::numeric()] value indicating the maximum
#'   number of results to return (default: `10`). If the value is `Inf`, all
#'   postal codes will be used.
#'
#'
#' @return A [`tibble`][dplyr::tibble()] with the following columns:
#'  - `postal_code`: The postal code.
#'  - `street`: The street name.
#'  - `complement`: The address complement.
#'  - `neighborhood`: The neighborhood.
#'  - `municipality_code`: The IBGE code for the address municipality.
#'  - `municipality`: The municipality.
#'  - `state`: The state.
#'  - `region`: The region.
#'  - `address`: The full address.
#'  - `latitude`: The latitude.
#'  - `longitude`: The longitude.
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' "01223000" |>
#'   get_brazil_address_by_postal_code() |>
#'   dplyr::glimpse()
#'
#' c("01223000", NA, "05411002") |> get_brazil_address_by_postal_code()
#' }
get_brazil_address_by_postal_code <- function( #nolint
    postal_code, #nolint
    method = "qualocep",
    fix_code = TRUE,
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_choice(method, c("osm", "google", "qualocep", "viacep"))
  checkmate::assert_flag(fix_code)
  checkmate::assert_number(limit, lower = 0)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  if (isTRUE(fix_code)) {
    postal_code <- postal_code |> fix_postal_code(zero_na = TRUE)
  }

  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")


  if (method == "osm") {
    get_brazil_address_by_postal_code_osm(postal_code, limit)
  } else if (method == "google") {
    get_brazil_address_by_postal_code_google(postal_code, limit)
  } else if (method == "qualocep") {
    get_brazil_address_by_postal_code_qualocep(postal_code, limit)
  } else if (method == "viacep") {
    get_brazil_address_by_postal_code_viacep(postal_code, limit)
  }
}

get_brazil_address_by_postal_code_osm <- function( #nolint
    postal_code, #nolint
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_number(limit, lower = 0)

  # R CMD Check variable bindings fix
  # nolint start
   lat <- long <- city <- town <- osm_lat <- osm_lon <- house_number <- NULL
   road <- suburb <- state <- region <- municipality <- street <- NULL
   complement <- neighborhood <- latitude <- longitude <- NULL
   municipality_code <- state_code <- address <- NULL
  # nolint end

  postal_code <- fix_postal_code(postal_code, zero_na = TRUE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  out <-
    dplyr::tibble(postal_code = postal_code) |>
    tidygeocoder::geocode(
      postalcode = postal_code,
      method = "osm"
    ) |>
    tidygeocoder::reverse_geocode(
      lat = lat,
      long = long,
      method = "osm",
      full_results = TRUE
    )

  if (!"house_number" %in% names(out)) {
    out <- out |> dplyr::mutate(house_number = NA_character_)
  }

  if (!"city" %in% names(out)) {
    out <- out |> dplyr::mutate(city = NA_character_)
  }

  if ("town" %in% names(out)) {
    out <- out |> dplyr::mutate(
      city = dplyr::if_else(is.na(city), town, city)
    )
  }

  if (!"osm_lat" %in% names(out)) {
    dplyr::tibble(
      postal_code = fix_postal_code(postal_code, zero_na = TRUE),
      street = NA_character_,
      complement = NA_character_,
      neighborhood = NA_character_,
      municipality_code = NA_integer_,
      municipality = NA_character_,
      state_code = NA_integer_,
      state = NA_character_,
      region = NA_character_,
      address = NA_character_,
      latitude = NA_real_,
      longitude = NA_real_
    )
  } else {
    out |>
      dplyr:: select(
        postal_code,
        osm_lat,
        osm_lon,
        house_number,
        road,
        suburb,
        city,
        state,
        region
      ) |>
      dplyr::rename(
        street = road,
        complement = house_number,
        neighborhood = suburb,
        municipality = city,
        latitude = osm_lat,
        longitude = osm_lon
      ) |>
      dplyr::mutate(
        postal_code = fix_postal_code(postal_code, zero_na = TRUE),
        municipality_code = get_brazil_municipality_code(municipality),
        state_code = get_brazil_state_code(state),
        region = get_brazil_region(state),
        address = render_brazil_address(
          street, complement, neighborhood, municipality, state,
          postal_code
        ),
        latitude = as.numeric(latitude),
        longitude = as.numeric(longitude)
      ) |>
      dplyr::mutate(
        dplyr::across(
          dplyr::where(is.character),
          .fns = ~ dplyr::if_else(.x == "", NA_character_, .x)
        )
      ) |>
      dplyr::relocate(
        postal_code, street, complement, neighborhood, municipality_code,
        municipality, state_code, state, region, address, latitude, longitude
      )
  }
}

get_brazil_address_by_postal_code_google <- function( #nolint
    postal_code, #nolint
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_number(limit, lower = 0)

  # R CMD Check variable bindings fix
  # nolint start
  address <- lat <- long <- address_components <- short_name <- NULL
  types <- long_name <- street_number <- route <- sublocality <- NULL
  administrative_area_level_1 <- administrative_area_level_2 <- NULL
  latitude <- longitude <- municipality <- state <- street <- NULL
  complement <- neighborhood <- municipality_code <- state_code <- NULL
  region <- .env <- dummy <- NULL
  # nolint end

  postal_code <- fix_postal_code(postal_code, zero_na = TRUE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  out <-
    dplyr::tibble(address = paste0(postal_code, ", Brazil")) |>
    tidygeocoder::geocode(
      address = address,
      method = "google"
    ) |>
    tidygeocoder::reverse_geocode(
      lat = lat,
      long = long,
      method = "google",
      full_results = TRUE
    )

  out <-
    out |>
    dplyr::pull(address_components) |>
    purrr::map(function(x) {
      selected_vars <- c(
        "street_number",
        "route",
        "sublocality",
        "administrative_area_level_1",
        "administrative_area_level_2",
        "country",
        "postal_code"
      )

      vars <- character()

      for (i in x$types) {
        if (any(i %in% selected_vars)) {
          vars <- c(vars, i[i %in% selected_vars])
        } else {
          vars <- c(vars, basename(tempfile("dump_var_")))
        }
      }

      out <-
        x |>
        dplyr::as_tibble() |>
        dplyr::mutate(types = vars) |>
        dplyr::select(-short_name) |>
        tidyr::pivot_wider(
          names_from = types,
          values_from = long_name
        )

      for (i in setdiff(selected_vars, vars)) {
        out <-
          out |>
          dplyr::bind_cols(
            dplyr::tibble(
              !!as.symbol(i) := rep(NA_character_, nrow(out))
            )
          )
      }

      out |> dplyr::select(dplyr::all_of(selected_vars))
    }) |>
    purrr::map_df(dplyr::bind_rows) |>
    dplyr::bind_cols(
      out |>
        dplyr::transmute(
          latitude = lat,
          longitude = long
        )
    )

  out |>
    dplyr::select(
      street_number,
      route,
      sublocality,
      administrative_area_level_1,
      administrative_area_level_2,
      postal_code,
      latitude,
      longitude
    ) |>
    dplyr::rename(
      street = route,
      complement = street_number,
      neighborhood = sublocality,
      municipality = administrative_area_level_2,
      state = administrative_area_level_1
    ) |>
    dplyr::mutate(
      postal_code = fix_postal_code(postal_code, zero_na = TRUE),
      municipality_code = get_brazil_municipality_code(municipality, state),
      state_code = get_brazil_state_code(state),
      region = get_brazil_region(state),
      address = render_brazil_address(
        street, complement, neighborhood, municipality, state, postal_code
      )
    ) |>
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.character),
        .fns = ~ dplyr::if_else(.x == "", NA_character_, .x)
      )
    ) |>
    dplyr::relocate(
      postal_code, street, complement, neighborhood, municipality_code,
      municipality, state_code, state, region, address, latitude, longitude
    ) |>
    dplyr::mutate(
      latitude = as.numeric(latitude),
      longitude = as.numeric(longitude)
    ) |>
    dplyr::mutate(
      dummy = !postal_code == .env$postal_code,
      postal_code = .env$postal_code
    ) |>
    dplyr::mutate(
      dplyr::across(
        .cols = -dplyr::all_of(c("postal_code", "dummy")),
        .fns = ~ ifelse(dummy, NA, .x)
      )
    ) |>
    dplyr::select(-dummy)
}

get_brazil_address_by_postal_code_qualocep <- function( #nolint
    postal_code, #nolint
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_number(limit, lower = 0)

  # R CMD Check variable bindings fix
  # nolint start
   street <- complement <- neighborhood <- municipality_code <- NULL
   municipality <- state_code <- state <- latitude <- longitude <- NULL
   address <- NULL
  # nolint end

  postal_code <- fix_postal_code(postal_code, zero_na = TRUE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

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

  if (any(c("latitude", "longitude") %in% names(qualocep_data))) {
    out |>
      dplyr::select(
        postal_code, street, complement, neighborhood, municipality_code,
        municipality, state_code, state, latitude, longitude
      ) |>
      dplyr::mutate(
        region = get_brazil_region(state),
        address = render_brazil_address(
          street, complement, neighborhood, municipality, state, postal_code
        )
      ) |>
      dplyr::relocate(latitude, longitude, .after = address)
  } else {
    out |>
      dplyr::select(
        postal_code, street, complement, neighborhood, municipality_code,
        municipality, state_code, state
      ) |>
      dplyr::mutate(
        region = get_brazil_region(state),
        address = render_brazil_address(
          street, complement, neighborhood, municipality, state, postal_code
        ),
        latitude = NA_real_,
        longitude = NA_real_
      )
  }
}

get_brazil_address_by_postal_code_viacep <- function( #nolint
    postal_code, #nolint
    limit = 10
  ) {
  prettycheck::assert_internet()
  checkmate::assert_atomic(postal_code)
  checkmate::assert_number(limit, lower = 0)

  # R CMD Check variable bindings fix
  # nolint start
   cep <- logradouro <- complemento <- unidade <- bairro <- localidade <- NULL
   ibge <- localidade <- estado <- municipality_code <- street <- NULL
   complement <- neighborhood <- municipality <- state <- address <- NULL
  # nolint end

  postal_code <- fix_postal_code(postal_code, zero_na = TRUE)

  prettycheck::assert_internet()
  checkmate::assert_character(postal_code, pattern = "^\\d{8}$")
  checkmate::assert_number(limit)

  if (!is.infinite(limit)) {
    limit <- as.integer(ceiling(limit))
    postal_code <- postal_code[seq_len(min(length(postal_code), limit))]
  }

  blank_viacep_data <- dplyr::tibble(
    cep = NA_character_,
    logradouro = NA_character_,
    complemento = NA_character_,
    unidade = NA_character_,
    bairro = NA_character_,
    localidade = NA_character_,
    uf = NA_character_,
    estado = NA_character_,
    regiao = NA_character_,
    ibge = NA_character_,
    gia = NA_character_,
    ddd = NA_character_,
    siafi = NA_character_
  )

  cli::cli_progress_bar(
    name = "Getting address data from the ViaCEP API.",
    type = "tasks",
    total = length(postal_code),
    clear = FALSE
  )

  out <- dplyr::tibble()

  for (i in postal_code) {
    query_data <-
      jsonlite::fromJSON(
        paste0("https://viacep.com.br/ws/", i, "/json/")
      ) |>
      dplyr::as_tibble()

    if (!is.null(query_data[["erro"]])) {
      cli::cli_alert_warning(
        paste0(
          "Postal code {.strong {cli::col_red(i)}} not found in the ",
          "ViaCEP API."
        )
      )

      out <- dplyr::bind_rows(
        out,
        blank_viacep_data |> dplyr::mutate(cep = i)
      )
    } else {
      out <- dplyr::bind_rows(
        out,
        jsonlite::fromJSON(
          paste0("https://viacep.com.br/ws/", i, "/json/")
        ) |>
          dplyr::as_tibble()
      )
    }

    cli::cli_progress_update()
  }

  out |>
    dplyr::transmute(
      postal_code = fix_postal_code(cep, zero_na = TRUE),
      street = logradouro,
      complement = complemento,
      neighborhood = bairro,
      municipality_code = ibge,
      municipality = localidade,
      state_code = get_brazil_state_code(estado),
      state = estado,
      region = get_brazil_region(estado)
    ) |>
    dplyr::mutate(
      municipality_code = as.integer(municipality_code),
      address = render_brazil_address(
        street, complement, neighborhood, municipality, state, postal_code
      ),
      address = as.character(address),
      address = dplyr::if_else(is.na(street), NA, address),
      latitude = NA_real_,
      longitude = NA_real_
    ) |>
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.character),
        .fns = ~ dplyr::if_else(.x == "", NA_character_, .x)
      )
    )
}
