# retrieve world population data
source("01_02 try catch.R")

# for one selected year, 
# ...which countries have population densities > median
# Use the "Medium" variant
# Return location and popDensity

# select those countries
finalData <- worldPop[ worldPop$Time == 2021 & 
                   worldPop$PopDensity > median(worldPop$PopDensity) &
                   worldPop$Variant == "Medium",
                 c("Location", "PopDensity") ]
