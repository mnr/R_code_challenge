# create a data set

# install.packages("PlaneGeometry")
library(PlaneGeometry)

# all of these functions return distances from 5 rangefinders
# each function returns the name of the object if identity == TRUE

maxRangeX <- 100
maxRangeY <- 100

# rangefinders are located at each corner
# rangefinder #5 located at x = rangeX/2, Y = 0


# Triangle ----------------------------------------------------------------

# return the five rangefinder readings from a random triangle
returnTri <- function(sizeX = maxRangeX, sizeY = maxRangeY, identity = TRUE) {
  TriX <- sample(sizeX, 3)
  TriY <- sample(sizeY, 3)
  # draw a triangle within the observation space
  # myTriangle <- Triangle$new(A = c(sample(maxRangeX,1),sample(maxRangeY,1)),
  #              B = c(sample(maxRangeX,1),sample(maxRangeY,1)),
  #              C = c(sample(maxRangeX,1),sample(maxRangeY,1)))
  line1 <- Line$new(c(TriX[1], TriY[1]), c(TriX[2],TriY[2]))
  #line2 <- Line$new(myTriangle$B, myTriangle$C)
  #line3 <- Line$new(myTriangle$c, myTriangle$A)
}

# Quadrilateral -----------------------------------------------------------

# return the five rangefinder readings from a random quadrilateral
returnQuad <- function(sizeX = maxRangeX, sizeY = maxRangeY, identity = TRUE) {}

# Circle ------------------------------------------------------------------

# return the five rangefinder readings from a random circle
returnCircle <- function(sizeX = maxRangeX, sizeY = maxRangeY, identity = TRUE) {}