validSolution <- matrix(data = c(0,0,0,1,0,0,0,0,
                                    1,0,0,0,0,0,0,0,
                                    0,0,0,0,1,0,0,0,
                                    0,0,0,0,0,0,0,1,
                                    0,0,0,0,0,1,0,0,
                                    0,0,1,0,0,0,0,0,
                                    0,0,0,0,0,0,1,0,
                                    0,1,0,0,0,0,0,0),
                           nrow = 8,
                           byrow = TRUE)

invalidSolution <- matrix(data = c(1,0,0,0,0,0,0,0,
                                   1,0,0,0,0,0,0,0,
                                   0,0,0,0,0,1,0,0,
                                   0,0,0,0,0,0,0,1,
                                   0,0,0,0,0,1,0,0,
                                   0,0,1,0,0,0,0,0,
                                   0,0,0,0,0,0,1,0,
                                   0,1,0,0,0,0,0,0),
                        nrow = 8,
                        byrow = TRUE)

IsThis8Queens <- function(matrixToCheck) {
  if (any(colSums(invalidSolution) > 1)) {return(FALSE)}
  if (any(rowSums(invalidSolution) > 1)) {return(FALSE)}
}