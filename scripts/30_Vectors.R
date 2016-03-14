## ----eval=TRUE-----------------------------------------------------------
set.seed(1234)
e  <- rnorm(100)
X1 <- 1:10

## ------------------------------------------------------------------------
pies = seq(from = 0, by = pi, length.out = 5)
i <- 1:5
year = 2000:2004

## ----echo=FALSE----------------------------------------------------------
library(rblocks)
i <- 1:5
block = make_block(i, type = 'vector')
block

## ------------------------------------------------------------------------
i = rep(pi, 100)
head(i)

## ----results='hide'------------------------------------------------------
i <- c(1, 2, 3, 4, 5)
j <- c(6, 7, 8, 9, 10)
k <- c(i, j)
l <- c(1:5, 6:10)

## ----echo=FALSE----------------------------------------------------------
i = c(1, 2, 3, 4, 5)
j = c(6, 7, 8, 9, 10)
k = c(i, j)
block_i = make_block(i, type = 'vector')
block_j = make_block(j, type = 'vector')
block_i[1:5] = "red"
block_j[1:5] = "blue"
block_k = make_block(c(block_i,block_j), type='vector')
block_k[1:5] = "red"
block_k[6:10] <- "blue"

block_i
block_j


block_k

## ------------------------------------------------------------------------
i <- 1:10
i[30] = pi
i

## ------------------------------------------------------------------------
set.seed(1234)
e <- rnorm(100)
e[1]
e[1:4]
e[c(1,3)]

## ------------------------------------------------------------------------
i = 5:9
i[c(TRUE, FALSE, FALSE, FALSE, TRUE)]
i[i > 7]
b = i > 7
b
i[b]

## ------------------------------------------------------------------------
i <- 11:20
which(i > 12)
i[which(i > 12)]

## ------------------------------------------------------------------------
months <- c("January", "February", "March", "April"
            , "May", "June", "July", "August"
            , "September", "October", "November", "December")

set.seed(1234)
mixedMonths <- sample(months)
head(mixedMonths)

## ------------------------------------------------------------------------
set.seed(1234)
lotsOfMonths <- sample(months, size = 100, replace = TRUE)
head(lotsOfMonths)

## ------------------------------------------------------------------------
set.seed(1234)
moreMonths <- months[sample(1:12, replace=TRUE, size=100)]
head(moreMonths)

# Cleaner with sample.int
set.seed(1234)
evenMoreMonths <- months[sample.int(length(months), size=100, replace=TRUE)]
head(evenMoreMonths)

## ------------------------------------------------------------------------
set.seed(1234)
x <- sample(1:10)
x
order(x)
x[order(x)]

## ----eval=FALSE----------------------------------------------------------
## B0 <- 5
## B1 <- 1.5
## 
## set.seed(1234)
## 
## e <- rnorm(N, mean = 0, sd = 1)
## X1 <- rep(seq(1,10),10)
## 
## Y <- B0 + B1 * X1 + e

## ----size='tiny'---------------------------------------------------------
vector1 = 1:10
vector2 = 1:5
scalar = 3

print(vector1 + scalar)
print(vector2 + scalar)
print(vector1 + vector2)

## ------------------------------------------------------------------------
x <- 1:10
y <- 5:15
x %in% y

## ----eval = FALSE--------------------------------------------------------
## ?union

## ------------------------------------------------------------------------
x <- 1900:1910
y <- 1905:1915
intersect(x, y)
setdiff(x, y)
setequal(x, y)
is.element(1941, y)

## ----eval=FALSE----------------------------------------------------------
## x = 1:50
## sum(x)
## mean(x)
## max(x)
## length(x)
## var(x)

## ------------------------------------------------------------------------
FirstName <- c("Richard", "James", "Ronald", "Ronald"
              , "George", "William", "William", "George"
              , "George", "Barack", "Barack")
LastName <- c("Nixon", "Carter", "Reagan", "Reagan"
              , "Bush", "Clinton", "Clinton", "Bush"
              , "Bush", "Obama", "Obama")
ElectionYear <- seq(1972, 2012, 4)

## ------------------------------------------------------------------------
LastName[order(LastName)]
ElectionYear[order(FirstName)]
ElectionYear[FirstName == 'George']
myLogical <- (FirstName == 'George') & (ElectionYear < 1996)
length(which(myLogical))
sum(myLogical)

sample(LastName, 100, replace = TRUE)

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
myList <- list()
myList$Claims <- rlnorm(100, log(10000))
myList$AccidentDate <- sample(seq.Date(as.Date('2000-01-01'), as.Date('2009-12-31'), length.out = 1000), 100)
mean(myList$Claims)

