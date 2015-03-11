
## ----eval=TRUE-----------------------------------------------------------
source("../inst/scripts/BasicScript.R")
e  <- rnorm(N, mean = 0, sd = 1)
X1 <- rep(seq(1,10), 10)
Y  <- B0 + B1 * X1 + e


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
e[1]
e[1:4]
e[c(1,3)]


## ------------------------------------------------------------------------
i = 5:9
i[c(TRUE, FALSE, FALSE, FALSE, TRUE)]
i[i > 7]
b = i > 7
i[b]
b


## ------------------------------------------------------------------------
i <- 10:20
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
x <- c(sample(90:100))
x
order(x)
x[order(x)]


## ----eval=FALSE----------------------------------------------------------
## Y = B0 + B1 * X1 + e


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


## ------------------------------------------------------------------------
?union
x <- 1900:1910
y <- 1905:1915
intersect(x, y)
setdiff(x, y)
setequal(x, y)


## ----eval=FALSE----------------------------------------------------------
## x = 1:50
## sum(x)
## mean(x)
## max(x)
## length(x)


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

