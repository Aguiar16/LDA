require(tidytext)
require(topicmodels)
require(dplyr)
require(tm)
require(GA)
library(XML)
library(jsonlite)
library(slam)
library(igraph)
library(stringr)
library(cluster)
library(snakecase)
library(stopwords)
library(NMOF)
library(xtable)
source("./fitness_function.R")

corpusMatrix <- readr::read_csv("./corpus/DatasetPreparado.csv")

## create the corpus with textmatrix
dtm <- tidytext::cast_dtm(corpusMatrix, document, word, n)

# 7. Apply tf-idf weighting schema
dtm2 <- weightSMART(dtm, "ntn")
dtm$v <- as.integer(round(dtm2$v))

# 8. Meta-heuristic setting
pop_size = 10
n_iterations = 5
lower_bounds <- c(5, # n. topics
                  10, # n. iterations
                  0,  # alpha
                  0   # beta
)

# print(length(dtm$dimnames$Docs))
upper_bounds <- c(0,				   # n. topics
			100,                       # n. iterations
			1,                         # alpha
			1                          # beta
)


GA <- function(){
	res<-ga(type = "real-valued", fitness = fitness_LDA,
		lower=lower_bounds, upper=upper_bounds, pmutation = 1/4,
		maxiter=n_iterations, run=n_iterations, popSize=pop_size, mutation=gareal_raMutation,
		crossover = gareal_blxCrossover)

	best <- summary(res)
	write.table(best$solution, file = "./Results/OptimizedParameters.csv", sep =',', append = TRUE, row.name = FALSE)
	return(best$solution)
}

Optimize <- function (){

	# number in independent runs

	numberOfRuns = 30
	for(t in seq(10,100,5)){
		upper_bounds <<- c(t,100,1,1)
		cat("starting the test of",t,"max topics\n")
		for (i in 1:numberOfRuns){
			#running GA
			x <- GA()
			# Compute LDA optimized
			OptimizedLDA(x)
			cat("end of",i,"th run of the MAX",t,"topics\n")
		}
	}
}


Optimize()
