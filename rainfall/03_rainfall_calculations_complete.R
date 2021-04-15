# Obtain data -------------------------------------------------------------
# source("01_rainfall_obtainData_complete.R")

# Clean the data ----------------------------------------------------------
source("02_rainfall_cleanData_complete.R")

# Calculations ------------------------------------------------------------

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

# since we subset for one year, there will not be more than 1 week of data
# ...so there isn't a need to aggregate

# Plot the data -----------------------------------------------------------
