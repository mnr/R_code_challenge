
# load survey data
load(file = "SurveyData.rds")

# combine Acme Data
acmeData <- merge(x = AcmeData_Demographic,
                  y = AcmeData_Survey,
                  by = "surveyID")

# map Star Research columns to acmeData
names(StarResearch) <- c("firstName", "surveyID","Income","houseColor")
StarResearch <- StarResearch[ , names(acmeData)]

# combine Acme & Star
allTheData <- rbind(acmeData, StarResearch)

# brief report
allTheData$houseColor <- factor(allTheData$houseColor)

plot(x = allTheData$houseColor, y = allTheData$Income)
