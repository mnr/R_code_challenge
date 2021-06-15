# build a random door code

# A door code...
# ...is easy to remember
# ...hard to guess
# ...looks like a date - YYMMDD
# ...always six digits
# ...all digits in code are unique
# ...different than all preceding door codes

tryCatch(load(file="03_03 previousDoorCodes.rds"),
         error = {previousDoorCodes <- NULL}
)

candidate_split <- c(1,1)
candidate_sixdigits <- candidate_split

while (length(unique(candidate_split)) != 6) {
  print(paste("failed:", candidate_sixdigits))
  candidate_datetime <- sample(seq(as.Date('1900/01/01'), Sys.Date(), by="day"), 1)
  candidate_sixdigits <- format(candidate_datetime, format = "%y%m%d")
  if (candidate_sixdigits %in% previousDoorCodes) {
    candidate_split <- c(1,1)
  } else 
    { candidate_split <- unlist(strsplit(candidate_sixdigits, split = ""))}
}

print(paste("Succeed:", candidate_sixdigits))

previousDoorCodes <- c(previousDoorCodes,candidate_sixdigits)
save(previousDoorCodes, file = "03_03 previousDoorCodes.rds")

