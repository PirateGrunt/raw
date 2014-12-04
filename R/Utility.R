#' @name CopySlides
#' 
#' @title Copy Slides
#' 
#' @export
#' 
#' @description
#' 
#' This function will copy slides to a directory specified by the user. Note that if the directory
#' already exists, the functino will issue a warning
#' 
#' @param SavePath Character string giving the name of the location where the slides should be copied.
#' @param overwrite Boolean indicating whether to overwrite any existing files. The default for this 
#' parameter is TRUE.
#' 
CopySlides <- function(SavePath, overwrite=TRUE){
  
  dir.create(file.path(SavePath))
  
  checkPath <- paste0(.libPaths(), "/IntroToRforActuaries")
  workingPath <- checkPath[file.exists(checkPath)]
  if(length(workingPath) == 0){
    stop("The IntroToRforActuaries package was not found. Did you install it somewhere other than a 
         folder listed in your .libPaths()? Have you moved your libraries?")  
  }
  
  workingPath <- paste0(workingPath[1], "/slides/")
  
  pdfFiles <- list.files(workingPath, ".pdf", full.names=TRUE)

  #if (length(pdfFiles) == 0) stop("No pdf slides found. Please contact package maintainer.")
  
  if (length(pdfFiles) != 0) file.copy(pdfFiles, SavePath, overwrite = overwrite)
  
  htmlFiles <- list.files(workingPath, ".pdf", full.names=TRUE)
  
  #if (length(htmlFiles) == 0) stop("No html slides found. Please contact package maintainer.")
  
  if (length(htmlFiles) != 0) file.copy(htmlFiles, SavePath, overwrite = overwrite)
  
  unzip(paste0(workingPath, "html.zip"), exdir=SavePath)
  
}
