# Obtain data -------------------------------------------------------------
# source("01_rainfall_obtainData_complete.R")

# Clean the data ----------------------------------------------------------
# source("02_rainfall_cleanData_complete.R")

# Calculations ------------------------------------------------------------
source("03_rainfall_calculations_complete.R")

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

