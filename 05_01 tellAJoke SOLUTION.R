# Challenge: Tell a joke with interactive prompts
# Difficulty: 3

# Get a joke from the official joke api
# use cowsay to display the joke
# use R built-in interface tools

#install.packages("curl")
library(curl)

#install.packages("cowsay")
library(cowsay)

#install.packages("jsonlite")
library(jsonlite)

# use one of these URLs. Sometimes these servers go 500 - if so, try another.
jokeURL <- "https://official-joke-api.appspot.com/jokes/programming/random"
jokeURL <- "https://karljoke.herokuapp.com/jokes/programming/random"


while(askYesNo(msg = "Do you want to read a joke?")) {
  aJoke <- tryCatch(
    fromJSON(jokeURL),
    error = function(e) {
      message(paste("Error:", e))
    }
  )
  
  cat("\014")
  say(what = aJoke["setup"], by = "random")
  
  if (askYesNo(msg = "Do you want to know the answer?")) {
    cat("\014")
    say(what = aJoke["punchline"], by="random")
  } else {
    print("Good choice. It wasn't that funny anyhow")
  }
}
