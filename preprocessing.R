library(stringr)
require(tidytext)
require(dplyr)

corpusMatrix <- readr::read_csv("./corpus/DatasetAtualizado.csv")

# divide into documents, each representing one chapter

# split into words
corpusByWord <- corpusMatrix %>%
  select(1, 5) %>%
  mutate(document = Id) %>%
  unnest_tokens(word, Body) %>%
  anti_join(stop_words, by = "word")

# find document-word counts
word_counts <- corpusByWord %>%
  count(document, word) %>%
  ungroup()

write.csv(word_counts, file = "./corpus/DatasetPreparado.csv", row.names = FALSE)