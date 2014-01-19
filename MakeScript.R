library(knitr)
library(tools)

setwd("V:/My Documents/GitHub/RPM2014/")

# Utilities to make child documents
BuildChild = function(childDir){
  require(knitr)
  require(tools)
  setwd(paste0("V:/My Documents/GitHub/RPM2014/", childDir, "/"))
  rnwName = paste0("RPM-", childDir, ".Rnw")
  texName = paste0("RPM-", childDir, ".tex")
  knit(rnwName, texName)
  texi2pdf(texName, clean=TRUE, quiet=FALSE)
  #unlink(c("*.log", "*.nav", "*.snm", "*.toc", "*.vrb", "*concordance.tex"))
  unlink(c("*.log", "*.nav", "*.snm", "*.toc", "*.vrb", "*.aux", "*.out"))
  setwd("V:/My Documents/GitHub/RPM2014/")
}

BuildChild("Part2x")

