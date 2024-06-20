uniqueDoorCode <- function() {
  candidateCode <- 1
  
  while (length(unique(candidateCode)) != 6) {
    candidateCode <- seq(from = as.Date('1900/01/01'), to = Sys.Date(), by="day")
    candidateCode <- sample(candidateCode, 1)
    candidateCode <- format(candidateCode, format = "%y%m%d")
    candidateCode <- strsplit(candidateCode, split = "")
    candidateCode <- unlist(candidateCode)
  }
  
  doorCode <- paste0(candidateCode, collapse = "")
  
  return(doorCode)
}