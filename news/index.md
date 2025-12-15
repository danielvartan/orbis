# Changelog

## orbis 0.1.0.9000 (development version)

- Moved several dependencies to *Suggests* in the DESCRIPTION file to
  avoid unnecessary installations.
- Removed `get_` from the names of functions. Older names are still
  supported but deprecated.
- Renamed `wc_*()` functions to `worldclim_*()` for clarity. Older names
  are still supported but deprecated.
- Change `filter_points_on_land()` to
  [`filter_points()`](https://danielvartan.github.io/orbis/reference/filter_points.md).
  The old name is still supported but deprecated.
- Added
  [`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
  and
  [`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md)
  to handle unique outliers in data.
- Added
  [`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
  [`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md)
  and `worldclim_extract_*()` to deal with
  [WorldClim](https://www.worldclim.org/) data.
- Added
  [`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md)
  to help users troubleshoot connection issues with the
  [`geobr`](https://ipeagit.github.io/geobr/) package.
- Removed the `aggregate` parameter from
  [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md)
  to avoid unintended data aggregation.
- Changed package license from [MIT](https://opensource.org/license/mit)
  to [GPLv3](https://www.gnu.org/licenses/gpl-3.0).
- Updated the Code of Conduct to [Contributor Covenant
  3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- [`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md)
  was updated to include 2024 as an available year for
  `geobr::readr_municipality()`.
- Improved error handling and messaging throughout the package.
- Added more unit tests to increase code coverage.
- Updated the documentation.

## orbis 0.1.0

- First release. 🎉

## orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
