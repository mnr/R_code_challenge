# cityNames <- read.csv(file = "https://nber.org/distance/2010/sf1/place/sf12010placename.csv")
# download.file("https://nber.org/distance/2010/sf1/place/sf12010placedistance25miles.csv.zip", localDwnload)
  
load("~/Downloads/cityDistance.rda")

stateCityNames <- data.frame(cityState = paste0(sf12010placename$state,
                                                "-",
                                                sf12010placename$place),
                         sf12010placename$statename,
                         sf12010placename$placename
                         )

sf12010placedistance25miles$cityState <- paste0(sf12010placedistance25miles$state1,
                                                "-",
                                                sf12010placedistance25miles$place1)
cityStateDist <- merge(x = sf12010placedistance25miles,
                        y = stateCityNames,
                        by.x = "cityState",
                        by.y = "cityState")

cityStateDist$state1 <- NULL
cityStateDist$place1 <- NULL

colnames(cityStateDist) <- c("cityState","mi_to_place",
                              "state2","place2",
                              "stateFrom","cityFrom")

# now do to:city & state
cityStateDist$cityState <- paste0(cityStateDist$state2,
                                    "-",
                                    cityStateDist$place2)

cityStateDist <- merge(x = cityStateDist,
                        y = stateCityNames,
                        by.x = "cityState",
                        by.y = "cityState")

cityStateDist$state2 <- NULL
cityStateDist$place2 <- NULL
cityStateDist$cityState <- NULL

colnames(cityStateDist) <- c("mi_to_place",
                              "stateFrom","cityFrom",
                              "stateTo", "cityTo")

cityStateDist$mi_to_place <- ceiling(cityStateDist$mi_to_place)

save(cityStateDist, file = "cityStateDist.rda")
# this saves both cityStateDist and the version of resultCityList for testing
save(cityStateDist,resultCityList, file = "cityStateDist.rda")

