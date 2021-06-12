# wordcloud

# install.packages("wordcloud")
library(wordcloud)

# get data
source("01_02 try catch.R")
# metadata - https://population.un.org/wpp/Download/Files/4_Metadata/WPP2019_F01_LOCATIONS.XLSX


# select 
finalData <- worldPop[ worldPop$Time == 2021 & 
                         worldPop$Variant == "Medium",
                       c("Location", "PopTotal","PopDensity") ]

myColors <- colorRampPalette(c("Red","Blue"))

finalData <- finalData[order(finalData$PopDensity, decreasing = TRUE),]
finalData$thisRowColor <- myColors(nrow(finalData))

wordcloud(words=finalData$Location, finalData$PopTotal, 
          colors = finalData$thisRowColor)
