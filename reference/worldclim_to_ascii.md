# Convert WorldClim GeoTIFF files to Esri ASCII Grid

`worldclim_to_ascii()` facilitates the conversion of one or more
[WorldClim](https://worldclim.org/)
[GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to the [Esri
ASCII Grid](https://en.wikipedia.org/wiki/Esri_grid) raster format.
Optionally, rasters can be cropped and/or aggregated using a provided
polygon of class
[`SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html).

**Note:** This function requires the [`fs`](https://fs.r-lib.org/)
package to be installed.

## Usage

``` r
worldclim_to_ascii(
  file,
  dir = dirname(file[1]),
  shape = NULL,
  box = NULL,
  dateline_fix = TRUE,
  extreme_outlier_fix = TRUE,
  overwrite = TRUE,
  dx = -45,
  na_flag = -99,
  ...
)
```

## Arguments

- file:

  A [`character`](https://rdrr.io/r/base/character.html) vector of file
  paths to the [WorldClim](https://worldclim.org/)
  [GeoTIFF](https://en.wikipedia.org/wiki/GeoTIFF) files to be
  converted. The files must have a `.tif` extension.

- dir:

  A [`character`](https://rdrr.io/r/base/character.html) vector
  specifying the output directory for the converted [Esri ASCII
  Grid](https://en.wikipedia.org/wiki/Esri_grid) files (default:
  `dirname(file[1])`).

- shape:

  (optional) A
  [`SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
  object representing the polygon to crop the raster data (default:
  `NULL`).

- box:

  (optional) A [`numeric`](https://rdrr.io/r/base/numeric.html) vector
  of length 4 specifying the bounding box for cropping the raster data
  in the format `c(xmin, ymin, xmax, ymax)` (default: `NULL`).

- dateline_fix:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to apply a dateline fix to the raster data. This is
  particularly useful when working with rasters and vectors that span
  the dateline (e.g. the Russian territory). See
  [`shift_and_crop`](https://danielvartan.github.io/orbis/reference/shift_and_crop.md)
  to learn more (default: `TRUE`).

- extreme_outlier_fix:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to replace extreme outliers with `NA`. Extreme
  outliers are defined as values more than 10 times the interquartile
  range ([IQR](https://en.wikipedia.org/wiki/Interquartile_range)) below
  the first or above the third quartile. The quartiles and IQR are
  calculated using the unique (deduplicated) values of the data, and the
  resulting thresholds are applied to the full dataset. This helps
  remove abnormal values in raster data.

- overwrite:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) flag
  indicating whether to overwrite existing files in the output directory
  (default: `TRUE`).

- dx:

  (optional) A [`numeric`](https://rdrr.io/r/base/numeric.html) value
  specifying the horizontal distance in degrees to shift the raster
  data. This is only relevant if `dateline_fix` is set to `TRUE`
  (default: `-45`).

- na_flag:

  (optional) An [`integer`](https://rdrr.io/r/base/integer.html) value
  specifying the `NODATA_VALUE` for the output ASCII files. See the
  *Details* section to learn more (default: `-99`).

- ...:

  Additional arguments passed to
  [`writeRaster()`](https://rspatial.github.io/terra/reference/writeRaster.html)
  for writing the ASCII files.

## Value

An invisible [`character`](https://rdrr.io/r/base/character.html) vector
containing the file paths of the converted ASCII files.

## Details

### `na_flag` parameter

According to the [Esri ASCII](https://en.wikipedia.org/wiki/Esri_grid)
raster format documentation, the default value for `NODATA_VALUE` (the
`NA` flag) is `-9999`. However, using four digits of precision
significantly inflates file size. For
[WorldClim](https://worldclim.org/) data, two significant digits (`-99`)
are sufficient, since the only variables with negative values are
temperatures, and the lowest temperature ever recorded on Earth is above
that threshold.

## See also

Other WorldClim functions:
[`worldclim_download()`](https://danielvartan.github.io/orbis/reference/worldclim_download.md),
[`worldclim_extract_variable()`](https://danielvartan.github.io/orbis/reference/worldclim_extract_variable.md),
[`worldclim_file()`](https://danielvartan.github.io/orbis/reference/worldclim_file.md),
[`worldclim_random()`](https://danielvartan.github.io/orbis/reference/worldclim_random.md),
[`worldclim_url()`](https://danielvartan.github.io/orbis/reference/worldclim_url.md)

## Examples

``` r
# Set the Environment -----

library(curl)
library(fs)
library(httr)
#> 
#> Attaching package: ‘httr’
#> The following object is masked from ‘package:curl’:
#> 
#>     handle_reset
library(magrittr)
library(readr)
library(rvest)
#> 
#> Attaching package: ‘rvest’
#> The following object is masked from ‘package:readr’:
#> 
#>     guess_encoding
library(zip)
#> 
#> Attaching package: ‘zip’
#> The following objects are masked from ‘package:utils’:
#> 
#>     unzip, zip

# Download a WorldClim Dataset -----

# \dontrun{
  if (has_internet()) {
    tif_file <-
      worldclim_download(
        series = "hcd",
        resolution = "10m",
        variable = "prec",
        dir = tempdir()
      ) |>
        magrittr::extract(1)
  }
#> ℹ Scraping WorldClim Website
#> ✔ Scraping WorldClim Website [40ms]
#> 
#> ℹ Calculating File Sizes
#> ℹ Total download size (compressed): NA.
#> ℹ Calculating File Sizes
#> ℹ 1 url requests resulted in error.
#> ℹ Calculating File Sizes
#> ℹ Their file names are:
#> ℹ Calculating File Sizes
#> • wc2.1_10m_prec.zip
#> ℹ Calculating File Sizes
#> ✔ Calculating File Sizes [10s]
#> 
#> ℹ Creating LICENSE and README Files
#> ✔ Creating LICENSE and README Files [17ms]
#> 
#> ℹ Downloading Files
#> ℹ Downloading 1 file to /tmp/RtmpSaKhGk/historical-climate-data
#> ℹ Downloading Files
#> ℹ The file wc2.1_10m_prec.zip could not be downloaded.
#> ℹ Downloading Files
#> ✔ Downloading Files [10s]
#> 
#> ℹ Unzipping Files
#> ✔ Unzipping Files [12ms]
#> 
#> Error: [ENOENT] Failed to remove '/tmp/RtmpSaKhGk/historical-climate-data/wc2.1_10m_prec.zip': no such file or directory
# }

# Transform Data to Esri ASCII -----

# \dontrun{
  if (has_internet()) {
    asc_file <- tif_file |> worldclim_to_ascii()
  }
#> Error: object 'tif_file' not found
# }

# Check the Output -----

# \dontrun{
  if (has_internet()) {
    asc_file |> read_lines(n_max = 11)
  }
#> Error: object 'asc_file' not found
# }
```
