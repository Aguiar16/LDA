require(tidytext)
require(topicmodels)
require(dplyr)
require(tm)

LDAdefault <-function(){
numT <- 2
matModel <- readr::read_csv("./model.csv")

dtm <- tidytext::cast_dtm(matModel, document, word, number)

mLDA <- topicmodels::LDA(x = dtm, k = numT, method = "Gibbs", control = list(seed = 1234))

ap_topics <- tidy(mLDA, matrix = "gamma")

write.csv(ap_topics, file = "DefaultLDA.csv")

ap_topics
}

LDAdefault()