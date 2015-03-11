
## ------------------------------------------------------------------------
plot(function(x) dnorm(x), -3, 3, ylab="Normal f(x)")


## ------------------------------------------------------------------------
oldpar = par(mfrow = c(2,1))
plot(function(x) dexp(x), 0, 10, ylab="Exp f(x)")
plot(function(x) dlnorm(x), 0, 10, ylab="LN f(x)")
par(oldpar)


## ------------------------------------------------------------------------
oldpar = par(mfrow = c(3,1))
plot(function(x) pnorm(x), -3, 3, ylab="Normal F(x)")
plot(function(x) pexp(x), 0, 10, ylab="Exp F(x)")
plot(function(x) plnorm(x), 0, 10, ylab="LN F(x)")
par(oldpar)


## ------------------------------------------------------------------------
oldpar = par(mfrow = c(1,2))
plot(function(x) dlnorm(x), 0, 10, ylab="f(x)")
plot(function(x) plnorm(x), 0, 10, ylab="F(x)")


## ----eval=TRUE-----------------------------------------------------------
oldpar = par(mfrow = c(3,1))
hist(rnorm(200))
hist(rexp(200))
hist(rlnorm(200))
par(oldpar)


## ------------------------------------------------------------------------
oldpar = par(mfrow = c(3,1))
set.seed(1234)
hist(rnorm(200, mean=0, sd=1), xlim=c(-10, 10), breaks=10)
hist(rnorm(200, mean=0, sd=4), xlim=c(-10, 10), breaks=10)
hist(rnorm(200, mean=5, sd=2), xlim=c(-10, 10), breaks=10)
par(oldpar)


## ------------------------------------------------------------------------
set.seed(1234)
sample(1:100, 10)


## ------------------------------------------------------------------------
sample(1:3, prob=c(1,1,100), replace=TRUE)


## ------------------------------------------------------------------------
set.seed(1234)
letters[sample(length(letters))]


## ------------------------------------------------------------------------
class <- c("A", "B", "C", "D")
freq <- 1 / 1e5
exposure <- 1e6 * c(35, 40, 55, 20)
meanSeverity <- c(8, 7, 12, 10)
set.seed(1234)
numClaims <- rpois(length(exposure), exposure * freq)
dfClass <- data.frame(class, exposure, meanSeverity = exp(meanSeverity), numClaims)

severity <- lapply(numClaims, rlnorm, meanlog=meanSeverity)
class <- rep(class, numClaims)
dfClaims <- data.frame(class, severity = unlist(severity))


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

