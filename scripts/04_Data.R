## ------------------------------------------------------------------------
x <- 6
y <- 6L
z <- TRUE
typeof(x)
typeof(y)
typeof(z)
is.logical(x)
is.double(x)

## ------------------------------------------------------------------------
# Implicit conversion
w <- TRUE
x <- 4L
y <- 5.8
z <- w + x + y
typeof(z)

# Explicit conversion. Note loss of data.
as.integer(z)

## ------------------------------------------------------------------------
class(TRUE)
class(pi)
class(4L)

## ------------------------------------------------------------------------
class(1:4)

## ------------------------------------------------------------------------
x <- as.Date('2010-01-01')
class(x)
typeof(x)

## ----error=TRUE----------------------------------------------------------
x <- as.Date('06-30-2010')

## ------------------------------------------------------------------------
x <- as.Date('30-06-2010')

## ------------------------------------------------------------------------
x <- as.Date('2010-06-30')

## ------------------------------------------------------------------------
x <- Sys.Date()
y <- Sys.time()

## ------------------------------------------------------------------------
myColors <- c("Red", "Blue", "Green", "Red", "Blue", "Red")
myFactor <- factor(myColors)
typeof(myFactor)
class(myFactor)
is.character(myFactor)
is.character(myColors)

## ------------------------------------------------------------------------
# This probably won't give you what you expect
myOtherFactor <- c(myFactor, "Orange")
myOtherFactor

# And this will give you an error
myFactor[length(myFactor)+1] <- "Orange"

# Must do things in two steps
myOtherFactor <- factor(c(levels(myFactor), "Orange"))
myOtherFactor[length(myOtherFactor)+1] <- "Orange"

## ------------------------------------------------------------------------
myLogical <- TRUE
myInteger <- 1:4
myDouble <- 3.14
myCharacter <- "Hello!"

y <- myLogical + myInteger
typeof(y)
y <- myInteger + myDouble
typeof(y)

## ------------------------------------------------------------------------
myVector <- 1:100
myMatrix <- matrix(myVector, nrow=10, ncol=10)

myOtherMatrix <- myVector
dim(myOtherMatrix) <- c(10,10)

identical(myMatrix, myOtherMatrix)

## ------------------------------------------------------------------------
myMatrix <- matrix(nrow=10, ncol=10)

## ----echo=FALSE----------------------------------------------------------
library(rblocks)
block_grid(10, 10, type="matrix")

## ------------------------------------------------------------------------
dim(myMatrix) <- c(25, 4)

## ----echo=FALSE----------------------------------------------------------
block_grid(25, 4, type="matrix")

## ------------------------------------------------------------------------
myMatrix <- matrix(nrow=10, ncol=10, data = sample(1:100))
colnames(myMatrix) <- letters[1:10]
head(myMatrix, 3)
rownames(myMatrix) <- tail(letters, 10)
head(myMatrix, 3)

## ------------------------------------------------------------------------
myMatrix[2, ]
myMatrix[, 2]

## ------------------------------------------------------------------------
myMatrix[2]
myMatrix[22]

## ------------------------------------------------------------------------
sum(myMatrix)
colSums(myMatrix)
rowSums(myMatrix)
colMeans(myMatrix)

## ------------------------------------------------------------------------
x <- list()
typeof(x)
x[[1]] <- c("Hello", "there", "this", "is", "a", "list")
x[[2]] <- c(pi, exp(1))
summary(x)
str(x)

## ----echo=FALSE----------------------------------------------------------
make_block(x)

## ------------------------------------------------------------------------
y <- list()
y[[1]] <- "Lou Reed"
y[[2]] <- 45

x[[3]] <- y

## ----echo=FALSE----------------------------------------------------------
make_block(x)

## ------------------------------------------------------------------------
y[[1]] <- c("Lou Reed", "Patti Smith")
y[[2]] <- c(45, 63)

names(y) <- c("Artist", "Age")

y$Artist
y$Age

## ------------------------------------------------------------------------
myList <- list(firstVector = c(1:10)
               , secondVector = c(89, 56, 84, 298, 56)
               , thirdVector = c(7,3,5,6,2,4,2))
lapply(myList, mean)
lapply(myList, median)
lapply(myList, sum)

## ------------------------------------------------------------------------
set.seed(1234)
State = rep(c("TX", "NY", "CA"), 10)
EarnedPremium = rlnorm(length(State), meanlog = log(50000), sdlog=1)
EarnedPremium = round(EarnedPremium, -3)
Losses = EarnedPremium * runif(length(EarnedPremium), min=0.4, max = 0.9)

df = data.frame(State, EarnedPremium, Losses, stringsAsFactors=FALSE)

## ------------------------------------------------------------------------
summary(df)
str(df)

## ------------------------------------------------------------------------
names(df)
colnames(df)
length(df)
dim(df)
nrow(df)
ncol(df)

## ------------------------------------------------------------------------
head(df)
head(df, 2)
tail(df)

## ----eval=FALSE----------------------------------------------------------
## df[2,3]
## df[2]
## df[2,]
## df[2, -1]

## ----eval=FALSE----------------------------------------------------------
## df$EarnedPremium
## # Columns of a data frame may be treated as vectors
## df$EarnedPremium[3]
## df[2:4, 1:2]
## df[, "EarnedPremium"]
## df[, c("EarnedPremium", "State")]

## ------------------------------------------------------------------------
order(df$EarnedPremium)
df = df[order(df$EarnedPremium), ]

## ------------------------------------------------------------------------
df$LossRatio = df$EarnedPremium / df$Losses
df$LossRatio = 1 / df$LossRatio

## ------------------------------------------------------------------------
df$LossRatio = NULL
df = df[, 1:2]

## ----results='hide'------------------------------------------------------
dfA = df[1:10,]
dfB = df[11:20, ]
rbind(dfA, dfB)
dfC = dfA[, 1:2]
cbind(dfA, dfC)

## ----size='tiny'---------------------------------------------------------
dfRateChange = data.frame(State =c("TX", "CA", "NY"), RateChange = c(.05, -.1, .2))
df = merge(df, dfRateChange)

## ------------------------------------------------------------------------
df$LossRation = with(df, Losses / EarnedPremium)
names(df)
colnames(df)[4] = "Loss Ratio"
colnames(df)

## ------------------------------------------------------------------------
dfTX = subset(df, State == "TX")
dfBigPolicies = subset(df, EarnedPremium >= 50000)

## ------------------------------------------------------------------------
dfTX = df[df$State == "TX", ]
dfBigPolicies = df[df$EarnedPremium >= 50000, ]

## ------------------------------------------------------------------------
whichState = df$State == "TX"
dfTX = df[whichState, ]

whichEP = df$EarnedPremium >= 50000
dfBigPolicies = df[whichEP, ]

## ------------------------------------------------------------------------
sum(df$EarnedPremium)
sum(df$EarnedPremium[df$State == "TX"])

aggregate(df[,-1], list(df$State), sum)

## ----size='tiny', fig.height=5-------------------------------------------
dfByState = aggregate(df$EarnedPremium, list(df$State), sum)
colnames(dfByState) = c("State", "EarnedPremium")
barplot(dfByState$EarnedPremium, names.arg=dfByState$State, col="blue")

## ----size='tiny', fig.height=5-------------------------------------------
dotchart(dfByState$EarnedPremium, dfByState$State, pch=19)

## ----eval=FALSE----------------------------------------------------------
## myData = read.csv("SomeFile.csv")

## ----eval=FALSE----------------------------------------------------------
## library(XLConnect)
## wbk = loadWorkbook("myWorkbook.xlsx")
## df = readWorksheet(wbk, someSheet)

## ----eval=FALSE----------------------------------------------------------
## URL = "http://www.casact.org/research/reserve_data/ppauto_pos.csv"
## df = read.csv(URL, stringsAsFactors = FALSE)

## ----eval=FALSE----------------------------------------------------------
## library(XML)
## URL = "http://www.pro-football-reference.com/teams/nyj/2012_games.htm"
## games = readHTMLTable(URL, stringsAsFactors = FALSE)

## ----eval=FALSE----------------------------------------------------------
## library(RODBC)
## myChannel = odbcConnect(dsn = "MyDSN_Name")
## df = sqlQuery(myChannel, "SELECT stuff FROM myTable")

## ----eval=FALSE----------------------------------------------------------
## df = read.csv("../data/StateData.csv")

## ----eval=FALSE----------------------------------------------------------
## View(df)

## ------------------------------------------------------------------------

