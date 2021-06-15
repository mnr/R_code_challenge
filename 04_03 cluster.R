# clustering

# load survey data
load(file = "RCodeChallenge.rds")

clusterThis <- StarResearch[ , c("Income","age")]

clusterThis <- scale(clusterThis)

SRclusters <- kmeans(clusterThis, 8)

plot(x = StarResearch$age, y = StarResearch$Income, 
     col = SRclusters$cluster)

