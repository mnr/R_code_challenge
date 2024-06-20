RocPapSciLizSpo <- c("rock","paper","scissors","lizard","spock")

whoWon <- function(player1, player2) {
  # create a truth table for the game
  
  rockWins = c(FALSE,FALSE,TRUE,TRUE,FALSE)
  paperWins = c(TRUE,FALSE,FALSE,FALSE,TRUE)
  scissorsWins = c(FALSE,TRUE,FALSE,TRUE,FALSE)
  lizardWins = c(FALSE,TRUE,FALSE,FALSE,TRUE)
  spockWins = c(TRUE,FALSE,TRUE,FALSE,FALSE)
  
  rpslsWinners <- matrix(c(rockWins,paperWins,scissorsWins,lizardWins,spockWins),
                         dimnames = list(RocPapSciLizSpo,RocPapSciLizSpo),
                         nrow = 5,
                         byrow = TRUE)
  
  player1_Int <- which(RocPapSciLizSpo == player1)
  if (player1_Int == 0) warning("Player One is an invalid choice")
  player2_Int <- which(RocPapSciLizSpo == player2)
  if (player2_Int == 0) warning("Player Two is an invalid choice")
  
  
  if (player1_Int == player2_Int) {
    theWinner <- 0
  } else if (rpslsWinners[player1_Int, player2_Int]) {
    theWinner <- 1
  } else theWinner <- 2
  
  return(theWinner)
}
