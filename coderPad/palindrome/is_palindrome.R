is.palindrome <- function(testThisWord) {
  testThisWord <- tolower(testThisWord)
  testThisWord <- gsub(" ", "", testThisWord)
  testThisWord <- gsub('[[:punct:] ]+','',testThisWord)
  forward_pal <- unlist(strsplit(testThisWord, split = ""))
  reverse_pal <- rev(forward_pal)
  return(all(reverse_pal == forward_pal))
}