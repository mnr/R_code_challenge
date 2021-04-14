
# Obtain data -------------------------------------------------------------
# oregon water readings: https://or.water.usgs.gov/non-usgs/bes/

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
colnames(stationData) <- c("Date", "DailyRain")

# convert column one to date format
stationData[ , 1] <- as.Date(stationData[, 1], format = "%d-%b-%Y")

# convert # of tips to inches of rain
# Data are the number of tips of the rain gauge bucket. 
# Each tip is 0.01 inches of rainfall.
stationData[ , 2] <- as.numeric(stationData[ ,2]) * .01


# calculations ------------------------------------------------------------

# What week of the year does this date fall into?
stationData$weekOfYear <- strftime(stationData$Date, format = "%W")

# What year does this sample belong to?
stationData$yearOfSample <- strftime(stationData$Date, format = "%Y")

# sum of rainfall for each year/week pair
RainfallByWeek <- aggregate(stationData$DailyRain,
                                  by = list(stationData$weekOfYear, stationData$yearOfSample),
                                  FUN = sum, na.rm = TRUE)

colnames(RainfallByWeek) <- c("weekNumber","Year","inches")

# calculate average rainfall per week; historical and this year

#avg rainfall per week historical
CurrentYear <- format(Sys.Date(), "%Y")

beforeThisYear <- RainfallByWeek[ RainfallByWeek$Year < CurrentYear, ]

historical_WeeklyInchesOfRain <- aggregate(beforeThisYear$inches, 
                                           by = list(beforeThisYear$weekNumber), 
                                           FUN = mean, na.rm = TRUE)
colnames(historical_WeeklyInchesOfRain) <- c("weekNumber","inches")

# avg rainfall per week this year
thisYear_WeeklyInchesOfRain <- RainfallByWeek[ RainfallByWeek$Year == CurrentYear, c("weekNumber","inches") ]

# since we subset for one year, there will not be more than 1 week
# ...so there isn't a need to aggregate

# Plot the data -----------------------------------------------------------

# plot previous years - weekly average.
plot(historical_WeeklyInchesOfRain, 
     type = "l",
     col = "green",
     lwd = 3,
     main = "Inches of Rain by Week of Year",
     sub = paste("Station:",stationName),
     xlab = "Week of year",
     ylab = "Inches of rain",
     ylim = c(0,max(historical_WeeklyInchesOfRain$inches,thisYear_WeeklyInchesOfRain$inches)))

# plot this year to date - weekly, as a green line
lines(thisYear_WeeklyInchesOfRain, lwd = 3, col = "orange")

# draw a blue line at 1.5 inches per week
abline(h = 1.5,  col = "blue")

# Create a legend
legend(x = "topright",
       legend = c("Historical Rainfall", 
                  paste("Rainfall for", CurrentYear),
                  "1.5 inches"),
       text.col = c("green", "orange", "blue"))

# Act on the data ---------------------------------------------------------


