# What time is it on Mars?

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

todayDate <- as.POSIXlt(Sys.time()) # each planet

# this function uses planet data to convert earth date to planet date
eachPlanetsDate <- function(thisPlanet) {
  planetYear <- as.integer(todayDate$year * as.numeric(thisPlanet["lengthOfYear"])) + 1900
  earthDays <- todayDate$yday+((todayDate$hour*60)+(todayDate$min))/(24*60*60)
  planetDays <- earthDays * as.numeric(thisPlanet["lengthOfDay"])
  paste("Year:",planetYear, "yday:",round(planetDays, 2))
}

# apply steps through each row and returns the planet date
YearDayPlanet$Today <- apply(YearDayPlanet, 1, eachPlanetsDate)

