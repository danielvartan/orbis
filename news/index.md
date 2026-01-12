# Changelog

## orbis (development version)

- All geocoding functions have been removed. Users are encouraged to use
  [tidygeocoder](https://jessecambon.github.io/tidygeocoder/) or
  [geocodebr](https://ipeagit.github.io/geocodebr/) as alternatives.
- Several redundant functions were removed to better align with the
  `rspatial` ecosystem.
- Functions no longer use the `get_` prefix for improved consistency.
- `wc_*()` functions have been renamed to `worldclim_*()` for clarity.
- The `aggregate` argument has been removed from
  [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md).
- The package license has been updated from
  [MIT](https://opensource.org/license/mit) to
  [GPLv3](https://opensource.org/license/lgpl-3-0).
- New functions
  [`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
  [`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
  and `worldclim_extract_*()` have been added to support
  [WorldClim](https://www.worldclim.org/) integration.
- Introduced
  [`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
  and
  [`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md)
  for outlier detection and removal.
- Introduced
  [`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md)
  to help troubleshoot [geobr](https://ipeagit.github.io/geobr/)
  connectivity issues.
- [`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md)
  now includes support for the year 2024 in
  [`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html).
- Several dependencies have been moved to `Suggests` to reduce
  installation overhead.
- The Code of Conduct has been updated to [Contributor Covenant
  3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- Error messages, documentation, and test coverage have been improved
  throughout the package.
- The documentation was updated to reflect these changes.

## orbis 0.1.0

- First release! 🎉

## orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
