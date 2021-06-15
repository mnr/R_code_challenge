# linear models

# load survey data
load(file = "RCodeChallenge.rds")

lmStar <- lm(Income ~ age, data = StarResearch)
plot(lmStar)
