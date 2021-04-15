# Obtain data -------------------------------------------------------------
source("01_rainfall_obtainData_complete.R")

# Clean the data ----------------------------------------------------------
# we only need columns 1 (date) and 2 (daily cumulative)
stationData <- stationData[ , c(1,2)]

# clean up the row names
colnames(stationData) <- c("Date", "DailyRain")

# convert column one to date format
stationData[ , 1] <- as.Date(stationData[, 1], format = "%d-%b-%Y")

# convert # of tips to inches of rain
# Data are the number of tips of the rain gauge bucket. 
# Each tip is 0.01 inches of rainfall.
stationData[ , 2] <- as.numeric(stationData[ ,2]) * .01

# Calculations ------------------------------------------------------------

# Plot the data -----------------------------------------------------------
