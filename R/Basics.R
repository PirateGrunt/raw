
## ----echo=FALSE, results='hide'------------------------------------------
library(pander)


## ----eval=TRUE, echo=TRUE, size='tiny'-----------------------------------
1 + 1

pi

2*pi*4^2


## ----echo=FALSE, results='asis'------------------------------------------
df = data.frame(Operator = c("+", "-", "*", "/", "^")
                , Operation = c("Addition", "Subtraction", "Multiplication"
                                , "Division", "Exponentiation"))
myTable = pandoc.table(df)


## ----echo=FALSE, results='asis'------------------------------------------
df = data.frame(Operator = c("&", "|", "!", "==", "!=", "<", "<=", ">", ">="
                             , "xor()", "&&", "||")
                , Operation = c("and", "or", "not", "equal", "not equal"
                                , "less than", "less than or equal"
                                , "greater than", "greater than or equal"
                                , "exclusive or", "non-vector and", "non-vector or"))
myTable = pandoc.table(df)


## ------------------------------------------------------------------------
r <- 4

r + 2


## ------------------------------------------------------------------------
sqrt(4)


## ------------------------------------------------------------------------
sqrt(exp(sin(pi)))


## ----eval=FALSE----------------------------------------------------------
## ?S3groupGeneric


## ----eval=FALSE, echo=TRUE, size='tiny'----------------------------------
## ?plot
## 
## ??cluster


## ----eval=TRUE, echo=TRUE, size='tiny'-----------------------------------
getwd()


## ----eval=FALSE, results='hide', size='tiny'-----------------------------
## setwd("~/SomeNewDirectory/SomeSubfolder")


## ------------------------------------------------------------------------
N <- 100
B0 <- 5
B1 <- 1.5

set.seed(1234)

e <- rnorm(N, mean = 0, sd = 1)
X1 <- rep(seq(1,10),10)

Y <- B0 + B1 * X1 + e

myFit <- lm(Y ~ X1)


## ----eval=FALSE----------------------------------------------------------
## source("SomefileName.R")


## ----eval=FALSE----------------------------------------------------------
## # Take the ratio of loss to premium to determine the loss ratio
## 
## lossRatio <- Losses / Premium


## ----eval=FALSE----------------------------------------------------------
## # Because this is a retrospective view of
## # profitability, these losses have been
## # developed, but not trended to a future
## # point in time
## lossRatio <- Losses / Premium


