
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


## ----results='hide'------------------------------------------------------
library(MRMR)
library(lubridate)
data(NAIC)
op = OriginPeriod(StartDate = as.Date("2001-01-01")
                  , NumPeriods = 10
                  , Period=as.period(1, "years")
                  , Type="Accident Year")
op$Moniker = paste0("AY ", year(op$StartDate))


## ----echo=TRUE, results='hide'-------------------------------------------
head(as.data.frame(op)[, 1:3])

## ----echo=FALSE, results='asis', size='huge', message=FALSE, tidy=FALSE, highlight=FALSE----
library(pander)
panderOptions("table.style", "rmarkdown")
dfDisplay = as.data.frame(op)
pander(head(dfDisplay))


## ----echo=TRUE, results='hide'-------------------------------------------
library(lubridate)
startDates = seq(as.Date("2001/01/01")
                 , as.Date("2005/12/31"), by="6 months")
op = OriginPeriod(StartDate=startDates, Period=as.period(6, "months"))

## ----echo=FALSE, results='asis', size='huge', message=FALSE, tidy=FALSE, highlight=FALSE----
panderOptions("table.style", "rmarkdown")
dfDisplay = as.data.frame(op)
pander(head(dfDisplay))


## ----echo=TRUE, results='hide'-------------------------------------------
op = OriginPeriod(seq(2001:2010))
op$Moniker = paste0("AY ", year(op$StartDate))
x = op[1]
y = op[2:3]
z = c(x, y)
y = op$StartDate
y = op$Type
y = op$Moniker[3]


## ----results='hide'------------------------------------------------------
op = OriginPeriod(StartDate = as.Date("1988-01-01")
                  , NumPeriods = 10
                  , Period=as.period(1, "year")
                  , Type="Accident Year")
companies <- unique(dfWC$Company)
smWC = StaticMeasure(OriginPeriod = op
                     , Level = list(Company=companies, Line="WC")
                     , Measure=c("DirectEP", "NetEP")
                     , Data=dfWC[dfWC$Lag == 1, ])


## ----fig.height=6--------------------------------------------------------
plot(smWC)


## ----fig.height=6--------------------------------------------------------
plot(smWC, FacetFormula=as.formula(Line+Company~Measure))


## ----fig.height=6--------------------------------------------------------
smPPA = StaticMeasure(OriginPeriod = op
                     , Level = list(Company=companies, Line="PPA")
                , Measure=c("DirectEP", "NetEP")
                , Data=dfPPA[dfPPA$Lag == 1, ])
smMulti = c(smPPA, smWC)
plot(smMulti, FacetFormula=as.formula(Company~Line))


## ------------------------------------------------------------------------
scmWC = StochasticMeasure(OriginPeriod = op
                        , Level=list(Company=companies, Line="WC")
                        , Measure = c("CumulativeIncurred", "CumulativePaid")
                        , DevPeriod = as.period(1, "year")
                        , Lags=1:10
                        , Data=dfWC
                        , OriginPeriodSort = "AccidentYear"
                        , EvaluationDates=seq.Date(as.Date("1988-12-31"), as.Date("2006-12-31"), by="1 year"))


## ----fig.height=6--------------------------------------------------------
plot(UpperTriangle(scmWC), Measure="CumulativeIncurred")


## ----fig.height=6--------------------------------------------------------
plot(UpperTriangle(scmWC), Measure="CumulativeIncurred", TimeAxis="EvaluationDate")


## ----fig.height=6--------------------------------------------------------
triWC = Triangle(smWC, scmWC, "Workers Comp Triangle")

plot(UpperTriangle(triWC)
     , Response="IncrementalPaid"
     , Predictor="PriorCumulativePaid")


## ----fig.height=6--------------------------------------------------------
plot(UpperTriangle(triWC)
     , Response="IncrementalPaid"
     , Predictor="NetEP")


## ------------------------------------------------------------------------
PaidCLPooled = 
  TriangleModel(UpperTriangle(triWC)
                , Response = "IncrementalPaid"
                , Predictor = "PriorCumulativePaid"
                , ModelType = "pooled")


## ----echo=FALSE, results='hide', message=FALSE, warning=FALSE------------
PaidCLPooled = TriangleModel(UpperTriangle(triWC)
                             , Response = "IncrementalPaid"
                             , Predictor = "PriorCumulativePaid"
                             , ModelType = "pooled")

PaidCLIndividual = TriangleModel(UpperTriangle(triWC)
                             , Response = "IncrementalPaid"
                             , Predictor = "PriorCumulativePaid"
                             , ModelType = "individual")

PaidCLBlended = TriangleModel(UpperTriangle(triWC)
                              , Response = "IncrementalPaid"
                              , Predictor = "PriorCumulativePaid"
                              , Group = "Company"
                              , ModelType = "blended")

## ----warning=FALSE, fig.height=6-----------------------------------------
PlotResiduals(PaidCLPooled)


## ----warning=FALSE, fig.height=6-----------------------------------------
PlotResiduals(PaidCLIndividual)


## ----warning=FALSE, fig.height=6-----------------------------------------
PlotResiduals(PaidCLBlended)


## ------------------------------------------------------------------------
RMSE(PaidCLPooled)
RMSE(PaidCLIndividual)
RMSE(PaidCLBlended)


## ------------------------------------------------------------------------
projPaidCLPooled = 
  TriangleProjection(PaidCLPooled
                     , AsOfDate=as.Date("2006-12-31")
                     , MaxLag=10)


## ----echo=FALSE, results='asis', eval=FALSE------------------------------
## projPaidCLIndividual = TriangleProjection(PaidCLIndividual
##                                       , AsOfDate=as.Date("2006-12-31")
##                                       , MaxLag=10)
## 
## projPaidCLBlended = TriangleProjection(PaidCLBlended
##                                       , AsOfDate=as.Date("2006-12-31")
##                                       , MaxLag=10)
## 
## df.proj1 = as.data.frame(projPaidCLPooled@Projection)
## df.proj2 = as.data.frame(projPaidCLIndividual@Projection)
## df.proj3 = as.data.frame(projPaidCLBlended@Projection)
## 
## df.actual = as.data.frame(triWC)
## companies = unique(df.actual$Company)
## df.actual = subset(df.actual, Lag == 10)
## 
## df.actual = df.actual[, c("EvaluationDate", "IncrementalPaid")]
## row.names(df.actual) = NULL
## 
## df.proj1 = df.proj1[, "IncrementalPaid"]
## df.proj2 = df.proj2[, "IncrementalPaid"]
## df.proj3 = df.proj3[, "IncrementalPaid"]
## 
## dfCompare = cbind(df.actual, df.proj1, df.proj2, df.proj3)
## names(dfCompare)[2:5] = c("Actual", "Pooled", "Individual", "Blended")
## dfCompare = subset(dfCompare, EvaluationDate > as.Date("1997-12-31"))
## 
## panderOptions("table.style", "rmarkdown")
## pander(dfCompare[1:10, ])


