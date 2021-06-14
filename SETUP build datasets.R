# code to build the three datasets joined by 02_03

# Names -----------------
firstNames <- read.table(file = "https://www.usna.edu/Users/cs/roche/courses/s15si335/proj1/files.php%3Ff=names.txt&downloadcode=yes")
lengthOfFirstNames <- nrow(firstNames)

# Passwords ---------------
#install.packages("fun")
library(fun)
Top10000Passwords <- read.table(file = "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-10000.txt")
Top10000Passwords <- Top10000Passwords$V1

badWords <- read.csv(file = "https://raw.githubusercontent.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en")
badWords <- badWords$X2g1c
badWords <- c(badWords,"shitface")

Top10000Passwords <- Top10000Passwords[!  Top10000Passwords %in% badWords]

surveyID <- NULL
for (passwordIndex in 1:lengthOfFirstNames) {
  if (rnorm(1) > 2) {
    uniqueTTP <- sample(Top10000Passwords,size = 1)
    while(uniqueTTP %in% surveyID) {    
      uniqueTTP <- sample(Top10000Passwords,size = 1)
    }
    surveyID[passwordIndex] <- uniqueTTP
  } else { surveyID[passwordIndex] <- random_password(15)}
}

# Income ---------------
# Income <- sample(x = c("Poverty","Low Middle","Middle","Upper Middle","Highest"),
#                  prob = c(.2,.09,.5, .12,.09),
#                  replace = TRUE,
#                  size = nrow(firstNames))
Income <- as.integer(rnorm(lengthOfFirstNames, mean = 68000, sd = 14500))


# Color of House ---------------
houseColor <- sample(c("Orange","Gray","Violet","Yellow","Red","Blue","Green"),
                     replace = TRUE,
                     prob = c(.1,.2,.4,.8,.4,.2,.1),
                     size = lengthOfFirstNames)

allData <- data.frame(firstName=firstNames$V1,
                      surveyID,
                      Income,
                      houseColor)

# bias Yellow & Blue income -------------
biasIncomeToColor <- function(aRow) {
  if (aRow["houseColor"] == "Yellow") {
    aRow["Income"] = as.integer(aRow["Income"]) * 1.7
  } else if (aRow["houseColor"] == "Blue") {
    aRow["Income"] = as.integer(aRow["Income"]) * .8
  } else {aRow["Income"]}
}
allData$Income <- as.numeric(apply(allData,1,FUN = biasIncomeToColor))


# Age ---------------------------------------------------------------------

# age is dependent on Income

# age ~ income from BLS data
AgeBuckets <- c(16,20,25,35,45,55,65)
IncomeBuckets <- c(26312,33280,47736,59020,59488,56680,52936)
AgeXIncome <- matrix(c(AgeBuckets,IncomeBuckets), 
                     nrow = 7,
                     dimnames = list(NULL,c("Age","Income"))
)
AgeXIncome <- AgeXIncome[order(IncomeBuckets),]

mapAgeToIncome <- function(aRow) {
  ageSlot <- AgeXIncome[which.min(abs(sort(IncomeBuckets) - as.integer(aRow["Income"]))), "Age"]
  as.integer(rnorm(1, mean = ageSlot, sd = 6))
  }

allData$Age <- apply(allData, 1, mapAgeToIncome)

# split into sub-files for join exercise ---------------
AcmeData_Demographic <- allData[1:9000, c("firstName","surveyID")]
AcmeData_Demographic <-  allData[order(AcmeData_Demographic$firstName), c("firstName","surveyID")]

AcmeData_Survey <- allData[1:9000, c("surveyID", "Income", "houseColor", "Age")]

StarResearch <- allData[9001:lengthOfFirstNames, ]
names(StarResearch) <- c("Respondent","Identifier","Income","House","age")

# world population data sets ------------------------------
worldPopURLBase <- "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/"
worldPopFile <- "WPP2019_TotalPopulationBySex.csv"
worldPopURL <- paste0(worldPopURLBase, worldPopFile)
worldPopColClasses <- c("integer","character","integer", "factor", "integer", "numeric","numeric","numeric","numeric","numeric") 

worldPop <- tryCatch(read.csv(worldPopURL,colClasses = worldPopColClasses ),
                     error = function(e) {
                       message(paste("The error is:", e))
                       read.csv(worldPopFile,colClasses = worldPopColClasses )
                     }
)


# get metada about the worldpop database
download.file(url = "https://population.un.org/wpp/Download/Files/4_Metadata/WPP2019_F01_LOCATIONS.XLSX",
              destfile = "wppMetaData.xlsx")
worldPopMeta <- as.data.frame(read_excel("WPP2019_F01_LOCATIONS.XLSX",
                                         sheet = "Location"))
worldPopMeta <- worldPopMeta[ worldPopMeta$...7 %in% "Country/Area", "...2"]

worldPopSubSet <- worldPop[ worldPop$Time == 2021 & 
                         worldPop$Variant == "Medium" &
                         worldPop$Location %in% worldPopMeta,
                       c("Location", "PopTotal","PopDensity") ]

# save to rds ------------------------

save(AcmeData_Demographic,AcmeData_Survey,StarResearch,
     worldPop, worldPopSubSet, file="RCodeChallenge.rds")

