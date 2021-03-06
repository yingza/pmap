projection <- function(x, min = 0, max = 1) {
  x_min <- min(x, na.rm = TRUE)
  x_max <- max(x, na.rm = TRUE)
  
  # handle the case of all `x` are the same
  if (x_max == x_min || is.null(x) || is.na(x)) {
    # return the middle of expectation
    return((max + min) / 2)
  }

  ((x - x_min)/(x_max - x_min)) * (max - min) + min
}

#' @importFrom grDevices    col2rgb
#' @importFrom grDevices    rgb
get_color_variants <- function(name) {
  color <- grDevices::col2rgb(name, alpha = TRUE)
  arg <- split(color, rownames(color))

  alphas <- c(0.3, 0.5, 1)
  result <- c()
  for (alpha in alphas) {
    arg$alpha <- round(alpha * 255)
    arg$maxColorValue <- 255
    result[length(result)+1] <- do.call(grDevices::rgb, arg)
  }
  return(result)
}

# define material design palette base colors
material_colors <- c(
  "blue",         "red",          "green",        "yellow",   "brown",
  "indigo",       "pink",         "teal",         "amber",    "orange",
  "purple",       "deep-orange",  "light-green",  "lime",     "grey",
  "deep-purple",  "cyan",         "blue-grey",    "light-blue"
)

#' @importFrom ggsci        pal_material
get_palette <- function(size) {
  # limit the size to the length of `material_colors`
  if (size > length(material_colors)) {
    size <- length(material_colors)
  } else if (size < 1) {
    return()
  }

  # calculate the colors
  sapply(
    sapply(material_colors[1:size], ggsci::pal_material, reverse = TRUE),
    function(x) { x(1) }
  )
}

get_colors <- function(types) {
  if (length(types) < 1) {
    return(list())
  }

  colors <- lapply(get_palette(length(types)), get_color_variants)
  names(colors) <- types

  return(colors)
}

# Function for generating random time vector
generate_random_datetimes <- function(size, from = "2017-01-01", to = "2017-12-31") {
  as.POSIXct(
    round(stats::runif(
      size,
      min = as.numeric(as.POSIXct(from)),
      max = as.numeric(as.POSIXct(to))
    )),
    origin = "1970-01-01"
  )
}
