# oregon water readings: https://or.water.usgs.gov/non-usgs/bes/

# Obtain data -------------------------------------------------------------

# which data table should we use?
stationNumber <- 171 # Sunnyside School Rain Gage

rainfall_baseURL <- "https://or.water.usgs.gov/non-usgs/bes/"

stationName <- "sunnyside.rain"
#stationName <- "airport_way.rain"

# load the data
stationData <- read.table(file = paste0(rainfall_baseURL,stationName), 
                         skip = 11,
                         fill = TRUE)

# Clean the data ----------------------------------------------------------

# we only need columns 1 (date) and 2 (daily cumulative)
stationData <- stationData[ , c(1,2)]

# clean up the row names
colnames(stationData) <- c("Date", "Daily")

# convert column one to date format
stationData[ , 1] <- as.Date(stationData[, 1], format = "%d-%b-%Y")

# convert column 2 to inches of rain
# Data are the number of tips of the rain gage bucket. 
# Each tip is 0.01 inches of rainfall.
stationData[ , 2] <- as.numeric(stationData[ ,2]) * .01

# create a column containing n-day running average
nDays <- 5

giveMeFiveAvg <- function(lastOfFiveDays) {
  return(mean(stationData[stationData$Date %in% seq(lastOfFiveDays-nDays+1, by = "day", length.out = 5),"Daily"]))
}

stationData$RunningAverage <- lapply(stationData$Date,giveMeFiveAvg)

# Plot the data -----------------------------------------------------------

# plot previous years - weekly sum, year over year. bars
# plot this year to date - weekly, as a green line
# draw a red line at 1.5 inches per week


# Act on the data ---------------------------------------------------------


