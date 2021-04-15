# finished code to obtain rainfall data

# Obtain data -------------------------------------------------------------

rainfall_baseURL <- "https://or.water.usgs.gov/non-usgs/bes/"

stationName <- "sunnyside.rain"

# load the data

stationData <- tryCatch(read.table(file = paste0(rainfall_baseURL,stationName), 
                    skip = 11,
                    fill = TRUE),
         error = function(c) readRDS("sunnysideStationData.rds"),
         warning = function(c) "warning",
         message = function(c) "message"
)
