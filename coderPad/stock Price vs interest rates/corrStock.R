# is there a correlation between stock price and interest rates

load(file = "coderPad/stock Price vs interest rates/AAPL_int.rda")

firstDate <- "2021-10-10"
lastDate <- "2021-11-10"

corrStock <- function(firstDate, lastDate) {
  AAPLandInt <- merge(x = AAPL,
                      y = interestRates,
                      by.x = "Date",
                      by.y = "date")
  
  
  AAPLIntSubset <- AAPLandInt[AAPLandInt$Date >= firstDate,]
  AAPLIntSubset <- AAPLIntSubset[AAPLIntSubset$Date <= lastDate,]
  
  return(cor(x = AAPLIntSubset$Close, 
             y = AAPLIntSubset$value,
             use = "na.or.complete") )
  
}