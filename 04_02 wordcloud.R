# wordcloud

# install.packages("wordcloud")
library(wordcloud)
library(readxl)


# get world population data and list of countries ----------------
source("01_02 try catch.R")
# get metada about the worldpop database
worldPopMeta <- as.data.frame(read_excel("WPP2019_F01_LOCATIONS.XLSX",
                                         sheet = "Location"))
worldPopMeta <- worldPopMeta[ worldPopMeta$...7 %in% "Country/Area", "...2"]

# subset the data to Location, PopTotal, and PopDensity --------------------
finalData <- worldPop[ worldPop$Time == 2021 & 
                         worldPop$Variant == "Medium" &
                         worldPop$Location %in% worldPopMeta,
                       c("Location", "PopTotal","PopDensity") ]

# assign colors (red to blue) Red = large pop density
myColors <- colorRampPalette(c("Red","Blue"))

finalData <- finalData[order(finalData$PopDensity, decreasing = TRUE), ]

finalData$thisRowColor <- myColors(nrow(finalData))

# create the word cloud -----------------
par(mar = c(1,1,1,1), pty="m")
wordcloud(words=finalData$Location, 
          freq=finalData$PopTotal, 
          colors = finalData$thisRowColor)
