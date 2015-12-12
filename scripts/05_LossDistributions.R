## ----message=FALSE-------------------------------------------------------
library(actuar)
data(dental)

## ------------------------------------------------------------------------
library(MASS)
y <- fitdistr(dental, "gamma")
class(y)

## ------------------------------------------------------------------------
set.seed(8910)
years <- 2001:2010
frequency <- 1000

N <- rpois(length(years), frequency)

sevShape <- 2
sevScale <- 1000
severity <- rgamma(sum(N), sevShape, scale = sevScale)

fitGamma <- fitdistr(severity, "gamma")
fitLognormal <- fitdistr(severity, "lognormal")

## ------------------------------------------------------------------------
sampleLogMean <- fitLognormal$estimate[1]
sampleLogSd <- fitLognormal$estimate[2]

sampleShape <- fitGamma$estimate[1]
sampleRate <- fitGamma$estimate[2]

x <- seq(0, max(severity), length.out=500)
yLN <- dlnorm(x, sampleLogMean, sampleLogSd)
yGamma <- dgamma(x, sampleShape, sampleRate)

hist(severity, freq=FALSE, ylim=range(yLN, yGamma))

lines(x, yLN, col="blue")

lines(x, yGamma, col="red")

## ------------------------------------------------------------------------
probabilities = (1:(sum(N)))/(sum(N)+1)

gammaQ <- qgamma(probabilities, sampleShape, sampleRate)
plot(sort(gammaQ), sort(severity), xlab = 'Theoretical Quantiles', ylab = 'Sample Quantiles', pch=19)
abline(0,1)

## ------------------------------------------------------------------------
lnQ <- qlnorm(probabilities, sampleLogMean, sampleLogSd)
plot(sort(lnQ), sort(severity), xlab = 'Theoretical Quantiles', ylab = 'Sample Quantiles', pch=19)
abline(0,1)

## ------------------------------------------------------------------------
testGamma <- ks.test(severity, "pgamma", sampleShape, sampleRate)
testLN <- ks.test(severity, "plnorm", sampleLogMean, sampleLogSd)
testGamma2 <- ks.test(severity, "pgamma", sampleShape, 1)

## ------------------------------------------------------------------------
severity <- 10000
CV <- .3
sigma <- sqrt(log(1 + CV^2))
mu <- log(severity) - sigma^2/2
plot(function(x) dlnorm(x), mu, sigma, ylab="LN f(x)")

## ------------------------------------------------------------------------
set.seed(1234)
claims = rlnorm(100, meanlog=log(30000), sdlog=1)
hist(claims, breaks=seq(1, 500000, length.out=40))

## ------------------------------------------------------------------------
quadraticFun <- function(a, b, c){
  function(x) a*x^2 + b*x + c
}

myQuad <- quadraticFun(a=4, b=-3, c=3)
plot(myQuad, -10, 10)

## ------------------------------------------------------------------------
myResult <- optim(8, myQuad)
myResult

## ------------------------------------------------------------------------
myOtherQuad <- quadraticFun(-6, 20, -5)
plot(myOtherQuad, -10, 10)
myResult <- optim(8, myOtherQuad)
myResult <- optim(8, myOtherQuad, control = list(fnscale=-1))
