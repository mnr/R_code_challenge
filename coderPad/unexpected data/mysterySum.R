
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

mysteryMeat <- list("hello", 1, 3.14, TRUE, "")
dealWithThis(mysteryMeat)
dealWithThis(list("Mark", "Niemann-Ross", TRUE, FALSE, 12,17,1958))
dealWithThis(list("have", "plastic", 96, TRUE, "plaster", "", 32.31, "friend"))
dealWithThis(list(3, "mice", "ran", 2, FALSE, "alabama"))
dealWithThis(list("have", "plastic", 96, "plaster", TRUE, FALSE, "", 32.31, "friend"))

# "complex", "raw"
# "list", "NULL", "closure" (function), 
# "special", "builtin", "environment", 
# "S4", "symbol", "pairlist", "promise", 
# "language", "char", "...", "any", 
# "expression", "externalptr", "bytecode", "weakref"



