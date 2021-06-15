install.packages("cowsay")
library(cowsay)

#install.packages("jsonlite")
library(jsonlite)

jokeURL <- "https://official-joke-api.appspot.com/jokes/programming/random"

while(askYesNo(msg = "Do you want to read a joke?")) {
  aJoke <- tryCatch(
    fromJSON(jokeURL),
    error = function(e) {
      message(paste("Error:", e))
    }
  )
  
  
  say(what = aJoke["setup"], by = "random")
  if (askYesNo(msg = "Do you want to know?")) {
    print(aJoke["punchline"])
  } else {
    print("Good choice. It wasn't that funny anyhow")
  }
}
