library(brandr)
library(here)
library(ggplot2)

source(here("R", ".setup.R"))

theme_set(
  theme_bw(base_size = 16) +
    theme(
      text = element_text(
        color = brandr::get_brand_color("black"),
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
