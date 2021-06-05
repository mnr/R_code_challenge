# code to build the three datasets joined by 02_03

# Names
firstNames <- read.table(file = "https://www.usna.edu/Users/cs/roche/courses/s15si335/proj1/files.php%3Ff=names.txt&downloadcode=yes")

# IDs
surveyID <- nrow(firstNames):((nrow(firstNames)*2)-1)

# Income
Income <- sample(x = c("Poverty","Low Middle","Middle","Upper Middle","Highest"),
                 prob = c(.2,.09,.5, .12,.09),
                 replace = TRUE,
                 size = nrow(firstNames))

# Color of House
houseColor <- sample(c("Orange","Indigo","Violet","Yellow","Red","Blue","Green"),
                     replace = TRUE,
                     prob = c(.1,.2,.4,.8,.4,.2,.1),
                     size = nrow(firstNames))

allData <- data.frame(firstName=firstNames$V1,surveyID,Income,houseColor)

AcmeData_Demographic <- allData[1:9000, c("firstName","surveyID")]
AcmeData_Demographic <-  allData[order(AcmeData_Demographic$firstName), c("firstName","surveyID")]

AcmeData_Survey <- allData[1:9000, c("surveyID", "Income", "houseColor")]

StarResearch <- allData[9001:nrow(firstNames), ]
names(StarResearch) <- c("Respondent","Identifier","Income","House")

save(AcmeData_Demographic,AcmeData_Survey,StarResearch, file="SurveyData.rds")
