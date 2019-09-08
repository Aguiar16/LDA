require(tm)
require(dplyr)
require(tidytext)
require(iterators)
require(foreach)
data(stop_words)

x <- "./texttest.csv"
dataFile <- tidytext::unnest_tokens(readr::read_csv(x), word, Title)
# dataFile

# write.csv(x = dataFile, file = "modelo.csv", row.names = FALSE)
# splited <- split(dataFile, dataFile$Documento)

countWords <- dataFile %>% 
anti_join(stop_words) %>% 
count(word, word) %>% 
ungroup()
countWords


#https://stackoverflow.com/questions/9713294/split-data-frame-based-on-levels-of-a-factor-into-new-data-frames