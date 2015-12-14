## ------------------------------------------------------------------------
library(ggplot2)
set.seed(1234)
numGroups <- 5
numClaims <- 10
N <- numClaims * numGroups
x <- rnorm(N, 1000, 300)
link <- 1.5

groupVals <- rnorm(numGroups, mean = link, sd = .05 * link)
names(groupVals) <- head(letters, numGroups)
links <- sapply(groupVals, function(x){
  rnorm(numClaims, x, sd = .3 * x)
})

group <- replicate(numClaims, names(groupVals))
group <- as.vector(t(group))

links <- as.vector(links)
df <- data.frame(Group = group
                 , Link = link
                 , SampleLink = links
                 , x = x
                 , stringsAsFactors = FALSE)

df$y <- df$x * df$SampleLink

## ------------------------------------------------------------------------
plt <- ggplot(df, aes(x, y, color = Group)) + geom_point() 
plt + stat_smooth(method = "lm", fullrange = TRUE, se = FALSE)

## ------------------------------------------------------------------------
fit1 <- lm(y ~ x + group, data = df)
summary(fit1)

## ------------------------------------------------------------------------
fit2 <- lm(y ~ 0 + x + group, data = df)
summary(fit2)

## ------------------------------------------------------------------------
fitIndividual <- lm(y ~ 0 + x:group, data = df)
summary(fitIndividual)

## ------------------------------------------------------------------------
lstSplit <- split(df, df$Group)
fits <- lapply(lstSplit, function(z){
  fit <- lm(y ~ 0 + x, data = z)
  fit
})

sapply(fits, coef)
coef(fitIndividual)

## ------------------------------------------------------------------------
library(nlme)
fitBlended <- lme(data = df, fixed = y ~ 0 + x, random = ~ 0 + x | group)
summary(fitBlended)
unlist(coef(fitBlended))
coef(fitIndividual)

## ------------------------------------------------------------------------
sum(df$y - predict(fitBlended))
sum(df$y - predict(fitIndividual))

## ------------------------------------------------------------------------
sum(df$y - link * df$x)

## ------------------------------------------------------------------------
df$IndividualPrediction <- predict(fitIndividual)
df$BlendedPrediction <- predict(fitBlended)

plt <- ggplot(df, aes(x, IndividualPrediction, color = group)) + geom_line() + geom_point(aes(y = y))
plt + geom_line(aes(y = BlendedPrediction), linetype = "dotted")

## ------------------------------------------------------------------------
fitPooled <- lm(y ~ 0 + x, data = df)
summary(fitPooled)

## ------------------------------------------------------------------------
df$PooledPrediction <- predict(fitPooled)
plt <- ggplot(df, aes(x, IndividualPrediction, color = group)) + geom_line() + geom_point(aes(y = y))
plt <- plt + geom_line(aes(y = BlendedPrediction), linetype = "dotted")
plt <- plt + geom_line(aes(y = PooledPrediction), color = "Black")
plt

## ------------------------------------------------------------------------
sampleX <- df[1, "x"]
sampleY <- df[1, "y"]
xLims <- sampleX + c(-100, 100)
xLims <- as.integer(1.5 * xLims)
pltPoisson <- ggplot(data.frame(x = xLims), aes(x)) 
pltPoisson <- pltPoisson + stat_function(fun = dpois, args = list(lambda = sampleX * 1.5))
pltPoisson <- pltPoisson + geom_vline(xintercept = sampleY, color = "red")
pltPoisson

## ------------------------------------------------------------------------
xLims <- c(0, 2)
pltPrior <- ggplot(data.frame(x = xLims), aes(x)) 
pltPrior <- pltPrior + stat_function(fun = function(x) {1/x})
pltPrior

## ------------------------------------------------------------------------
xLims <- c(0, 3)
pltPrior <- ggplot(data.frame(x = xLims), aes(x)) 
pltPrior <- pltPrior + stat_function(fun = dgamma, args = list(shape = 1, rate = 1))
pltPrior

## ------------------------------------------------------------------------
pooledLambda <- sum(df$y) / sum(df$x)

pooledAlpha <- sum(df$y)
pooledBeta <- sum(df$x) 

xLims <- c(1.4, 1.6)
pltPooled <- ggplot(data.frame(x = xLims), aes(x)) 
pltPooled <- pltPooled + stat_function(fun = dgamma, args = list(shape = pooledAlpha, rate = pooledBeta), n = 500)
pltPooled

xLims <- c(1.4, 1.6)
pltPooled <- ggplot(data.frame(x = xLims), aes(x)) 
pltPooled <- pltPooled + stat_function(fun = dgamma, args = list(shape = pooledAlpha, rate = pooledBeta), n = 500)
pltPooled

## ------------------------------------------------------------------------
alphaA <- sum(df$y[df$Group == "a"])
betaA <- sum(df$x[df$Group == "a"])
lambdaA <- alphaA / betaA

pltGroupA <- ggplot(data.frame(x = xLims), aes(x)) 
pltGroupA <- pltGroupA + stat_function(fun = dgamma
                                       , n = 500
                                       , colour = "red"
                                       , args = list(shape = pooledAlpha + alphaA, rate = pooledBeta + betaA))
pltGroupA

pltGroupA <- pltGroupA + stat_function(fun = dgamma
                                       , n = 500
                                       , colour = "black"
                                       , args = list(shape = pooledAlpha, rate = pooledBeta))
pltGroupA

## ------------------------------------------------------------------------
sampleLambda <- rgamma(1000, alphaA, betaA)
sampleX <- sample(df$x[df$Group == "a"], 1000, replace = TRUE)
sampleY <- rpois(1000, sampleLambda * sampleX)
hist(sampleY)
hist(df$y[df$Group == "a"])

## ------------------------------------------------------------------------
lstSplit <- split(df, df$Group)
groupedLambda <- sapply(lstSplit, function(z){
  lambda <- sum(z$y) / sum(z$x)
})


## ------------------------------------------------------------------------
library(raw)
data("ppauto")

