## ------------------------------------------------------------------------
source("../scripts/BasicScript.R")
plot(X1, Y, pch=19)

## ------------------------------------------------------------------------
plot(X1, Y, pch=19)
lines(X1, yHat)

## ----fig.height=4.5------------------------------------------------------
hist(e)

## ----fig.height=4.5------------------------------------------------------
plot(density(e))

## ----fig.height=4.5------------------------------------------------------
boxplot(e, pch=19)

## ----fig.height=4.5------------------------------------------------------
plot(Y ~ X1, pch=19)

## ----fig.height=4.5------------------------------------------------------
colors = ifelse(abs(e) > 1.0, "red", "black")
plot(Y ~ X1, pch=19, col=colors)

## ----fig.height=4.5------------------------------------------------------
plot(Y ~ X1, pch=19)
lines(X1, yHat, lwd=2)
lines(X1, yHat+1, lty="dotted", lwd=0.5)
lines(X1, yHat-1, lty="dotted", lwd=0.5)

## ------------------------------------------------------------------------
library(raw)
data(COTOR2)
hist(COTOR2)
boxplot(COTOR2)
plot(density(COTOR2))
plot(density(log(COTOR2)))
hist(log(COTOR2))
hist(COTOR2, breaks=80)

