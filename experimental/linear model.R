# linear models

# load survey data
load(file = "RCodeChallenge.rda")

lmStar <- lm(Income ~ age, data = StarResearch)
plot(lmStar)
