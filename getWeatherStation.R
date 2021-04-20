# Find the weather station nearest to Sunnyside

# list of noaa weather stations
# https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt
# US1ORMT0026  45.5548 -122.5645   42.4 OR PORTLAND 4.6 ENE       
# https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_station/ASN00081060.csv.gz
# data description: https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt

Sunnyside_location <- c(stationID = "Sunnyside", Latitude = 45.5142971, Longitude = -122.6290483)

# read in ALL weather stations - 119023 stations!
noaa_weather_stations <- read.table("https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt",
                                    fill = TRUE,
                                    header = FALSE)

# subset OR and PORTLAND
PDX_noaa_weather_stations <- noaa_weather_stations[ noaa_weather_stations$V5 == "OR"
                                                    & noaa_weather_stations$V6 == "PORTLAND", c("V1", "V2", "V3")]

names(PDX_noaa_weather_stations) <- c("stationID","Latitude","Longitude")

PDX_noaa_weather_stations_sunny <- rbind(PDX_noaa_weather_stations, Sunnyside_location)
rownames(PDX_noaa_weather_stations_sunny) <- (PDX_noaa_weather_stations_sunny[,1])

# calculate distances between points
distanceToSunnyside <- as.matrix(dist(PDX_noaa_weather_stations_sunny))

# extract row "Sunnyside" but remove column "Sunnyside"
distanceToSunnyside <- distanceToSunnyside[rownames(distanceToSunnyside) %in% "Sunnyside",
                                           !colnames(distanceToSunnyside) %in% "Sunnyside"]

closestStation <- names(which.min(distanceToSunnyside))
# https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_station/ASN00081060.csv.gz

