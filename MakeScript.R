library(knitr)
library(tools)
knit("./Part2/RPM-Part2.Rnw", "./Part2/RPM-Part2.tex")
texi2pdf("./Part2/RPM-Part2.tex", clean=TRUE, quiet=FALSE)
