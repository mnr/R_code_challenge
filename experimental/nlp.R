# natural language processing

load("RCodeChallenge.rds")

# install.packages("tm")
library(tm)

randomWordsCorpus <- Corpus(URISource("https://www.mit.edu/~ecprice/wordlist.10000"))

rw_tdm <- TermDocumentMatrix(randomWordsCorpus)
