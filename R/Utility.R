
CheckLibDir <- function(lib){
  checkPath <- paste0(lib, "/raw")
  workingPath <- checkPath[file.exists(checkPath)]
  if(length(workingPath) == 0){
    stop("The raw package was not found. Did you install it somewhere other than a 
         folder listed in your .libPaths()? Have you moved your libraries?")  
  }
  
  workingPath <- paste0(workingPath[1], "/slides/")
}
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
CopySlides <- function(SavePath, overwrite=TRUE, lib){
  
  if (missing(lib)){
    strMessage <- paste0("No library specified. Using ", .libPaths()[1], " .")
    message(strMessage)
    lib <- .libPaths()[1]
  }
  
  slidePath <- checkLibDir(lib)
  
  
  rmdFiles <- list.files(slidePath, ".Rmd", full.names=TRUE)

  if (length(rmdFiles) == 0){
    stop("No pdf slides found. Is it possible you deleted them after installing the package?")
  } 
  
  if (length(SavePath) > 1){
    message("More than one SavePath given. Only the first path will be used.")
  }
  
  couldCreateDir <- dir.create(file.path(SavePath))
  
  if (!couldCreateDir){
    stop ("Could not create the save path.")
  }
  
  file.copy(rmdFiles, SavePath, overwrite = overwrite)
  
  rmdFile <- list.files(SavePath, ".Rmd", full.names=TRUE)
  
  lapply(rmdFiles, render)
  
#   htmlFiles <- list.files(workingPath, ".pdf", full.names=TRUE)
#   
#   #if (length(htmlFiles) == 0) stop("No html slides found. Please contact package maintainer.")
#   
#   if (length(htmlFiles) != 0) file.copy(htmlFiles, SavePath, overwrite = overwrite)
#   
#   unzip(paste0(workingPath, "html.zip"), exdir=SavePath)
  
}
