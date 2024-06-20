highPopDens <- function (worldPopFile) {
  
  worldPop <- read.csv(worldPopFile)
  
  return(worldPop[ worldPop$Time == 2021 & 
                     worldPop$PopDensity > median(worldPop$PopDensity) &
                     worldPop$Variant == "Medium",
                   "Location" ]
  )
}