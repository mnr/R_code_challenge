# linear models

# load survey data
load(file = "SurveyData.rds")

lmStar <- lm(Income ~ age, data = StarResearch)
plot(lmStar)
