# import an excel file

# see 02_01 for code to build the encoder

# Build the code xlsx -----------------------------------------------------
wordlist.10000 <- read.table("C:/Users/mnr/Desktop/wordlist.10000.txt")
randomWords <- matrix(wordlist.10000$V1, nrow = 100)



# get the secret code -------------------------------------------------------------

library(readxl)

randomWords <- as.data.frame(read_excel("secretCode.xlsx", sheet = "words", col_names = FALSE))

codeString <- as.data.frame(read_excel("secretCode.xlsx", sheet = "secretCode", col_names = FALSE))

# a test of subsetting into randomWords
randomWords[32,31] # = "enjoy"

# here's the code to retrieve the secret words
getWord <- function(x) {randomWords[x[1],x[2]]}

apply(codeString, 1, getWord)

  
