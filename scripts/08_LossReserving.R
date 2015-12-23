#' ---
#' title: "Part 8: Loss Reserving"
#' output:
#'   slidy_presentation:
#'     duration: 45
#'     fig_height: 3
#'     fig_width: 6
#'   pdf_document:
#'     documentclass: scrartcl
#' ---
#' 
## ----echo=FALSE, results='hide'------------------------------------------
# Author: Adam L. Rich
# Date:   December 5, 2014
# Description:
#
#   Reserving in R
#   
#   Adapted from content found at
#     http://opensourcesoftware.casact.org/chain-ladder
#

# Set-up environment
suppressPackageStartupMessages(library(ChainLadder))

#' 
#' 
#' 
#' ## An Introduction to the ChainLadder package
#' A package developed by Markus Gesmann, an actuary at Lloyd's, with several contributors.  From the description file:
#' 
#' > Various statistical methods and models which are
#' typically used for the estimation of outstanding claims reserves
#' in general insurance, including those to estimate the claims
#' development result as required under Solvency II.
#' 
#' 
#' 
#' 
#' ## Load some data
#' Load Sch P data from http://www.casact.org/research/index.cfm?fa=loss_reserves_data
## ------------------------------------------------------------------------
asl17g <- read.csv('http://www.casact.org/research/reserve_data/othliab_pos.csv')
names(asl17g)

#' 
#' 
#' 
#' ## Fields in asl17g
#' Field               | Description
#' ------------------- | ------------------
#' GRCODE              | NAIC company code (including insurer groups and single insurers)
#' GRNAME              | NAIC company name (including insurer groups and single insurers)
#' AccidentYear        | Accident year(1988 to 1997)
#' DevelopmentYear     | Development year (1988 to 1997)
#' DevelopmentLag      | Development year (AY-1987 + DY-1987 - 1)
#' IncurLoss_h1        | Incurred losses and allocated expenses reported at year end 
#' CumPaidLoss_h1      | Cumulative paid losses and allocated expenses at year end 
#' BulkLoss_h1         | Bulk and IBNR reserves on net losses and defense and cost containment expenses reported at year end 
#' PostedReserve97_h1  | Posted reserves in year 1997 taken from the Underwriting and Investment Exhibit - Part 2A, including net losses unpaid and unpaid loss adjustment expenses 
#' EarnedPremDIR_h1    | Premiums earned at incurral year - direct and assumed 
#' EarnedPremCeded_h1  | Premiums earned at incurral year - ceded 
#' EarnedPremNet_h1    | Premiums earned at incurral year - net 
#' Single              | 1 indicates a single entity, 0 indicates a group insurer
#' 
#' 
#' 
#' ## Recap
#' Take a moment to invesitgate the data yourself.  Some suggestions...
## ---- eval = FALSE-------------------------------------------------------
## # What GROUPs are here?
## sort(unique(asl17g$GRNAME))

#' * How many groups are there?
#' * What is a unique key on the data?  How can one prove it?
#' * How would you calculate the total premium for ASL 17 by accident year?
#' 
#' 
#' 
#' 
#' ## Answers
## ------------------------------------------------------------------------
# How many groups are there?
length(unique(asl17g$GRNAME))

# What is a unique key on the data?
nrow(asl17g)
nrow(unique(asl17g[, c('GRCODE', 'AccidentYear', 'DevelopmentYear')]))
nrow(unique(asl17g[, c('GRCODE', 'AccidentYear', 'DevelopmentLag')]))
table(asl17g[, c('AccidentYear', 'DevelopmentYear')])

# How would you calculate the total premium for ASL 17 by accident year?
aggregate(
  data = asl17g[asl17g$DevelopmentYear == 1997, ],
  EarnedPremDIR_h1 ~ AccidentYear,
  FUN = sum
)

#' What questions did you ask?
#' 
#' 
#' 
#' ## Clean up the data
#' Aggregate and clean up the data a little.
## ------------------------------------------------------------------------
asl17 <- aggregate(
  x = asl17g[, c("IncurLoss_h1", "CumPaidLoss_h1", "BulkLoss_h1", "EarnedPremDIR_h1")], 
  by = asl17g[, c('AccidentYear', 'DevelopmentYear', 'DevelopmentLag')], 
  FUN = sum
)
names(asl17)
names(asl17) <- c("AY", "DY", "Dev", "UltLoss", "PdLoss", "IBNR", "GPE")
asl17$IncLoss <- asl17$UltLoss - asl17$IBNR

#' 
#' 
#' 
#' 
#' ## Make triangles using `ChainLadder::as.triangle`
#' Origin is the row names of the triangle
#' Dev is the column names of the triangle
## ------------------------------------------------------------------------
tri.inc <- as.triangle(
  asl17[asl17$DY <= 1997, ], 
  origin = 'AY', 
  dev = 'Dev', 
  value = 'IncLoss'
)
tri.pd <- as.triangle(
  asl17[asl17$DY <= 1997, ], 
  origin = 'AY', 
  dev = 'Dev', 
  value = 'PdLoss'
)
tri.gpe <- as.triangle(
  asl17[asl17$DY <= 1997, ], 
  origin = 'AY', 
  dev = 'Dev', 
  value = 'GPE'
)
tri.os <- tri.inc - tri.pd

#' 
#' 
#' 
#' 
#' ## Investigate results
## ------------------------------------------------------------------------
tri.os

#' Etc.
#' 
#' 
#' ## Mack Chain Ladder
#' * Uses "chain ladder" methods
#' * Predicts ultimates and standard errors
#' * Several parameters to customize analysis
#' * Standard error method: http://www.actuaries.org/LIBRARY/ASTIN/vol29no2/361.pdf 
#' 
## ---- eval = FALSE-------------------------------------------------------
## MackChainLadder <- function (
##   Triangle,
##   weights = 1,
##   alpha = 1,
##   est.sigma = "log-linear",
##   tail = FALSE,
##   tail.se = NULL,
##   tail.sigma = NULL,
##   mse.method = "Mack") {...}

#' 
#' 
#' 
#' ## Parameters
#' Parameter     | Notes
#' ------------- | --------------
#' Triangle      | the cumulative loss triangle
#' alpha         | it is the ratio used in the prediction of ultimate values, alpha = 1 (default) is the chain ladder ratio, alpha = 0 is the simple average of the development ratios, and alpha = 2 is the weighted average of the development ratios
#' weights       | a triangle of weights
#' tail          | If tail = FALSE no tail factor will be applied (default), if tail=TRUE a tail factor will be estimated via a linear extrapolation of log(chainladderratios - 1), if tail is a numeric value(>1) then this value will be used instead.
#' ...           | see ?ChainLadder for others
#' 
#' 
#' 
#' ## Default example
## ------------------------------------------------------------------------
MackChainLadder(tri.inc)

#' Try `tri.pd` and `tri.gpe` yourself.
#' 
#' 
#' 
#' ## Plot works, too
## ------------------------------------------------------------------------
plot(MackChainLadder(tri.inc))

#' 
#' 
#' 
#' ## What plot shows
#' Plots six different graphs
#' 
#' 1. Mack Chain Ladder Results
#' 2. Chain ladder developments by origin period
#' 3. Standardised residuals by Fitted value
#' 4. Standardised residuals by Origin Period
#' 5. Standardised residuals by Calendar period
#' 6. Standardised residuals by Development period
#' 
#' The residual plots should be scattered with no pattern or direction for Mack's method of calculating the standard error to apply.  Patterns could be a result of a trend that should be 
#' investigated further. For more information see http://www.casact.org/pubs/proceed/proceed00/00245.pdf.
#' 
#' 
#' 
#' ## Plot a triangle
## ------------------------------------------------------------------------
plot(tri.inc)

#' 
#' 
#' 
#' ## Different Ratios
## ------------------------------------------------------------------------
MackChainLadder(tri.inc, alpha = 0)$f   # Simple average of the dev ratios
MackChainLadder(tri.inc, alpha = 1)$f   # Chain Ladder ratio ("loss wtd average")
MackChainLadder(tri.inc, alpha = 2)$f   # Wtd Average of the dev ratios

#' 
#' 
#' 
#' 
#' ## Different Tails
## ------------------------------------------------------------------------
MackChainLadder(tri.inc)$tail
MackChainLadder(tri.inc, tail = 1.1)$tail
MackChainLadder(tri.inc, tail = TRUE)$tail

#' 
#' 
#' 
#' ## Use weights to remove points from development
## ------------------------------------------------------------------------
w <- matrix(1, nrow = 10, ncol = 10)
w[3, 4] <- 0

MackChainLadder(tri.inc)
MackChainLadder(tri.inc, weights = w)

#' 
#' 
#' 
#' ## Munich Chain Ladder
#' * Uses paid and incurred triangles to predict ultimates
#' * For details see http://www.variancejournal.org/issues/02-02/266.pdf
#' 
## ---- eval=FALSE---------------------------------------------------------
## MunichChainLadder <- function(
##   Paid,
##   Incurred,
##   est.sigmaP = "log-linear",
##   est.sigmaI = "log-linear",
##   tailP = FALSE,
##   tailI = FALSE
## ) {...}

#' 
#' 
#' 
#' ## Munich Chain Ladder example
## ------------------------------------------------------------------------
MunichChainLadder(tri.pd, tri.inc)

#' 
#' 
#' 
#' ## Plot Munich Chain Ladder
## ------------------------------------------------------------------------
plot(MunichChainLadder(tri.pd, tri.inc))

#' 
#' 
#' 
## ---- echo=FALSE---------------------------------------------------------
# # BOOT CHAIN LADDER
# #   
# #   The BootChainLadder is a model that provides a predicted distribution 
# #   for the IBNR values for a claims triangle. However, this model predicts 
# #   IBNR values by a different method than the previous two models. 
# #   First, the development factors are calculated and then 
# #   they are used in a backwards recursion to predict 
# #   values for the past loss triangle. Then the predicted values 
# #   and the actual values are used to calculate Pearson residuals. 
# #   The residuals are adjusted by a formula specified in appendix 3 
# #   in the follow paper 
# #
# #     http://www.actuaries.org.uk/system/files/documents/pdf/sm0201.pdf)
# # 
# #   Using the adjusted residuals and the predicted losses from before, 
# #   the model solves for the actual losses in the Pearson formula 
# #   and forms a new loss triangle. The steps for predicting past losses 
# #   and residuals are then repeated for this new triangle. 
# #   After that, the model uses chain ladder ratios to predict 
# #   the future losses then calculates the ultimate and
# #   IBNR values like in the previous Mack model. 
# #   This cycle is performed R times, depending on the argument values in the
# #   model (default is 999 times). The IBNR for each origin period is calculated 
# #   from each triangle (the default 999) and used to form 
# #   a predictive distribution, from which summary statistics 
# #   are obtained such as mean, prediction error, and quantiles.
# #   
# #
# #
# #   BootChainLadder <- function (
# #     Triangle, 
# #     R = 999, 
# #     process.distr = c("gamma", "od.pois")
# #
# #   Triangle        Data
# #   R               the number of bootstraps(the default is 999)
# #   process.distr   or the way the process error is calculated for each 
# #                   predicted IBNR values with the options of
# #                   "gamma"(default) and 
# #                   "od.pois" (over dispersed Poisson)
# #
# 
# BootChainLadder(tri.inc)
# 
# 
# # The output has some of the same values as the Munich and Mack models did.
# # The Mean and SD IBNR is the average and the standard deviation 
# # of the predictive distribution of the IBNRs for each origin year
# 
# # The output also gives the 75% and 95% quantiles of 
# # the predictive distribution of IBNRs, in other words 95% or 75% of
# # the predicted IBNRs lie at or below the given values.
# 


