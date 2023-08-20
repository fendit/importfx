#' @title Import Specific User-Defined Functions from Another R Script
#'
#' @description
#' Import functions from a R script based on user's preference (which function(s) are included or excluded when importing).
#'
#' @return User-defined functions from another R script
#' @param file Directory of R script that stores all user-defined functions.
#' @param only Functions to be imported. Default is `NULL`.
#' @param except Functions that are excluded when importing. Default is `NULL`.
#' @param envir Environment where functions are imported to. See 'Details'.
#' @details
#' Either `only` or `except` can contain values (names of functions to be imported or not) when importing.
#' 
#' Default value of `envir` is \code{\link[base]{parent.frame}}, which is the environment `import` was made.
#' 
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
#' import(from = "functions.R")
#' ls.str()  # Print what exists in Global Environment

#' # Import specific functions via functions.R (foo1 and foo3)
#' import(from = "functions.R", only = c("foo1", "foo3"))
#' ls.str()  # Print what exists in Global Environment

#' # Import all functions in functions.R except foo1 and foo3
#' import(from = "functions.R", except = c("foo1", "foo3"))
#' ls.str()  # Print what exists in Global Environment

#' # Running the following code shows an error message as function(s) imported do not exist
#' import(from = "functions.R", only = c("foo1", "foo03"))
#' # Error: foo03 could not be found in functions.R
#'
#' ls.str()  # Print what exists in Global Environment
#' # Note: despite `foo1` is in functions.R, it is not imported in Global Environment via above command
#' }
#'
#' @aliases import
#' @aliases importfunctions
#' @export
import <- function(from="", only=NULL, except=NULL, envir=parent.frame()){
  
  foos <- as.character(parse(file = from)) # parse functions from expression to character
  foos <- foos[grepl("function", foos)] # filter those objects that are not function
  
  if (!is.null(only) & !is.null(except)){
    stop("Either only or except can contain values when importing. Please try again.")
  }else if (is.null(only) & is.null(except)){ 
    eval(parse(text = foos), envir = envir) # Import all functions
  }else{
    ls.foos <- sapply(foos, function(x) gsub(" ", "", gsub("(<-|=).*", "", x))) # Obtain list of function names
    foos.names <- if (!is.null(only)) only else if (!is.null(except)) except # List set of functions to be imported; NULL by default
    if (length(which(!foos.names%in%ls.foos))!=0){
      errormessage <- sapply(foos.names[!foos.names%in%ls.foos], function(x) message(paste0("Error: ", x, " could not be found in ", from)))
    }else{
      import.foos <- foos[if(!is.null(only)) match(foos.names, ls.foos) else if (!is.null(except)) match(setdiff(ls.foos, foos.names), ls.foos)]
      eval(parse(text = import.foos), envir = envir)  # Import selected functions
    }
  }
}
