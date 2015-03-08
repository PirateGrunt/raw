tmp <- tempfile()
download.file("http://bit.ly/1B1SVmi", tmp, method="wget")
source(tmp)
unlink(tmp)
