#=========================================================
# Written by Brian A. Fannin
# 

# Linear parameters
B0 <- 5
B1 <- 1.5

# Generate a random set of data with a linear relationship
N <- 100
set.seed(1234)
e <- rnorm(N, mean = 0, sd = 1)
X1 <- rep(seq(1,10),10)

Y <- B0 + B1 * X1 + e

# Fit a model
myFit <- lm(Y ~ X1)

# Make predictions based on that model
yHat <- predict(myFit)