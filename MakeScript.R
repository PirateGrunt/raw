BuildDoc = function(dir, rnwName, texName){
  require(knitr)
  require(tools)
  
  setwd(dir)
  knit(rnwName, texName)
  texi2pdf(texName, clean=TRUE, quiet=FALSE)
  unlink(c("*.log", "*.nav", "*.snm", "*.toc", "*.vrb", "*.aux", "*.out", "*concordance.tex"))
}

BuildChild = function(baseDir, childDir){
  rnwName = paste0("RPM-", childDir, ".Rnw")
  texName = paste0("RPM-", childDir, ".tex")
  childDir = paste0(baseDir, childDir, "/")
  
  BuildDoc(childDir, rnwName, texName)
}

baseDir = "V:/My Documents/GitHub/RPM2014/"

BuildChild(baseDir, "PartGonzo")
BuildChild(baseDir, "Part1")
BuildChild(baseDir, "Part2")
BuildChild(baseDir, "Parent")
setwd(baseDir)
