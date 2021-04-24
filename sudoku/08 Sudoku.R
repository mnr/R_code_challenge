# solve a sudoku

# install.packages("sudoku")
library(sudoku)

fetchSudokuUK()
solveSudoku(fetchSudokuUK(), verbose = TRUE)

