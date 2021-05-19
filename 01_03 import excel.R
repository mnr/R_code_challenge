# import an excel file

# Build the code xlsx -----------------------------------------------------
wordlist.10000 <- read.table("C:/Users/mnr/Desktop/wordlist.10000.txt")
randomWords <- matrix(wordlist.10000$V1, nrow = 100)

# install.packages("writexl")
library(writexl)

write_xlsx(list(as.data.frame(randomWords)), path = "secretCode.xlsx", 
           col_names = FALSE)


# import xlsx -------------------------------------------------------------

library(readxl)

Untitled_1 <- read_excel("C:/Users/mnr/Desktop/Untitled 1.xls",
                         sheet = "Sheet1", col_names = FALSE)
