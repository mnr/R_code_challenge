diagnosePassword <- function(aPassword) {
  return(c(length = nchar(aPassword) > 10,
           lowercase = grepl(pattern = "[[:lower:]]", x = aPassword ),
           uppercase = grepl(pattern = "[[:upper:]]", x = aPassword ),
           number = grepl(pattern = "[[:digit:]]", x = aPassword ),
           punctuation = grepl(pattern = "[[:punct:]]", x = aPassword ) 
  ) )
  
}