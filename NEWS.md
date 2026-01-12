# orbis (development version)

- All geocoding functions have been removed. Use [tidygeocoder](https://jessecambon.github.io/tidygeocoder/) or [geocodebr](https://ipeagit.github.io/geocodebr/) instead.
- Several redundant functions were removed to align with the `rspatial` ecosystem.
- Functions no longer use the `get_` prefix.
- `wc_*()` functions are renamed to `worldclim_*()`.
- `worldclim_to_ascii()` no longer has the `aggregate` argument.
- The package license changed from [MIT](https://opensource.org/license/mit) to [GPLv3](https://opensource.org/license/lgpl-3-0).
- `worldclim_file()`, `worldclim_random()`, and `worldclim_extract_*()` were added for [WorldClim](https://www.worldclim.org/) integration.
- `unique_outliers()` and `remove_unique_outliers()` were added for outlier detection and removal.
- `test_geobr_connection()` was added to troubleshoot [geobr](https://ipeagit.github.io/geobr/) connectivity.
- `closest_geobr_year()` now supports 2024 for [`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html).
- Several dependencies were moved to `Suggests` to reduce installation overhead.
- The Code of Conduct was updated to [Contributor Covenant 3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- Error messages, documentation, and test coverage were improved throughout the package.

# orbis 0.1.0

- First release. 🎉

# orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
