
# DATA PULL #

pacman::p_load(tidyverse, tidytext, feather, here)


# Direct Download ---------------------------------------------------------

# The data is scraped from historic 'Dear Abby' column letters.  
# It's currently on GitHub.  
# This is how you'd get it straight from the source.

# data_url <- "https://raw.githubusercontent.com/the-pudding/data/master/dearabby/raw_da_qs.csv"
# 
# # Specify column types
# da_data <- read_csv(data_url, col_types = list(col_double(),
#                                                col_double(),
#                                                col_character(),
#                                                col_character(),
#                                                col_character(),
#                                                col_double(),
#                                                col_character()))
# 
# # Parsing issue fix:  day (one row has extra ,)
# da_data <- da_data %>% 
#   mutate(day = str_remove(day, ",") %>% as.numeric(.),
#          decade = year - (year %% 10))  # Also build decade cat
# 
# # Save this as a feather file (in case we want it later)
# write_feather(da_data, "dear_abby.feather")


# Load Data ---------------------------------------------------------------

# We're going to use the data pre-pulled as a feather file.

# Data was compressed to zip
unzip(zipfile = here::here("dear_abby.zip"), list = T)

# Unzip and read data
unzip(zipfile = here("data", "dear_abby.zip"), exdir = here())
da_data <- read_feather("dear_abby.feather")

# Clean up
unlink(x = "dear_abby.feather")
