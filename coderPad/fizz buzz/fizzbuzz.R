# fizz buzz

# print numbers from 1 to 100
# fizz when a multiple of 3
# buzz when a multiple of 5
# fizzBuzz when divisible by 3 and 5

fizzBuzz <- function(fizz, buzz) {
  numbers <- 1:100
  # ...because vectors can't mix types, and "fizz" is a character
  fizzBuzzVector <- as.character(numbers)
  names(fizzBuzzVector) <- numbers
  
  # fizz
  whichFizz <- (numbers %% fizz) == 0
  fizzBuzzVector[whichFizz] <- "fizz"
  
  # buzz
  whichBuzz <- (numbers %% buzz) == 0
  fizzBuzzVector[whichBuzz] <- "buzz"
  
  # fizzBuzz
  fizzBuzz <- fizz*buzz
  whichFB <- (numbers %% fizzBuzz) == 0
  fizzBuzzVector[whichFB] <- "fizzbuzz"
  
  return(fizzBuzzVector)
}

fb <- fizzBuzz(fizz = 3, buzz = 5)
fizzBuzz(fizz = 2, buzz = 7)
