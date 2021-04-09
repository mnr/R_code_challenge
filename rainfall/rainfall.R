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

# convert # of tips to inches of rain
# Data are the number of tips of the rain gauge bucket. 
# Each tip is 0.01 inches of rainfall.
stationData[ , 2] <- as.numeric(stationData[ ,2]) * .01

# create a column containing n-day running average
nDays <- 5

# %in% covered in https://www.linkedin.com/learning/r-for-data-science-lunchbreak-lessons/sets-equal-and-in
giveRunningMean <- function(lastDayOfAverage) {
  return(mean(stationData[stationData$Date %in% seq(lastDayOfAverage-nDays+1, by = "day", length.out = 5),"Daily"]))
}

# as seen in https://www.linkedin.com/learning/r-for-data-science-lunchbreak-lessons/apply-and-lapply
stationData$RunningAverage <- lapply(stationData$Date,giveRunningMean)

# Plot the data -----------------------------------------------------------

# plot previous years - weekly sum, year over year.

# need to know what week each day belongs to
# as covered in https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/create-sequences-of-dates-cut-dates-and-round-dates
stationData$weekOf <- cut.Date(stationData$Date, 
                               breaks = "week", 
                               start.on.monday = FALSE)

# or a simpler solution with week of year
stationData$weekOfYear <- strftime(stationData$Date, format = "%W")

boxplot()

# plot this year to date - weekly, as a green line
# draw a red line at 1.5 inches per week


# Act on the data ---------------------------------------------------------


