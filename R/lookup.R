#' @title Retrieve names of all customized functions
#'
#' @description
#' List names of all customized functions in a R script.
#'
#' @return Names of all user-defined functions from another R script
#' @param file Directory of R script that stores all user-defined functions.
#' @author Fendi Tsim (F.Tsim at wbs.ac.uk)
#' @aliases look
#' @export
lookup <- function(from=""){
  foos.names <- as.character(parse(file = from)) # parse functions from expression to character
  foos.names <- foos.names[grepl("function", foos.names)] # filter those objects that are not function
  
  ls.foos <- sapply(foos.names, function(x) gsub(" ", "", gsub("(<-|=).*", "", x))) # Obtain list of function names
  foos.names <- sapply(1:length(ls.foos), function(x) writeLines(paste0(x, ". ", ls.foos[x])))  # Print list of functions by order
}