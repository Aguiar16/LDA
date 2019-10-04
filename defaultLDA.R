require(tidytext)
require(topicmodels)
require(dplyr)
require(tm)

LDAdefault <-function(){
numT <- 20
# corpus <- SimpleCorpus(DirSource("./corpus", encoding = "UTF-8"), control = list(language = "en"))
corpus <- readr::read_csv("./corpus/database.csv")
# corpus <- split(corpus, matModel$document)
print(corpus)

# dtm <- DocumentTermMatrix(corpus, control = list(stemming = TRUE, wordLengths = c(2,Inf), bounds = list(global=c(2,Inf))))
dtm <- tidytext::cast_dtm(corpus, document, word, number)

print(dtm)
mLDA <- topicmodels::LDA(x = dtm, k = numT, method = "Gibbs", control = list(seed = 1234))

ap_topics1 <- tidy(mLDA, matrix = "gamma")
ap_topics2 <- tidy(mLDA, matrix = "beta")

write.csv(ap_topics1, file = "./Results/DefaultLDAGamma.csv")
write.csv(ap_topics2, file = "./Results/DefaultLDABeta.csv")
}

LDAdefault()