# Covid19 research
# https://ourworldindata.org/coronavirus

# https://github.com/owid/covid-19-data/tree/master/public/data

owid_covid <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")

# from: https://github.com/owid/covid-19-data/tree/master/public/data
# Hospitalizations and intensive care unit (ICU) admissions: our data comes from
# the European Centre for Disease Prevention and Control (ECDC) for a select
# number of European countries; the government of the United Kingdom; the
# Department of Health & Human Services for the United States; the COVID-19
# Tracker for Canada. Unfortunately, we are unable to provide data on
# hospitalizations for other countries: there is currently no global, aggregated
# database on COVID-19 hospitalization, and our team at Our World in Data does
# not have the capacity to build such a dataset.

# can we approximate this missing data?

# how bad is icu_patients?
prcentmissing <- floor(sum(is.na(owid_covid$icu_patients)) / nrow(owid_covid) * 100)
print(paste0(prcentmissing,"% of rows are missing data"))

### Create a training set ------------------
# extract rows with icu_patients != na.
owid_icu_complete <- owid_covid[!is.na(owid_covid$icu_patients), ]
# remove factor-offenses.
owid_icu_complete <- owid_icu_complete[ , c(1:30,32:33,35,38,42:46,50,52:55,57:59)]
# remove spurious fields
owid_icu_complete <- owid_icu_complete[ , -c(1,4,7,10,13,16,30,31,39,43,44,51,56)] 
# remove continent & location
owid_icu_complete <- owid_icu_complete[ , -c(1,2)] 


# we only want to train against complete cases
sum(complete.cases(owid_icu_complete))
# which columns are offenders?

# remove columns with sum(is.na)/totalRows > threshold
# returns TRUE if below threshold
removeAtThresholdNA <- function(findNA, threshold, totalRows) {
  sumOfNA <- sum(is.na(findNA))
  sumOfNA/totalRows < threshold
}

# use the above formula to remove offending columns
owid_icu_complete <- owid_icu_complete[, apply(owid_icu_complete,2,removeAtThresholdNA,.9, nrow(owid_icu_complete)) ]
# then filter for complete cases
owid_icu_complete <- owid_icu_complete[complete.cases(owid_icu_complete), ]

# build model
library(nnet)
# install.packages("neuralnet")
# library(neuralnet)
# create and train a neural network
set.seed(1)
randomSample <- sample(nrow(owid_icu_complete),nrow(owid_icu_complete)/2)
  
# icu_nnet <- nnet.formula(formula = as.formula("icu_patients ~ .") ,
#                  data = owid_icu_complete,
#                  subset = randomSample,
#                  size = 4,
#                  linout = TRUE)

icu_nnet <- neuralnet(icu_patients ~ .,
          data = owid_icu_complete,
          lifesign = "minimal",
          hidden = 15)

fivenum(owid_icu_complete$icu_patients[randomSample])
fivenum(owid_icu_complete$icu_patients[-randomSample])
fivenum(predict(icu_nnet, owid_icu_complete[-randomSample,]))

plot(data.frame(known = owid_icu_complete$icu_patients[-randomSample],
      predicted = predict(icu_nnet, owid_icu_complete[-randomSample,])
      )
)

plot(icu_nnet)

