# Challenge: Display world population to population density with a word cloud
# Difficulty: 3

# install.packages("wordcloud")
library(wordcloud)

# get world population data and list of countries ----------------
load(file = "RCodeChallenge.rds")

# assign colors (red to blue) Red = large pop density
myColors <- colorRampPalette(c("Red","Blue"))

worldPopSubSet <- worldPopSubSet[order(worldPopSubSet$PopDensity, decreasing = TRUE), ]

worldPopSubSet$thisRowColor <- myColors(nrow(worldPopSubSet))

# create the word cloud -----------------
par(mar = c(1,1,1,1), pty="m")
with(worldPopSubSet,
     wordcloud(words=Location, 
          freq=PopTotal, 
          colors = thisRowColor)
)
