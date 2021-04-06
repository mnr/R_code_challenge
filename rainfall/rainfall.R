# oregon water readings: https://or.water.usgs.gov/non-usgs/bes/

# which data table should we use?
stationNumber <- 171 # Sunnyside School Rain Gage

rainfall_baseURL <- "https://or.water.usgs.gov/non-usgs/bes/"

stationName <- "sunnyside.rain"

# load the data
stationData <- read.table(file = "https://or.water.usgs.gov/non-usgs/bes/sunnyside.rain", 
                         skip = 11,
                         fill = TRUE)

# we only need columns 1 (date) and 2 (daily cumulative)
stationData <- stationData[ , c(1,2)]

# clean up the row names
colnames(stationData) <- c("Date", "Daily")

# convert column one to date format
stationData[ , 1] <- as.Date(stationData[, 1], format = "%d-%b-%Y")

# convert column 2 to inches
# Data are the number of tips of the rain gage bucket. Each tip is 0.01 inches of rainfall.
stationData[ , 2] <- as.numeric(stationData[ ,2]) * .01

# aggregate to weekly totals

# plot previous years - weekly sum, year over year. bars
# plot this year to date - weekly, as a green line
# draw a red line at 1.5 inches per week
