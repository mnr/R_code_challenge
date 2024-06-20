dealWithThis <- function(mysteryMeat) {
  mysterySum <- 0
  cumulativeStrings <- c()
  
  for (valIndx in 1:length(mysteryMeat)) {
    switch (typeof(mysteryMeat[[valIndx]]),
            # plus - The sum of any numbers in the list, each of them rounded up to the nearest integer
            double = mysterySum <- mysterySum + ceiling(mysteryMeat[[valIndx]]),
            # plus - 1 if TRUE, 0 if FALSE
            logical = mysterySum <- mysterySum + mysteryMeat[[valIndx]]
            # Ignore anything else, including (but not limited to) NA
    )
    
    # plus - The average length of all (non-empty) strings
    if ((typeof(mysteryMeat[[valIndx]]) == "character") && 
        (nchar(mysteryMeat[[valIndx]]) > 0) ) { 
      cumulativeStrings <- c(cumulativeStrings, mysteryMeat[[valIndx]] )
    }
  }
  mysterySum <- mysterySum + mean(nchar(cumulativeStrings))
  
  # minus The count of any empty strings
  mysterySum <- mysterySum - sum(nchar(mysteryMeat) == 0)
  
  return(mysterySum)
}