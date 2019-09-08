require(tidytext)
require(topicmodels)
require(dplyr)
require(tm)

source("./fitness_function.R")

LDAdefault <-function(){
numT <- 2
matModel <- readr::read_csv("./model.csv")

dtm <- tidytext::cast_dtm(matModel, document, word, number)

mLDA <- topicmodels::LDA(x = AssociatedPress, k = numT, method = "Gibbs", control = list(seed = 1234))

ap_topics <- tidy(mLDA, matrix = "gamma")
ap_topics
}

LDA_OPTIMIZED <- function(){
res<-ga(type = "real-valued", fitness = fitness_LDA, lower=lower_bounds, upper=upper_bounds, pmutation=1/4, maxiter=n_iterations, run=n_iterations, popSize=pop_size, mutation=gareal_raMutation, crossover = gareal_blxCrossover)
best <- summary(res)
return(best$solution)
}

switchV <- readline(prompt="Select 1 for LDA_DEFAULT and 2 for LDA_OPTIMIZED: ")

switch(switchV,LDAdefault(),LDA_OPTIMIZED())

