# Changelog

## orbis 0.2.1.9000 (development version)

- [`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md)
  now accepts `timeout`, `max_tries`, `retry_on_failure`, and `backoff`
  arguments to handle slow response times from UCDavis servers.
- [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md):
  parameter `extreme_outlier_fix` has been renamed to
  `remove_extreme_outliers`.
- A [Zenodo](https://zenodo.org/) DOI has been registered to provide
  persistent citation and archiving for future releases.

## orbis 0.2.0

- All geocoding functions have been removed. Users should use
  [tidygeocoder](https://jessecambon.github.io/tidygeocoder/) or
  [geocodebr](https://ipeagit.github.io/geocodebr/) instead.
- Several redundant functions have been removed for better alignment
  with the [`r-spatial`](https://r-spatial.org/) ecosystem.
- Function names no longer use the `get_` prefix for improved
  consistency.
- `wc_*()` functions have been renamed to `worldclim_*()` for clarity.
- The `aggregate` argument has been removed from
  [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md).
- The package license has changed from
  [MIT](https://opensource.org/license/mit) to
  [GPLv3](https://opensource.org/license/lgpl-3-0).
- New functions
  [`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
  [`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
  and `worldclim_extract_*()` support
  [WorldClim](https://www.worldclim.org/) integration.
- Added
  [`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
  and
  [`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md)
  for outlier detection and removal.
- Added
  [`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md)
  to help troubleshoot [geobr](https://ipeagit.github.io/geobr/)
  connectivity issues.
- [`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md)
  now supports the year 2024 in
  [`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html).
- Several dependencies have moved to `Suggests` to reduce installation
  overhead.
- The Code of Conduct now follows [Contributor Covenant
  3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- Error messages, documentation, and test coverage have been improved
  throughout the package.
- Documentation has been updated to reflect these changes.

## orbis 0.1.0

- First release! 🎉

## orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
