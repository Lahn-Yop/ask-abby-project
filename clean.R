
# DATA CLEANING #

source("pull.R")


# Cleaning Original --------------------------------------------------------

# Remove generic text at end of early letters
ad_text <- c("getting married\\? ",
             "for abby's booklet",
             "problems\\? ",
             "do you hate to write letters because you don't know what to say\\?",
             "is your social life in a slump\\? ",
             "want your phone to ring\\? ")

da_data <- raw_data %>% 
  mutate(question_only = trimws(question_only, "both"),
         dup = if_else(duplicated(question_only), 1, 0)) %>% 
  filter(dup != 1) %>% 
  select(-dup) %>% 
  mutate(question_only = str_remove(question_only, paste0(paste0(ad_text, collapse = "(.+)|"), "(.+)")))


# Create Tokens -----------------------------------------------------------

# Create stopwords specifically for project
abby_stop_words <- 
  stop_words %>% 
  filter(lexicon == "SMART") %>% 
  bind_rows(
    tibble(lexicon = "", 
           word = c(as.character(1:1000), 
                    "copyright", 
                    "abby", 
                    "year",
                    "years",
                    "dear")))

# Tokenize question data into words and remove stop words
clean_tokens <- 
  da_data %>% 
  select(-url, -title) %>% 
  mutate(id = row_number()) %>% 
  unnest_tokens(output = "word", input = "question_only") %>% 
  anti_join(abby_stop_words,
            by = "word") %>% 
  filter(!grepl("reproduc", word))


# Get lemmas using clean_tokens
lemma_data <- clean_tokens %>% 
  mutate(lemmas = lemmatize_words(word))

  
# Get bigrams using clean_tokens
bigram_data <- 
  clean_tokens %>%
  group_by(year, decade, id) %>%  
  summarize(clean_letter = paste0(word, collapse = " ")) %>% 
  ungroup %>% 
  unnest_tokens(output = "bigrams", token = "ngrams", n = 2, input = "clean_letter")
