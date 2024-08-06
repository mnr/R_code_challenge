# the function ---------

#' Title
#'
#' @param startState (string) name of the state where the journey starts
#' @param startCity (string) name of the city where the journey starts
#' @param endState (string) name of the state where the journey ends
#' @param endCity (string) name of the city where the journey ends
#' @param mileage (integer) actual distance traveled
#'
#' @return (list) either a list of one element containing the word "direct" or a sequence of cities and mileages 
#' @export
#'
#' @examples

findTheMidCity <- function(startState, startCity, endState, endCity, mileage) {
  # build data.frame of starting cities
  onlyStarts <- cityStateDist[(cityStateDist$stateFrom == startState) &
                                (cityStateDist$cityFrom == startCity) &
                                (cityStateDist$mi_to_place <= mileage), ]
  names(onlyStarts) <- c("startMi", "startState", "startCity","midState","midCity")
  # build data.frame of ending cities
  onlyEnds <- cityStateDist[(cityStateDist$stateTo == endState) &
                              (cityStateDist$cityTo == endCity) &
                              (cityStateDist$mi_to_place <= mileage), ]
  names(onlyEnds) <- c("midMi", "midState", "midCity","endState","endCity")
  # merge them on the middle cities
  allStartsAndEnds <- merge(x = onlyStarts,
                            y = onlyEnds,
                            by.x = "midCity",
                            by.y = "midCity")
  allStartsAndEnds <- allStartsAndEnds[ , c("startState","startCity","startMi","midState.x","midCity","midMi","endState","endCity")]
  names(allStartsAndEnds) <-  c("startState","startCity","startMi","midState","midCity","midMi","endState","endCity")
  
  # filter for destination
  possibleRoutes <- allStartsAndEnds[allStartsAndEnds$startMi + 
                                       allStartsAndEnds$midMi == mileage,]
  
  return(possibleRoutes)
}

# for testing ---------------
startState <- "Illinois"
startCity <- "Evergreen Park village"

# 2
# Illinois, Hometown city
#6

endState <- "Illinois"
endCity <- "Calumet Park village"
mileage <- 8
# end example 1

# example 2
startState <- "Washington"
startCity <- "Vancouver city"
endState <- "Oregon"
endCity <- "St. Helens city"
mileage <- 32

# example 3
mileage <- 8
startState <- "New York"
startCity <- "Carthage village"
endState <- "New York"
endCity <- "Copenhagen village"

# example 4. Used to build resultCityList for coderPad code validator
mileage <- 32
startState <- "West Virginia"
startCity <- "New Cumberland city"
endState <- "Pennsylvania"
endCity <- "Cross Creek CDP"

load(file = "coderPad/find missing city/cityStateDist.rda")
resultCityList <- findTheMidCity(startState, startCity, endState, endCity, mileage) 

identical(resultCityList,resultCityList)
identical(resultCityList,
          findTheMidCity(startState, startCity, endState, endCity, mileage) 
)

identical(resultCityList,c("hello"))
