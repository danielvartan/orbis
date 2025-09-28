plot_raster <- function(raster) {
  require_pkg("ggplot2", "terra", "tidyterra")

  checkmate::assert_class(raster, "SpatRaster")

  plot <-
    ggplot2::ggplot() +
    tidyterra::geom_spatraster(data = raster) +
    ggplot2::scale_fill_continuous(
      palette = c("#072359", "#3243A6", "#9483AF"),
      na.value = "white"
    ) +
    ggplot2::labs(fill = NULL) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      legend.frame = ggplot2::element_blank(),
      legend.ticks = ggplot2::element_line(color = "white")
    )

  print(plot)
}

plot_vector <- function(vector) {
  require_pkg("ggplot2", "terra", "tidyterra")

  checkmate::assert_class(vector, "SpatVector")

  plot <-
    vector |>
    ggplot2::ggplot() +
    tidyterra::geom_spatvector(fill = "#3243A6", color = "white") +
    ggplot2::theme_bw() +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      legend.frame = ggplot2::element_blank(),
      legend.ticks = ggplot2::element_line(color = "white")
    )

  print(plot)
}

plot_points <- function(data, vector) {
  require_pkg("ggplot2", "sf")

  checkmate::assert_tibble(data, min.rows = 1)
  checkmate::assert_subset(c("longitude", "latitude"), names(data))

  # R CMD Check variable bindings fix
  # nolint start
  latitude <- longitude <- NULL
  # nolint end

  plot <-
    data |>
    ggplot2::ggplot(ggplot2::aes(x = longitude, y = latitude)) +
    ggplot2::geom_sf(
      data = vector,
      color = "gray75",
      fill = "white",
      inherit.aes = FALSE
    ) +
    ggplot2::geom_point(color = "#3243A6") +
    ggplot2::labs(x = "Longitude", y = "Latitude") +
    ggplot2::theme_bw() +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      legend.frame = ggplot2::element_blank(),
      legend.ticks = ggplot2::element_line(color = "white")
    )

  print(plot)
}
