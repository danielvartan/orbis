#' Get Qual o CEP data
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' `get_qualocep_data()` retrieves a validated dataset of Qual o CEP from the
#' package's [OSF repository](https://osf.io/9ky4g/).
#'
#' @details
#'
#' [Qual o CEP](https://www.qualocep.com) is a database of Brazilian addresses
#' and postal codes geocoded made using the Google Geocoding API.
#'
#' Please note the year of the pattern. Some values could be
#'
#' @param file (optional) A [`character`][base::character] string with the
#'   path to a Qual o CEP dataset file. If `NULL`, the dataset will be
#'   downloaded from the package's [OSF repository](https://osf.io/9ky4g/).
#'   (default: `NULL`).
#' @param pattern (optional) A [`character`][base::character] string with
#'   the pattern of the Qual o CEP dataset file to download. Click
#'   [here](https://osf.io/k5hyq/files/osfstorage) to see the available
#'   patterns (default: `"2024-11-12.rds"`).
#' @param force (optional) A [`logical`][base::logical] flag to force the
#'   download of the Qual o CEP dataset file. If `TRUE`, the dataset will
#'   be downloaded even if it already exists in the temporary directory
#'   (default: `FALSE`).
#'
#' @return A [`tibble`][tibble::tibble] containing the Qual o CEP dataset with
#'   the following columns:
#'   - `postal_code`: A [`character`][base::character] vector with the postal
#'     codes.
#'   - `street_type`: A [`character`][base::character] vector with the type of
#'     streets.
#'   - `street_name`: A [`character`][base::character] vector with the name of
#'     the streets.
#'   - `street`: A [`character`][base::character] vector with the full name of
#'     the streets.
#'   - `complement`: A [`character`][base::character] vector with the
#'     complement of the addresses.
#'   - `place`: A [`character`][base::character] vector with the place of the
#'     addresses.
#'   - `neighborhood`: A [`character`][base::character] vector with the
#'     neighborhoods
#'   - `municipality_code`: An [`integer`][base::integer] vector with the codes
#'     of the Brazilian Institute of Geography and Statistics
#'     ([IBGE](https://www.ibge.gov.br/)) for Brazilian municipalities.
#'   - `municipality`: A [`character`][base::character] vector with the name of
#'     the municipalities.
#'   - `state_code`: An [`integer`][base::integer] vector with the codes of the
#'     Brazilian Institute of Geography and Statistics
#'     ([IBGE](https://www.ibge.gov.br/)) for the Brazilian state.
#'   - `state`: A [`character`][base::character] vector with the name of the
#'     states.
#'   - `federal_unit`: A [`character`][base::character] vector with the
#'     abbreviations of the Brazilian federal unit.
#'   - `latitude`: A [`numeric`][base::numeric] vector with the latitude values
#'     of the postal codes (retrieved using Google Geocoding API).
#'   - `longitude`: A [`numeric`][base::numeric] vector with the longitude
#'     values of the postal codes (retrieved using Google Geocoding API).
#'
#' @family API functions
#' @export
#'
#' @examples
#' \dontrun{
#'   get_qualocep_data()
#' }
get_qualocep_data <- function(
  file = NULL,
  pattern = "2024-11-12.rds",
  force = FALSE
) {
  checkmate::assert_string(file, null.ok = TRUE)
  checkmate::assert_string(pattern, pattern = "\\.rds$")
  checkmate::assert_flag(force)

  qualocep_temp_file <- file.path(tempdir(), pattern)

  if (!is.null(file)) {
    checkmate::assert_file_exists(file, extension = "rds")

    readr::read_rds(file)
  } else if (checkmate::test_file_exists(qualocep_temp_file) &&
               isFALSE(force)) {
    readr::read_rds(qualocep_temp_file)
  } else {
    prettycheck::assert_internet()

    cli::cli_progress_step("Downloading Qual o CEP data from OSF.")

    osf_id <- "https://osf.io/k5hyq"

    file <-
      osfr::osf_ls_files(
        osfr::osf_retrieve_node(osf_id),
        pattern = pattern
      ) |>
      osfr::osf_download(path = tempdir(), conflicts = "overwrite") |>
      magrittr::extract2("local_path")

    readr::read_rds(file)
  }
}
