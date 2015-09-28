## ------------------------------------------------------------------------
.libPaths()
myPackages <- list.files(.libPaths()[1])
head(myPackages)

## ----eval=FALSE----------------------------------------------------------
## install.packages("ggplot2")

## ----eval=FALSE----------------------------------------------------------
## library(MRMR)

## ----eval=FALSE----------------------------------------------------------
## require(MRMR)

## ------------------------------------------------------------------------
whatsLoaded <- .packages()
whatsLoaded

## ----eval=FALSE----------------------------------------------------------
## detach("package:MRMR", unload = TRUE)

## ----eval=FALSE----------------------------------------------------------
## remove.packages("IdontWantThisAnymore")

