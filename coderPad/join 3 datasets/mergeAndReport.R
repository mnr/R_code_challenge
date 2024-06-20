load(file = "/tmp/deps/RCodeChallenge.rda")

mergeAndReport <- function() {
  # combine Acme Data
  acmeData <- merge(x = AcmeData_Demographic,
                    y = AcmeData_Survey,
                    by = "surveyID")
  
  # map Star Research columns to acmeData
  names(StarResearch) <- c("firstName", "surveyID","Income","houseColor","Age")
  StarResearch <- StarResearch[ , names(acmeData)]
  
  # combine Acme & Star
  allTheData <- rbind(acmeData, StarResearch)
  
  mydf <- by(allTheData, 
             INDICES = allTheData$houseColor, 
             FUN = function(x) {
               x[ x$Income == max(x$Income), c("firstName", "Income", "houseColor")]
             },
             simplify = TRUE)
  
  mydf <- data.frame(do.call("rbind", mydf))
  
  return(mydf)
}