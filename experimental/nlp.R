# natural language processing

load("RCodeChallenge.rda")

# install.packages("tm")
library(tm)

randomWordsCorpus <- Corpus(URISource("https://www.mit.edu/~ecprice/wordlist.10000"))

rw_tdm <- TermDocumentMatrix(randomWordsCorpus)
