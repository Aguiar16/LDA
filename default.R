require(tidytext)
require(topicmodels)
require(dplyr)
require(tm)

LDAdefault <-function(){
numT <- 2
# corpus <- SimpleCorpus(DirSource("./corpus", encoding = "UTF-8"), control = list(language = "en"))
corpus <- readr::read_csv("./corpus/model.csv")
# corpus <- split(corpus, matModel$document)
print(corpus)

# dtm <- DocumentTermMatrix(corpus, control = list(stemming = TRUE, wordLengths = c(2,Inf), bounds = list(global=c(2,Inf))))
dtm <- tidytext::cast_dtm(corpus, document, word, number)

print(dtm)
mLDA <- topicmodels::LDA(x = dtm, k = numT, method = "Gibbs", control = list(seed = 1234))

ap_topics <- tidy(mLDA, matrix = "gamma")

write.csv(ap_topics, file = "DefaultLDA.csv")

ap_topics
}

LDAdefault()