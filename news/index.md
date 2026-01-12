# Changelog

## orbis (development version)

- All geocoding functions have been removed. Use
  [tidygeocoder](https://jessecambon.github.io/tidygeocoder/) or
  [geocodebr](https://ipeagit.github.io/geocodebr/) instead.
- Several redundant functions were removed to align with the `rspatial`
  ecosystem.
- Functions no longer use the `get_` prefix.
- `wc_*()` functions are renamed to `worldclim_*()`.
- [`worldclim_to_ascii()`](https://danielvartan.github.io/orbis/reference/worldclim_to_ascii.md)
  no longer has the `aggregate` argument.
- The package license changed from
  [MIT](https://opensource.org/license/mit) to
  [GPLv3](https://opensource.org/license/lgpl-3-0).
- [`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
  [`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
  and `worldclim_extract_*()` were added for
  [WorldClim](https://www.worldclim.org/) integration.
- [`unique_outliers()`](https://danielvartan.github.io/orbis/reference/unique_outliers.md)
  and
  [`remove_unique_outliers()`](https://danielvartan.github.io/orbis/reference/remove_unique_outliers.md)
  were added for outlier detection and removal.
- [`test_geobr_connection()`](https://danielvartan.github.io/orbis/reference/test_geobr_connection.md)
  was added to troubleshoot [geobr](https://ipeagit.github.io/geobr/)
  connectivity.
- [`closest_geobr_year()`](https://danielvartan.github.io/orbis/reference/closest_geobr_year.md)
  now supports 2024 for
  [`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html).
- Several dependencies were moved to `Suggests` to reduce installation
  overhead.
- The Code of Conduct was updated to [Contributor Covenant
  3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- Error messages, documentation, and test coverage were improved
  throughout the package.

## orbis 0.1.0

- First release. 🎉

## orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
