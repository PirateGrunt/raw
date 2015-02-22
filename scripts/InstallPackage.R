rawSource <- tempfile()
MRMR_source <- tempfile()

URL1 <- "https://db.tt/72JO4AE9"
download.file(URL1, destfile=rawSource, method="curl")

URL2 <- "https://db.tt/8EfsEH9T"
download.file(URL2, destfile=MRMR_source, method="curl")

install.packages(MRMR_source, repos=NULL)
install.packages(rawSource, repos=NULL)

unlink(rawSource)
unlink(MRMR_source)
