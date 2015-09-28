
## ------------------------------------------------------------------------
logistic <- function(x){
  exp(x) / (1 + exp(x))
}


## ------------------------------------------------------------------------
x <- seq(-10, 10, length.out=500)
y <- logistic(x)
plot(x, y, pch=19)


## ------------------------------------------------------------------------
y2 <- logistic(-x)
y3 <- logistic(2*x + 5)

oldPars <- par(mfrow=c(3,1))
plot(x, y, pch=19)
plot(x, y2, pch=19)
plot(x, y3, pch=19)
par(oldPars)


## ------------------------------------------------------------------------
library(raw)
data(NFL)


## ------------------------------------------------------------------------
plot(jitter(NFL$TODiff)
     , jitter(NFL$Win, factor=0.5)
     , xlab="Turnover difference"
     , ylab = "Wins")


## ------------------------------------------------------------------------
fit.TODiff = glm(Win ~ TODiff, family=binomial(link="logit"), data=NFL)
summary(fit.TODiff)


## ------------------------------------------------------------------------
library(boot)
plot(jitter(NFL$TODiff), jitter(NFL$Win, factor=0.5), xlab="Turnover difference", ylab = "Wins")
curve(inv.logit(coef(fit.TODiff)[1] + coef(fit.TODiff)[2]*x), add=TRUE)
abline(h=0.5)


## ------------------------------------------------------------------------
fit.1D <- glm(Win ~ Opponent1D, family=binomial(link="logit"), data=NFL)
coef(fit.1D)
deviance(fit.1D)

fit.both <- glm(Win ~ Opponent1D + TODiff, family=binomial(link="logit"), data=NFL)
coef(fit.both)
deviance(fit.both)



## ------------------------------------------------------------------------
plot(jitter(NFL$Opponent1D), jitter(NFL$Win, factor=0.5), xlab="Opponent first downs", ylab = "Wins")
curve(inv.logit(coef(fit.1D)[1] + coef(fit.1D)[2]*x), add=TRUE)
abline(h=0.5)


## ----eval=FALSE----------------------------------------------------------
## fit.TODiff$null.deviance
## fit.TODiff$deviance
## fit.1D$deviance
## fit.both$deviance


## ----echo=FALSE----------------------------------------------------------
fit.TODiff$null.deviance
fit.TODiff$deviance
fit.1D$deviance
fit.both$deviance


