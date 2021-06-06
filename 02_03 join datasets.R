
# load survey data
load(file = "SurveyData.rds")

# combine Acme Data
acmeData <- merge(x = AcmeData_Demographic,
                  y = AcmeData_Survey,
                  by = "surveyID")

acmeData$surveyID <- NULL # remove surveyID column

# Rename Star Research
names(StarResearch) <- c("firstName","Income","houseColor")

# combine Acme & Star
allTheData <- rbind(acmeData, StarResearch)

# brief report
allTheData$houseColor <- factor(allTheData$houseColor)

plot(x = allTheData$houseColor, y = allTheData$Income)
