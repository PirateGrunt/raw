library(rmarkdown)

outDirs <- c("handouts", "word", "html", "beamer", "pdf")
lapply(outDirs, function(x) {
  dirName <- paste0("./workshop/", x, "/")
  if(!file.exists(dirName)) dir.create(dirName)
})

slides <- c("Introduction"
            , "Basics"
            , "Visualization"
            , "Vectors"
            , "Packages"
            , "BasicProgramming"
            , "Data"
            , "LossReserving"
            , "Simulation"
            , "LossDistributions"
            , "AdvancedModeling"
            , "AdvancedVisualization"
            , "Close")

rmdSlides <- paste0("./workshop/", slides, ".Rmd")
pdfSlides <- gsub(".Rmd", ".pdf", rmdSlides)
htmlSlides <- gsub(".Rmd", ".html", rmdSlides)
#htmlSlides <- paste0("./workshop/html/", slides, ".html")
wordSlides <- gsub(".Rmd", ".docx", rmdSlides)

lapply(rmdSlides, render, output_format=slidy_presentation(), output_dir="./html")
if(file.exists("./inst/workshop/html.zip")) unlink("./inst/workshop/html.zip")
zip("./inst/workshop/html.zip", htmlSlides, flags = "-j9X")
#file.copy(htmlSlides, "./workshop/html/", overwrite=TRUE)
unlink(htmlSlides)

lapply(rmdSlides, render, output_format=pdf_document(), output_dir="./pdf")
if(file.exists("./inst/workshop/pdf.zip")) unlink("./inst/workshop/pdf.zip")
zip("./inst/workshop/pdf.zip", htmlSlides, flags = "-j9X")
unlink(pdfSlides)

lapply(rmdSlides, render, output_format=word_document())
file.copy(wordSlides, "./workshop/word/")
#zip("./inst/workshop/word.zip", wordSlides, flags = "-9X")
#file.copy("./inst/workshop/word.zip", "./inst/workshop/")
unlink(wordSlides)

handouts <- c("A1_FileCommands"
              , "A2_VectorsAndLists")

handouts <- paste0("./workshop/", handouts, ".Rmd")
lapply(handouts, render, output_format=pdf_document())
handouts <- gsub(".Rmd", ".pdf", handouts)
file.copy(handouts, "./workshop/handouts/")
oldwd <- setwd("./workshop/handouts/")
handouts <- gsub("./workshop/", "", handouts)
zip("handouts.zip", handouts)
setwd(oldwd)
