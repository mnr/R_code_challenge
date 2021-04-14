# bits i don't need


# create a column containing n-day running average
nDays <- 5

# %in% covered in https://www.linkedin.com/learning/r-for-data-science-lunchbreak-lessons/sets-equal-and-in
giveRunningMean <- function(lastDayOfAverage) {
  return(mean(stationData[stationData$Date %in% seq(lastDayOfAverage-nDays+1, by = "day", length.out = 5),"Daily"]))
}

# as seen in https://www.linkedin.com/learning/r-for-data-science-lunchbreak-lessons/apply-and-lapply
stationData$RunningAverage <- lapply(stationData$Date,giveRunningMean)


# need to know what week each day belongs to
# as covered in https://www.linkedin.com/learning/r-programming-in-data-science-dates-and-times/create-sequences-of-dates-cut-dates-and-round-dates
stationData$weekOf <- cut.Date(stationData$Date, 
                               breaks = "week", 
                               start.on.monday = FALSE)

# or a simpler solution with week of year

thisYear_WeeklyInchesOfRain <- aggregate(ThisYear$inches, 
                                         by = list(ThisYear$weekNumber), 
                                         FUN = mean, na.rm = TRUE)
