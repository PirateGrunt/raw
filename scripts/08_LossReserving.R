## ----message=FALSE-------------------------------------------------------
library(ChainLadder, verbose=FALSE)
data(RAA)

typeof(RAA)
is.matrix(RAA)

## ------------------------------------------------------------------------
RAA

## ----fig.height=4.5------------------------------------------------------
plot(RAA)

## ------------------------------------------------------------------------
plot(RAA, lattice=TRUE)

## ------------------------------------------------------------------------
results = MackChainLadder(Triangle = RAA, est.sigma="Mack")

typeof(results)
class(results)

## ------------------------------------------------------------------------
plot(results)

## ------------------------------------------------------------------------
plot(results, lattice=TRUE)

## ----warning=FALSE, message=FALSE----------------------------------------
data(MCLpaid)
data(MCLincurred)

is.matrix(MCLpaid)

MunichChainLadder(MCLpaid, MCLincurred, 
 est.sigmaP = "log-linear", 
 est.sigmaI = "log-linear", 
 tailP=FALSE, tailI=FALSE) 

## ------------------------------------------------------------------------
library(raw)
data(PPA)
head(PPA_LossDevelopment)

## ------------------------------------------------------------------------
triPPA <- ChainLadder::as.triangle(PPA_LossDevelopment
                                   , origin="AccidentYear"
                                   , dev="Lag"
                                   , value="ReportedLossPaidALAE")
head(triPPA)

## ------------------------------------------------------------------------
myClarkFit <- ClarkLDF(triPPA, maxage=Inf)

## ------------------------------------------------------------------------
plot(myClarkFit)

