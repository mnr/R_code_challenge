# import an excel file

# Build the code xlsx -----------------------------------------------------
wordlist.10000 <- read.table("C:/Users/mnr/Desktop/wordlist.10000.txt")
randomWords <- matrix(wordlist.10000$V1, nrow = 100)

# build the encode sheet
encodeThis <- "Enjoy a sunny day at the beach"

encodeThisByWord <- unlist(strsplit(encodeThis, split = " "))
codeString <- data.frame(row = NULL, col = NULL)
for (aword in encodeThisByWord) {
  wordPosn <- which(randomWords == tolower(aword), arr.ind = TRUE) 
  print(wordPosn)
  aWordDF <- data.frame(row = wordPosn[1], col = wordPosn[2])
  codeString <- rbind(codeString,wordPosn)
}


# install.packages("writexl")
library(writexl)

write_xlsx(list(words = as.data.frame(randomWords), secretCode = codeString), 
           path = "secretCode.xlsx", 
           col_names = FALSE)


# import xlsx -------------------------------------------------------------

library(readxl)

Untitled_1 <- read_excel("C:/Users/mnr/Desktop/Untitled 1.xls",
                         sheet = "Sheet1", col_names = FALSE)
