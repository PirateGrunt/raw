library(rmarkdown)

rmdNames <- c("Introduction"
              , "Basics"
              , "NotSoBasics"
              , "Data"
              , "BasicProgramming")

#               , "LossReserving"
#               , "LossDistributions"
#               , "AdvancedModeling"
#               , "AdvancedVisualization"
#               , "Close")

rmdNames <- paste0("./slides/", rmdNames, ".Rmd")
pdfNames <- gsub(".Rmd", ".pdf", rmdNames)
htmlNames <- gsub(".Rmd", ".html", rmdNames)
wordNames <- gsub(".Rmd", ".docx", rmdNames)

#lapply(rmdNames, render, output_format=pdf_document())
#file.copy(pdfNames, "./inst/slides/")
#unlink(pdfNames)

lapply(rmdNames, render, output_format=word_document())
file.copy(wordNames, "./slides/word/")
#zip("./inst/slides/word.zip", wordNames, flags = "-9X")
#file.copy("./inst/slides/word.zip", "./inst/slides/")
unlink(wordNames)

lapply(rmdNames, render, output_format=slidy_presentation())
file.copy(htmlNames, "./slides/html/")
zip("./inst/slides/html.zip", htmlNames, flags = "-9X")
#file.copy("./inst/slides/word.zip", "./inst/slides/")
unlink(htmlNames)

# Not ready to use this just yet
#render("A1_FileCommands.Rmd", pdf_document())
