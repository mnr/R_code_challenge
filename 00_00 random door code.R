# build a random door code

# A door code...
# ...is easy to remember
# ...hard to guess
# ...looks like a date - YYMMDD
# ...always six digits
# ...only uses each digit (0-9) once in each code
# ...different than all preceding door codes

tryCatch(load(file="previousDoorCodes.rds"),
         error = {previousDoorCodes <- NULL}
)

candidate_split <- c(1,1)

while (length(unique(candidate_split)) != length(candidate_split)) {
  candidate_datetime <- sample(seq(as.Date('1900/01/01'), Sys.Date(), by="day"), 1)
  candidate_sixdigits <- format(candidate_datetime, format = "%y%m%d")
  if (candidate_sixdigits %in% previousDoorCodes) {
    candidate_sixdigits <- c(1,1)
  } else 
    { candidate_split <- unlist(strsplit(candidate_sixdigits, split = ""))}
}

previousDoorCodes <- c(previousDoorCodes,candidate_sixdigits)
save(previousDoorCodes, file = "previousDoorCodes.rds")

