# orbis (development version)

- All geocoding functions have been removed. Use [tidygeocoder](https://jessecambon.github.io/tidygeocoder/) or [geocodebr](https://ipeagit.github.io/geocodebr/) instead.
- Several redundant functions were removed to align with the `rspatial` ecosystem.
- Functions no longer use the `get_` prefix.
- `wc_*()` functions are renamed to `worldclim_*()`.
- `worldclim_to_ascii()` no longer has `aggregate` or `dx` arguments. Longitude shifts are now handled by [`st_shift_longitude()`](https://r-spatial.github.io/sf/reference/st_shift_longitude.html).
- The package license changed from MIT to GPLv3.
- Added `worldclim_file()`, `worldclim_random()`, and `worldclim_extract_*()` for [WorldClim](https://www.worldclim.org/) integration.
- Added `unique_outliers()` and `remove_unique_outliers()`.
- Added `test_geobr_connection()` to troubleshoot [geobr](https://ipeagit.github.io/geobr/) connectivity.
- `closest_geobr_year()` now supports 2024 for [`read_municipality()`](https://ipeagit.github.io/geobr/reference/read_municipality.html).
- Moved several dependencies to `Suggests` to reduce installation overhead.
- Updated Code of Conduct to [Contributor Covenant 3.0](https://www.contributor-covenant.org/version/3/0/code_of_conduct/).
- Improved error messages, documentation, and test coverage.

# orbis 0.1.0

- First release. 🎉

# orbis 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
