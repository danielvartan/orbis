#' Get Brazilian municipalities geographic coordinates
#'
#' @description
#'
#' `get_brazil_municipality_coords()` returns a [`tibble`][tibble::tibble]
#' with the latitude and longitude coordinates of Brazilian municipalities.
#'
#' @param municipality_code (optional) An
#'   [`integerish`][checkmate::test_integerish] vector with the IBGE codes of
#'   Brazilian municipalities. Use
#'   [`get_brazil_municipality_code()`][get_brazil_municipality_code] to
#'   obtain codes from municipality names and states. If `NULL` the function
#'   returns all municipalities (default: `NULL`).
#'
#' @return A [`tibble`][tibble::tibble] with the following columns:
#'   - `municipality_code`: The municipality code.
#'   - `latitude`: The municipality latitude.
#'   - `longitude`: The municipality longitude.
#'
#' @inheritParams get_brazil_municipality
#' @template details_brazil_c
#' @family Brazil functions
#' @export
#'
#' @examples
#' get_brazil_municipality_coords() |> dplyr::glimpse()
#'
#' get_brazil_municipality_coords(municipality_code = 3550308)
#'
#' get_brazil_municipality_coords(municipality_code = 3550)
#'
#' get_brazil_municipality_coords(municipality_code = c(3550308, 3304557))
get_brazil_municipality_coords <- function(
  municipality_code = NULL,
  year = Sys.Date() |> lubridate::year(),
  coords_method = "geobr",
  force = FALSE
) {
  prettycheck::assert_internet()
  checkmate::assert_integerish(municipality_code, null.ok = TRUE)
  checkmate::assert_integer(
    nchar(municipality_code),
    lower = 2,
    upper = 7,
    null.ok = TRUE
  )
  checkmate::assert_integerish(year)
  checkmate::assert_character(as.character(year), pattern = "^[0-9]{4}$")
  checkmate::assert_choice(coords_method, c("geobr", "geocodebr"))
  checkmate::assert_flag(force)

  # R CMD Check variable bindings fix
  # nolint start
  . <- code_muni <- latitude <- longitude <- lat <- lon <- NULL
  name_state <- state <- geom <- NULL
  # nolint end

  if (coords_method == "geobr") {
    out <-
      geobr::read_municipal_seat(
        year = year |> get_closest_geobr_year(type = "municipal_seat"),
        showProgress = FALSE,
        cache = !force
      ) |>
      dplyr::as_tibble() |>
      dplyr::rename(municipality_code = code_muni) |>
      dplyr::mutate(
        geom =
          geom |> #nolint
          terra::vect() |>
          terra::crds() |>
          dplyr::as_tibble() %>%
          split(., seq_len(nrow(.))) |>
          as.list(),
        latitude = geom |> purrr::map_dbl(\(x) x$y),
        longitude = geom |> purrr::map_dbl(\(x) x$x)
      ) |>
      dplyr::select(municipality_code, latitude, longitude)
  } else if (coords_method == "geocodebr") {
    out <-
      geobr::read_municipality(
        year = year |> get_closest_geobr_year(type = "municipality"),
        showProgress = FALSE,
        cache = !force
      ) |>
      dplyr::as_tibble() |>
      dplyr::rename(
        state = name_state,
        municipality_code = code_muni
      ) |>
      dplyr::select(state, municipality_code) |>
      geocodebr::geocode(
        campos_endereco = geocodebr::definir_campos(
          estado = "state",
          municipio = "municipality_code"
        ),
        cache = !force
      ) |>
      dplyr::as_tibble() |>
      dplyr::rename(
        latitude = lat,
        longitude = lon
      ) |>
      dplyr::select(municipality_code, latitude, longitude)
  }

  if (!is.null(municipality_code)) {
    pattern <- paste0(municipality_code, collapse = "|")

    out |>
      dplyr::filter(municipality_code |> stringr::str_starts(pattern))
  } else {
    out
  }
}
