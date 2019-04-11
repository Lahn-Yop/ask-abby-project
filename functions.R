
# FUNCTIONS #

# Basic distribution plotting helper
dist_plot <- function(df, x){
  
  x <- enquo(x)
  
  ggplot(df) + 
    geom_histogram(aes(!!x), fill = lanyop_cols("blue"), binwidth = 1) +
    theme_lanyop()
}
