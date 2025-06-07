#' Get Brazilian municipalities data
#'
#' @description
#'
#' `get_brazil_municipality()` returns a [`tibble`][tibble::tibble] with data
#' about Brazilian municipalities.
#'
#' @param municipality (optional) A [`character`][base::character] vector
#'   with the name of the municipalities. If `NULL` the function returns all
#'   municipalities (default: `NULL`).
#' @param state (optional) A [`character`][base::character] vector with the
#'   name of the states (default: `NULL`).
#' @param year (optional) An [`integerish`][checkmate::test_int] number
#'   indicating the year of the data regarding the municipalities
#'   (default: `Sys.Date() |> lubridate::year()`).
#' @param coords_method (optional) A string indicating the method to retrieve
#'   the latitude and longitude coordinates of the municipalities. Options are:
#'   - `"geobr"`: Uses [`read_municipal_seat()`][geobr::read_municipal_seat]
#'     from the [`geobr`][geobr::geobr] package to retrieve the coordinates.
#'   - `"geocodebr"`: Uses the [`geocode()`][geocodebr::geocode] from the
#'     [`geocodebr`][geocodebr::geocodebr] package to retrieve the coordinates.
#'  (default: `"geobr"`).
#' @param force (optional) A [`logical`][base::logical] flag indicating
#'   whether to force the download of the data again (default: `FALSE`).
#'
#' @return A [`tibble`][tibble::tibble] with the following columns:
#'   - `region_code`: The region code.
#'   - `region`: The region name.
#'   - `state_code`: The state code.
#'   - `state`: The state name.
#'   - `federal_unit`: The state abbreviation.
#'   - `municipality_code`: The municipality code.
#'   - `municipality`: The municipality name.
#'   - `latitude`: The municipality latitude.
#'   - `longitude`: The municipality longitude.
#'
#' @template details_brazil_c
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_municipality() |> dplyr::glimpse()
#'
#' get_brazil_municipality(municipality = "Belém")
#'
#' get_brazil_municipality(municipality = "Belém", state = "Pará")
#'
#' get_brazil_municipality(municipality = c("Belém", "São Paulo"))
get_brazil_municipality <- function(
  municipality = NULL,
  state = NULL,
  year = Sys.Date() |> lubridate::year(),
  coords_method = "geobr",
  force = FALSE
) {
  prettycheck::assert_internet()
  checkmate::assert_character(municipality, null.ok = TRUE)
  checkmate::assert_character(state, null.ok = TRUE)
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_choice(coords_method, c("geobr", "geocodebr"))
  checkmate::assert_flag(force)

  # R CMD Check variable bindings fix
  # nolint start
  geom  <- code_state <- abbrev_state <- code_muni <- name_muni <- NULL
  region <- region_code <- state_code <- federal_unit <- NULL
  municipality_code <- country <- .env <- NULL
  # nolint end

  # Use `stringi::stri_escape_unicode` to escape unicode characters.
  # stringi::stri_escape_unicode("")

  # Use `tools::showNonASCIIfile` to show non-ASCII characters.
  # tools::showNonASCIIfile(here::here("R", "get_brazil_state.R"))

  brazil_municipalities_file <- file.path(
    tempdir(), paste0("brazil-municipalities-", year, ".rds")
  )

  if (
    checkmate::test_file_exists(brazil_municipalities_file) &&
      isFALSE(force)
  ) {
    brazil_municipalities_data <- readr::read_rds(brazil_municipalities_file)
  } else {
    brazil_municipalities_data <-
      geobr::read_municipality(
        year =
          year |> #nolint
          get_closest_geobr_year(type = "municipality"),
        showProgress = FALSE,
        cache = !force
      ) |>
      dplyr::as_tibble() |>
      dplyr::select(
        code_muni,
        name_muni,
        code_state,
        abbrev_state
      ) |>
      dplyr::rename(
        state_code = code_state,
        federal_unit = abbrev_state,
        municipality_code = code_muni,
        municipality = name_muni
      ) |>
      dplyr::mutate(
        region = get_brazil_region(federal_unit),
        region_code = get_brazil_region_code(region),
        state_code = as.integer(state_code),
        state = orbis::get_brazil_state(federal_unit),
        municipality_code = as.integer(municipality_code),
        municipality = groomr::to_title_case_pt(
          municipality,
          articles = TRUE,
          conjunctions = FALSE,
          oblique_pronouns = FALSE,
          prepositions = FALSE,
          custom = c(
            # E
            "(.)\\bE( )\\b" = "\\1e\\2",
            # Às
            "(.)\\b\u00c0(s)?\\b" = "\\1\u00e0\\2",
            # Da | Das | Do | Dos | De
            "(.)\\bD(((a|o)(s)?)|(e))\\b" = "\\1d\\2",
            # Em
            "(.)\\bE(m)\\b" =  "\\1e\\2",
            # Na | Nas | No | Nos
            "(.)\\bN((a|o)(s)?)\\b" = "\\1n\\2",
            # Del
            "(.)\\bD(el)\\b" = "\\1d\\2"
          )
        )
      ) |>
      dplyr::relocate(
        country,
        region_code,
        region,
        state_code,
        state,
        federal_unit,
        municipality_code,
        municipality
      )

    brazil_municipalities_data <-
      brazil_municipalities_data |>
      dplyr::left_join(
        get_brazil_municipality_coords(
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
      prettycheck::assert_identical(
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
            to_ascii(tolower(municipality)) %in% .env$municipality[i] &
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
              state_code = NA_integer_,
              state = NA_character_,
              federal_unit = NA_character_,
              country = "Brazil"
            )
          )
      } else {
        out <- out |> dplyr::bind_rows(data)
      }
    }

    out
  }
}
