
# load survey data
load(file = "SurveyData.rds")

# combine Acme Data
acmeData <- merge(x = AcmeData_Demographic,
                  y = AcmeData_Survey,
                  by = "surveyID")

# Rename Star Research
names(StarResearch) <- c("firstName","surveyID","Income","houseColor")
StarResearch_shuffled <- StarResearch[ , names(acmeData)]

# combine Acme & Star
allTheData <- rbind(acmeData, StarResearch_shuffled)

# brief report

# Reorder income names
allTheData$Income <-  factor(allTheData$Income, levels = c("Poverty","Low Middle","Middle","Upper Middle","Highest"))

table(allTheData$Income, allTheData$houseColor)

