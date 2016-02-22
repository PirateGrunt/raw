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
set.seed(1234)
AY <- 2001:2010
lags <- 1:10
CY <- x
numGroups <- 5
CY_Trend <- 

x <- rnorm(N, 1000, 300)
links <- c(1.5)

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
library(raw)
data("ppauto")

