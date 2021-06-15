# What time is it on Mars?
# https://www.giss.nasa.gov/tools/mars24/help/index.html

planets <- c("Mercury", "Venus", "Earth",
             "Mars", "Jupiter", "Saturn", 
             "Uranus","Neptune","Pluto")
lengthOfYear <- c(0.24, 0.616, 1,
                  1.88, 11.86, 29.46, 
                  84.01,164.79,248.59)
lengthOfDay <- c(58.6, 243, 1,
                 1.03, 0.41, 0.45, 
                 0.72,0.67,6.39)

YearDayPlanet <- data.frame(planets,lengthOfYear,lengthOfDay)
# YearDayPlanet now contains information about each planet

todayDate <- as.POSIXlt(Sys.time()) # earth time

# this function uses planet data to convert earth date to planet date
eachPlanetsDate <- function(thisPlanet) {
  planetYear <- as.integer(todayDate$year / as.numeric(thisPlanet["lengthOfYear"])) + 1900
  planetDays <- as.integer(todayDate$yday / as.numeric(thisPlanet["lengthOfDay"]))
  earthTime <- todayDate$hour + (todayDate$min / 60)
  lengthOfPlanetDayInHours <- as.numeric(thisPlanet["lengthOfDay"]) * 24
  percentOfPlanetDay <- round((earthTime / lengthOfPlanetDayInHours) * 100, 1)
  paste("Year:",planetYear, " - yday:",planetDays," - day:",percentOfPlanetDay,"%")
}

# apply steps through each row and returns the planet date
YearDayPlanet$Today <- apply(YearDayPlanet, 1, eachPlanetsDate)

