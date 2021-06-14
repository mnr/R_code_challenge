# rock paper scissors lizard spock
# https://the-big-bang-theory.com/rock-paper-scissors-lizard-spock/ 

# Scissors cuts paper, 
# paper covers rock, 
# rock crushes lizard, 
# lizard poisons Spock,
# Spock smashes scissors, 
# scissors decapitates lizard, 
# lizard eats paper, 
# paper disproves Spock, 
# Spock vaporizes rock, 
# and as it always has, rock crushes scissors.

# setup game truth table --------------
rpslsNames <- c("rock","paper","scissors","lizard","spock")

rockWins = c(FALSE,FALSE,TRUE,TRUE,FALSE)
paperWins = c(TRUE,FALSE,FALSE,FALSE,TRUE)
scissorsWins = c(FALSE,TRUE,FALSE,TRUE,FALSE)
lizardWins = c(FALSE,TRUE,FALSE,FALSE,TRUE)
spockWins = c(TRUE,FALSE,TRUE,FALSE,FALSE)

rpslsWinners <- matrix(c(rockWins,paperWins,scissorsWins,lizardWins,spockWins),
                       dimnames = list(rpslsNames,rpslsNames),
                       nrow = 5,
                       byrow = TRUE)

# play the game ------------
whoWon <- c(computer = 0, user = 0)
barplot(whoWon) # place plot in view

while (TRUE) {
  computerChoice <- sample(rpslsNames, 1)
  userChoice <-
    rpslsNames[menu(rpslsNames, graphics = TRUE, title = "What do you choose? ")]
  
  if (length(userChoice) == 0)
    break
  
  print(paste("Computer chose", computerChoice, ". You chose", userChoice))
  if (computerChoice == userChoice) {
    print("It's a tie!")
  } else {
    if (rpslsWinners[computerChoice, userChoice]) {
      print("Computer wins!")
      whoWon["computer"] <- whoWon["computer"] + 1
    } else
      print ("You win!")
    whoWon["user"] <- whoWon["user"] + 1
    
  }
  barplot(whoWon)
}
