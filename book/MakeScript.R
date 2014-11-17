BuildDoc = function(dir, rnwName, texName){
  require(knitr)
  require(tools)
  
  setwd(dir)
  knit(rnwName, texName)
  texi2pdf(texName, clean=TRUE, quiet=FALSE)
  setwd(dir)
  unlink(c("*.log", "*.nav", "*.snm", "*.toc", "*.vrb", "*.aux", "*.out", "*concordance.tex"))
}

BuildChild = function(baseDir, childDir){
  rnwName = paste0("RPM-", childDir, ".Rnw")
  texName = paste0("RPM-", childDir, ".tex")
  childDir = paste0(baseDir, childDir, "/")
  
  BuildDoc(childDir, rnwName, texName)
}

baseDir = "~/Documents/Projects/IntroToRforActuaries/"

BuildChild(baseDir, "Part1")
BuildChild(baseDir, "Part2a")
BuildChild(baseDir, "Part2b")
BuildChild(baseDir, "Part3a")
BuildChild(baseDir, "Part3b")
BuildChild(baseDir, "Part4")
BuildChild(baseDir, "Part5")
BuildChild(baseDir, "Parent")
setwd(baseDir)
