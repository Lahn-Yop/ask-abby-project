
pacman::p_load(ggplot2, extrafont)

# First time extrafont setup (don't do this unless you haven't before!):
# extrafont::font_import()
# extrafont::loadfonts()  # setup for pdf use


# Colors ------------------------------------------------------------------


lanyop_colors <- c(violet = '#7b3294', 
                   lavendar = '#c2a5cf',
                   jade = '#a6dba0',
                   green = '#008837')

#' Function to extract lanyop colors as hex codes
#'
#' @param ... Character names of colors 
#'
lanyop_cols <- function(...) {
  cols <- c(...)
  
  if (is.null(cols))
    return (lanyop_colors)
  
  lanyop_colors[cols]
}


# Palettes ---------------------------------------------------------------


lanyop_palettes <- list(
  `all` = lanyop_cols(),
  `two` = lanyop_cols("violet", "green")
)


#' Return function to interpolate a lanyop color palette
#'
#' @param palette Character name of palette in drsimonj_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
#' @examples 
#' library(ggplot2)
#' 
#' ggplot(mtcars) + 
#'   geom_point(aes(x = wt, y = mpg, colour = factor(gear))) +
#'   scale_color_manual(values = lanyop_pal("all")(3))

lanyop_pal <- function(palette = "all", reverse = FALSE, ...) {
  pal <- lanyop_palettes[[palette]]
  
  if (reverse) pal <- rev(pal)
  
  colorRampPalette(pal, ...)
}

#' The lan-yop ggplot2 theme
#'
#' @param font_size base font size
#' @param line_size base line thickness
#' @param rect_size base rectangle size
#' @param ... other arguments to ggplot2::theme()
#'
#' @examples
#' library(ggplot2)
#' 
#' ggplot(mtcars) + 
#'   geom_point(aes(x = wt, y = mpg, colour = factor(gear))) +
#'   labs(title = "Scatter Plot", subtitle = "Using mtcars") + 
#'   theme_lanyop()
theme_lanyop <- function(font_size = 15, line_size = 0.6, rect_size = 0.6, ...){
  
  theme_classic(base_size = font_size, 
                base_family = "Calibri", 
                base_line_size = line_size, 
                base_rect_size = rect_size) %+replace%
  
  theme(panel.background = element_rect(fill = "gray99", 
                                        linetype = "blank"),
        plot.margin = margin(0.25, 0, 0.25, 0, "lines"),
        plot.title = element_text(face = "bold", 
                                  size = rel(1.15),
                                  color = "dodgerblue4", 
                                  hjust = 0, 
                                  margin = margin(0, 0, 0.2, 0, "lines")), 
        plot.subtitle = element_text(face = "italic", 
                                     size = rel(1), 
                                     color = "dodgerblue4", 
                                     hjust = 0, 
                                     margin = margin(0.2, 0, 0.4, 0, "lines")),
        axis.title = element_text(size = rel(0.75), 
                                  color = "dodgerblue4"), 
        axis.text = element_text(size = rel(0.6), color = "gray30"),
        axis.line = element_line(color = "gray25"),
        axis.ticks = element_blank(), 
        legend.title = element_text(size = rel(0.75), 
                                    face = "bold",
                                    color = "dodgerblue4"),
        legend.text = element_text(size = rel(0.6),
                                   color = "gray30"), 
        strip.text = element_text(size = rel(0.8), 
                                  color = "dodgerblue4"),
        strip.background = element_rect(fill ="gray90"),
        ...)
}


