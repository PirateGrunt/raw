#' ---
#' title: "Part 11: Intro to Generalized Linear Modeling"
#' output:
#'   slidy_presentation:
#'     duration: 45
#'     fig_height: 3
#'     fig_width: 6
#'   pdf_document:
#'     documentclass: scrartcl
#' ---
#' 
#' 
#' 
#' 
## ----echo=FALSE, results='hide'------------------------------------------
library(ggplot2)
op <- par(no.readonly = TRUE)

#' 
#' 
#' 
#' 
#' ## Load Data
## ------------------------------------------------------------------------
prem <- read.csv('c:/home/git/las2015/Data/prem.csv')
prem

#' 
#' 
#' 
#' 
#' ## LMs are also GLMs
## ------------------------------------------------------------------------
lm2  <- lm(Premium ~ log(Revenue), data = prem)
glm2 <- glm(Premium ~ log(Revenue), data = prem)

subs <- data.frame(Revenue = c(250e3, 300e3, 350e3))
predict(lm2, newdata = subs)
predict(glm2, newdata = subs)

#' 
#' 
#' 
#' 
#' ## Third Party Claims
## ------------------------------------------------------------------------
tpls <- read.csv('c:/home/git/las2015/Data/tpls.csv', stringsAsFactors = FALSE)

#' Third party insurance is a compulsory insurance for vehicle owners
#' in Australia. It insures vehicle owners against injury  caused to
#' other drivers, passengers or pedestrians, as a result of an
#' accident.
#' 
#' This data set records the number of third party claims in a
#' twelve-month period between 1984-1986 in each of 176 geographical
#' areas (local government areas) in New South Wales, Australia.
#' 
#' Variables     | Desc
#' ------------- | -------------
#' lga		        | local government area
#' sd		        | statistical division (1, ..., 13)
#' claims		    | number of third party claims
#' accidents	    | number of accidents
#' ki		        | number killed or injured
#' population	  | population size
#' pop_density	  | population density
#' 
#' 
#' 
#' ## Claims as a function of accidents
## ------------------------------------------------------------------------
par(mfrow = c(1, 2))
plot(claims ~ accidents, data = tpls)
plot(log(claims) ~ log(accidents), data = tpls)

#' 
#' 
#' 
#' 
#' ## Poisson GLM
## ------------------------------------------------------------------------
glm1 <- glm(
  claims ~ log(accidents) + offset(log(population)), 
  data = tpls, 
  family = poisson
)
summary(glm1)

#' 
#' 
#' 
#' 
#' ## What does this mean?
#' The canonical link function for the poisson is log, but you can check this.
## ------------------------------------------------------------------------
glm1$family$link

#' The fitted values are calculated from the coefficients like so
## ------------------------------------------------------------------------
glm1$coefficients
exp(log(tpls$population) + log(tpls$accidents) * 0.2591 - 7.0938)

#' Check against model
## ------------------------------------------------------------------------
glm1$fitted.values

#' 
#' 
#' 
#' ## Is the family appropriate?
#' In this case, no.  The poisson distribution has equal mean and variance.  This data does not.  In fact the "overdispersion" is quite large.
## ------------------------------------------------------------------------
mean(tpls$claims)
var(tpls$claims)

#' A negaive binomial will be more appropriate.
#' 
#' 
#' 
#' ## Negative Binomial GLM
## ------------------------------------------------------------------------
require(MASS)
glm2 <- glm.nb(
  claims ~ log(accidents) + offset(log(population)), 
  data = tpls
)
summary(glm2)

#' 
#' 
#' 
#' ## How do the diagnostic plots compare?
## ------------------------------------------------------------------------
par(mfrow = c(2, 2))
plot(glm1)

#' 
#' 
#' 
#' 
#' ## How do the diagnostic plots compare? (cont'd)
## ------------------------------------------------------------------------
par(mfrow = c(2, 2))
plot(glm2)

#' 
#' 
#' 
#' 
#' ## Exercises
#' * What happens if you add a categorical variable to your glm?
#' 
#' 
