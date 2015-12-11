require(rmarkdown)
require(knitr)



# [ALR Nov 30, 2015]
# Only use scripts and slides
outDirs <- c("scripts", "slides")
lapply(outDirs, function(x) {
  dirName <- file.path(getwd(), x)
  if(!dir.exists(dirName)) dir.create(dirName, recursive = TRUE)
  dirName
})



# [ALR Nov 30, 2015]
# Build `slides` by inspecting Rmd directory
Rmd <- dir('./Rmd', pattern = '.Rmd')
topics <- sub(pattern = '\\.Rmd$', replacement = '', x = Rmd)



# [ALR Nov 30, 2015]
#   html files go to ./slides
#   R files go to ./scripts
slides.Rmd <- file.path(getwd(), 'Rmd', paste0(topics, '.Rmd'))
slides.html <- file.path(getwd(), 'slides', paste0(topics, '.html'))
slides.R <- file.path(getwd(), 'scripts', paste0(topics, '.R'))



# [ALR Nov 30, 2015]
# OK to use for loop here
for (x in 1:length(topics)) {
  render(
    input = slides.Rmd[x],
    output_format = slidy_presentation(),
    output_file = slides.html[x],
    envir = new.env()
  )
  
  (function(){
    orig_wd <- getwd()
    on.exit(setwd(orig_wd))
    setwd('./scripts/')
    purl(slides.Rmd[x], documentation = 2L)
  })()
}



# 
# if(file.exists("./inst/workshop/html.zip")) unlink("./inst/workshop/html.zip")
# zip("./inst/slides/slides.zip", rmdSlides, flags = "-j9X")
# 
# lapply(rmdSlides, purl)
# 
# 
