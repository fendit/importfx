#' @title Import Specific User-Defined Functions from Another R Script
#'
#' @description
#' Works similar to import function from Python - user can decide which function(s)
#' should be included or excluded when importing to the environment from another R script.
#'
#' It is recommended to execute this function at the start of running current R script.
#'
#' @return User-defined functions from another R script
#' @param file Directory of R script that stores all user-defined functions.
#' @param only Functions to be imported. Default is NULL.
#' @param except Functions that are excluded when importing. Default is NULL.
#' @param envir Environment where functions are imported to.
#' @author Fendi Tsim (F.Tsim at wbs.ac.uk)
#' @importFrom utils lsf.str
#' @examples
#'\dontrun{
#' # Suppose there is a .R file (functions.R) that contains functions (foo1, foo2 and foo3):
#' file.create("functions.R")
#' writeLines(text = "foo1 <- function(){}\nfoo2 <- function(){}\nfoo3 <- function(){}",
#'            con = file("functions.R")
#' )
#' close(file("functions.R"))
#'
#' # Import all functions in functions.R
#' import(file = "functions.R")
#' ls.str()  # Print what exists in Global Environment

#' # Import specific functions via functions.R (foo1 and foo3)
#' import(file = "functions.R", only = c("foo1", "foo3"))
#' ls.str()  # Print what exists in Global Environment

#' # Import all functions in functions.R except foo1 and foo3
#' import(file = "functions.R", except = c("foo1", "foo3"))
#' ls.str()  # Print what exists in Global Environment

#' # Running the following code shows an error message as function(s) imported do not exist
#' import(file = "functions.R", only = c("foo1", "foo03"))
#' # Error: foo03 could not be found in functions.R
#'
#' ls.str()  # Print what exists in Global Environment
#' # Note: despite `foo1` is in functions.R, it is not imported in Global Environment via above command
#' }
#'
#' @aliases import
#' @aliases importfunctions
#' @export
import <- function(file="", only=NULL, except=NULL, envir= .GlobalEnv){

  objs <- ls(envir = envir) # Store functions names in envir
  source(file = file) # Import all functions via file
  foos <- if (!is.null(only)) only else if (!is.null(except)) except # List set of functions to be imported; NULL by default

  if (length(which(!foos%in%lsf.str(envir = envir)))!=0){  # Check if foos is NULL & if foos appear in envir
    for (foo in foos[which(!foos%in%ls(envir = envir))]) message(paste0("Error: ", foo, " could not be found in ", file))
    rm(list = lsf.str(envir = envir)[!ls(envir = envir)%in%objs], envir = envir)  # Wipe out all functions in envir except import
  }else{
    if (!is.null(foos)){
      foos <- which(if (!is.null(except)) ls(envir = envir)%in%foos else if (!is.null(only)) !ls(envir = envir)%in%c(foos, objs) else !ls()%in%NULL) # Keeps foos depending on arguments
      rm(list = lsf.str(envir = envir)[foos], envir = envir)
    }
  }
}
