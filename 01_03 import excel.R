# import an excel file

# get the secret code -------------------------------------------------------------

library(readxl)

randomWords <- as.data.frame(read_excel("secretCode.xlsx", sheet = "words", col_names = FALSE))

codeString <- as.data.frame(read_excel("secretCode.xlsx", sheet = "secretCode", col_names = FALSE))

# here's the code to retrieve the secret words
getWord <- function(x) {randomWords[x[1],x[2]]}

apply(codeString, 1, getWord)

  
