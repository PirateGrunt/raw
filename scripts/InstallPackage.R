rawSource <- tempfile()
MRMR_source <- tempfile()

URL1 <- "https://dl.dropboxusercontent.com/u/57918578/RPM2015/MRMR_1.0.0.tar.gz"
download.file(URL1, destfile=MRMR_source, method="curl")
install.packages(MRMR_source, repos=NULL)

URL2 <- "https://dl.dropboxusercontent.com/u/57918578/RPM2015/raw_0.1.1.tar.gz"
download.file(URL2, destfile=rawSource, method="curl")

install.packages(rawSource, repos=NULL)

unlink(rawSource)
unlink(MRMR_source)

rm(URL1, URL2, MRMR_source, rawSource)
