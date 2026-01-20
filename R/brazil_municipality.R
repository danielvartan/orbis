#' Get Brazilian municipalities data
#'
#' @description
#'
#' `brazil_municipality()` returns a [`tibble`][tibble::tibble()] with data
#' about Brazilian municipalities.
#'
#' This function normalizes names and objects from the
#' [`read_municipality()`][geobr::read_municipality()] function of the
#' [`geobr`][geobr::geobr] package, adding latitude and longitude
#' coordinates for each municipality.
#'
#' **Note:** This function requires an internet connection to work and the
#' [`geobr`](https://ipeagit.github.io/geobr/) or
#' [`geocodebr`](https://ipeagit.github.io/geocodebr/) package to be
#' installed, depending on the chosen method for retrieving coordinates.
#'
#' @param municipality (optional) A [`character`][base::character()] vector
#'   with the name of the municipalities. If `NULL` the function returns all
#'   municipalities (default: `NULL`).
#' @param state (optional) A [`character`][base::character()] vector with the
#'   name of the states (default: `NULL`).
#' @param year (optional) An [`integerish`][checkmate::test_int()] number
#'   indicating the year of the data regarding the municipalities
#'   (default: `Sys.Date() |> substr(1, 4) |> as.numeric()`).
#' @param coords_method (optional) A [`character`][base::character()] string
#'   indicating the method to retrieve the latitude and longitude coordinates of
#'   the municipalities (default: `"geobr"`). Options are:
#'   - `"geobr"`: Uses [`read_municipal_seat()`][geobr::read_municipal_seat()]
#'     from the [`geobr`][geobr::geobr()] package to retrieve the coordinates.
#'   - `"geocodebr"`: Uses the [`geocode()`][geocodebr::geocode()] from the
#'     [`geocodebr`][geocodebr::geocodebr()] package to retrieve the coordinates.
#' @param force (optional) A [`logical`][base::logical()] flag indicating
#'   whether to force the download of the data again (default: `FALSE`).
#'
#' @return A [`tibble`][tibble::tibble()] with the following columns:
#'   - `municipality`: The municipality name.
#'   - `municipality_code`: The municipality code.
#'   - `state`: The state name.
#'   - `state_code`: The state code.
#'   - `federal_unit`: The state abbreviation.
#'   - `region`: The region name.
#'   - `region_code`: The region code.
#'   - `latitude`: The municipality latitude.
#'   - `longitude`: The municipality longitude.
#'
#' @template details_brazil_c
#' @family Brazil functions
#' @export
#'
#' @examples
#' library(curl)
#' library(dplyr)
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality() |> glimpse()
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality(municipality = "Belém") |> glimpse()
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality(municipality = "Belém", state = "Pará") |> glimpse()
#'   }
#' }
#'
#' \dontrun{
#'   if (has_internet()) {
#'     brazil_municipality(municipality = c("Belém", "São Paulo")) |> glimpse()
#'   }
#' }
brazil_municipality <- function(
  municipality = NULL,
  state = NULL,
  year = Sys.Date() |> substr(1, 4) |> as.numeric(),
  coords_method = "geobr",
  force = FALSE
) {
  require_pkg("geobr", "tools")

  assert_internet()
  checkmate::assert_character(municipality, null.ok = TRUE)
  checkmate::assert_character(state, null.ok = TRUE)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_choice(coords_method, c("geobr", "geocodebr"))
  checkmate::assert_flag(force)

  # R CMD Check variable bindings fix
  # nolint start
  geom <- code_state <- abbrev_state <- code_muni <- name_muni <- NULL
  region <- region_code <- state_code <- federal_unit <- NULL
  municipality_code <- .env <- NULL
  # nolint end

  brazil_municipalities_file <- file.path(
    get_cache_directory(),
    paste0(
      "brazil-municipalities-",
      year |>
        closest_geobr_year(type = "municipality"),
      ".rds"
    )
  )

  if (file.exists(brazil_municipalities_file) && isFALSE(force)) {
    brazil_municipalities_data <-
      brazil_municipalities_file |>
      readr::read_rds()
  } else {
    brazil_municipalities_data <- dplyr::tibble()
  }

  if (nrow(brazil_municipalities_data) > 5000) {
    brazil_municipalities_data
  } else {
    brazil_municipalities_data <-
      read_municipality(
        year = year |>
          closest_geobr_year(
            type = "municipality",
            verbose = FALSE
          ),
        showProgress = FALSE,
        cache = !force
      ) |>
      dplyr::as_tibble() |>
      dplyr::select(
        name_muni,
        code_muni,
        code_state,
        abbrev_state
      ) |>
      dplyr::rename(
        municipality = name_muni,
        municipality_code = code_muni,
        state_code = code_state,
        federal_unit = abbrev_state
      ) |>
      dplyr::mutate(
        municipality = municipality |>
          to_title_case_pt(
            articles = TRUE,
            conjunctions = FALSE,
            oblique_pronouns = FALSE,
            prepositions = FALSE,
            custom_rules = c(
              # E
              "(.)\\bE( )\\b" = "\\1e\\2",
              # Às
              "(.)\\b\u00c0(s)?\\b" = "\\1\u00e0\\2",
              # Da | Das | Do | Dos | De
              "(.)\\bD(((a|o)(s)?)|(e))\\b" = "\\1d\\2",
              # Em
              "(.)\\bE(m)\\b" = "\\1e\\2",
              # Na | Nas | No | Nos
              "(.)\\bN((a|o)(s)?)\\b" = "\\1n\\2",
              # Del
              "(.)\\bD(el)\\b" = "\\1d\\2"
            )
          ),
        municipality_code = as.integer(municipality_code),
        state = brazil_state(federal_unit),
        state_code = as.integer(state_code),
        region = brazil_region(federal_unit),
        region_code = brazil_region_code(region)
      ) |>
      dplyr::relocate(
        municipality,
        municipality_code,
        state,
        state_code,
        federal_unit,
        region,
        region_code
      )

    brazil_municipalities_data <-
      brazil_municipalities_data |>
      dplyr::left_join(
        brazil_municipality_coords(
          year = year,
          coords_method = coords_method,
          force = force
        ) |>
          shush(ifelse(coords_method == "geobr", TRUE, FALSE)),
        by = "municipality_code"
      )

    readr::write_rds(brazil_municipalities_data, brazil_municipalities_file)
  }

  if (is.null(municipality)) {
    brazil_municipalities_data
  } else {
    municipality <-
      municipality |>
      to_ascii() |>
      stringr::str_to_lower() |>
      stringr::str_remove_all("[^a-z'\\- ]") |>
      stringr::str_squish()

    if (!is.null(state)) {
      assert_identical(
        municipality,
        state,
        type = "length"
      )

      state <-
        state |>
        to_ascii() |>
        stringr::str_to_lower() |>
        stringr::str_remove_all("[^a-z'\\- ]") |>
        stringr::str_squish()
    }

    out <- dplyr::tibble()

    for (i in seq_along(municipality)) {
      if (is.null(state)) {
        data <-
          brazil_municipalities_data |>
          dplyr::filter(
            to_ascii(tolower(municipality)) %in% .env$municipality[i]
          )
      } else {
        data <-
          brazil_municipalities_data |>
          dplyr::filter(
            to_ascii(tolower(municipality)) %in%
              .env$municipality[i] &
              to_ascii(tolower(state)) %in% .env$state[i]
          )
      }

      if (nrow(data) == 0) {
        out <-
          out |>
          dplyr::bind_rows(
            dplyr::tibble(
              municipality = .env$municipality[i],
              municipality_code = NA_integer_,
              state = NA_character_,
              state_code = NA_integer_,
              federal_unit = NA_character_,
              region = NA_character_,
              region_code = NA_integer_,
              latitude = NA_real_,
              longitude = NA_real_
            )
          )
      } else {
        out <- out |> dplyr::bind_rows(data)
      }
    }

    out
  }
}
