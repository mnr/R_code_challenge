# retrieve world population data
source("01_02 try catch.R")

# for this year, which countries have population densities > median
unique(worldPop[ worldPop$Time == 2021 & 
                   worldPop$PopDensity > median(worldPop$PopDensity),
                 "Location" ])
