
whichMirror <- getOption("repos")

if (length(whichMirror) == 0){
  whichMirror["CRAN"] <- "http://cran.r-project.org" 
  options(repos=whichMirror)
}

actuarialPackages <- c("lubridate", "mondate", "XLConnect", "ggplot2", "ChainLadder", "actuar")

install.packages(actuarialPackages, dependencies=TRUE)
rm(whichMiror, actuarialPackages)

rawSource <- tempfile()

URL <- "https://dl.dropboxusercontent.com/u/57918578/RPM2015/raw_0.1.1.tar.gz"
download.file(URL, destfile=rawSource, method="curl")
install.packages(rawSource, repos=NULL, type="source")

unlink(rawSource)

rm(URL, rawSource)

whichJava <- Sys.which("java")

if (whichJava == "") {
  warning("You don't appear to have a Java runtime installed. Unable to install MRMR.")
} else {
  MRMR_source <- tempfile()
  
  URL2 <- "https://dl.dropboxusercontent.com/u/57918578/RPM2015/MRMR_1.0.0.tar.gz"
  download.file(URL2, destfile=MRMR_source, method="curl")
  install.packages(MRMR_source, repos=NULL, type="source")
  unlink(MRMR_source)
  rm(URL2, MRMR_source)  
}

rm(whichJava)
