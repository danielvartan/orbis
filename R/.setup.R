# Load Packages -----

library(brandr)
library(downlit)
library(ggplot2)
library(here)
library(knitr)
library(magrittr)
library(ragg)
library(rutils) # github.com/danielvartan/rutils
library(showtext)
library(sysfonts)
library(xml2)

# Set Options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> Comment
)

# Set Variables -----

set.seed(2025)

# Set `knitr`` -----

clean_cache() |> shush()

opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here(),
  dev = "ragg_png",
  fig.showtext = TRUE
)

# Set `brandr` -----

options(BRANDR_BRAND_YML = here("_brand.yml"))

brandr_options <- list(
  "BRANDR_COLOR_SEQUENTIAL" =
    get_brand_color(c("blue", "light-blue", "lilac")),
  "BRANDR_COLOR_DIVERGING" =
    get_brand_color(c("primary", "white", "secondary")),
  "BRANDR_COLOR_QUALITATIVE" = c(
    get_brand_color("primary"),
    get_brand_color("secondary"),
    get_brand_color("tertiary"),
    get_brand_color("black")
  )
)

for (i in seq_along(brandr_options)) options(brandr_options[i])

# Set and Load Fonts -----

font_paths(here("ttf")) |> invisible()

font_add(
  family = "poppins",
  regular = here("ttf", "poppins-regular.ttf"),
  bold = here("ttf", "poppins-bold.ttf"),
  italic = here("ttf", "poppins-italic.ttf"),
  bolditalic = here("ttf", "poppins-bolditalic.ttf"),
  symbol = NULL
)

showtext::showtext_auto()

# Set `ggplot2` Theme -----

theme_set(
  theme_bw() +
    theme(
      text = element_text(
        color = get_brand_color("black"),
        family = "poppins",
        face = "plain"
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.frame = element_blank(),
      legend.ticks = element_line(color = "white"),
      palette.colour.continuous = getOption("BRANDR_COLOR_SEQUENTIAL")
    )
)
