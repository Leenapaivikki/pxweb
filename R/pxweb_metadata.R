#' Construct a \code{pxweb_metadata} object.
#' 
#' @description 
#' An object that contain the metadata for a given PXWEB table.
#' 
#' @param x a list returned from a PXWEB API to convert to a \code{pxweb_metadata} object.
#' 
#' @return 
#' a \code{pxweb_metadata} object
#' 
#' @keywords internal
pxweb_metadata <- function(x){
  class(x) <- c("pxweb_metadata", "list")
  checkmate::assert_names(names(x), must.include = "variables")
  for(i in seq_along(x$variables)){
    checkmate::assert_names(names(x$variables[[i]]), must.include = c("values", "valueTexts"))
    x$variables[[i]]$values <- unlist(x$variables[[i]]$values)
    x$variables[[i]]$valueTexts <- unlist(x$variables[[i]]$valueTexts)
    if(is.null(x$variables[[i]]$elimination)) x$variables[[i]]$elimination <- FALSE
    if(is.null(x$variables[[i]]$time)) x$variables[[i]]$time <- FALSE
  }
  assert_pxweb_metadata(x)
  x
}



#' Assert that x is a correct \code{pxweb_metadata} object.
#' @param x an object to check.
#' @keywords internal
assert_pxweb_metadata <- function(x){
  checkmate::assert_class(x, c("pxweb_metadata", "list"))
  checkmate::assert_names(names(x), must.include = c("title", "variables"))
  checkmate::assert_string(x$title)
  
  for(i in seq_along(x$variables)){
    checkmate::assert_names(names(x$variables[[i]]), must.include = c("code", "text", "values", "valueTexts", "elimination", "time"), .var.name = paste0("names(x$variables[[", i, "]])"))
    checkmate::assert_string(x$variables[[i]]$code, .var.name = paste0("x$variables[[", i, "]]$code"))
    checkmate::assert_string(x$variables[[i]]$text, .var.name = paste0("x$variables[[", i, "]]$text"))
    checkmate::assert_character(x$variables[[i]]$values, .var.name = paste0("x$variables[[", i, "]]$values"))
    checkmate::assert_character(x$variables[[i]]$valueTexts, len = length(unlist(x$variables[[i]]$values)) , .var.name = paste0("x$variables[[", i, "]]$valueTexts"))
    checkmate::assert_flag(x$variables[[i]]$time, .var.name = paste0("x$variables[[", i, "]]$time"))
    checkmate::assert_flag(x$variables[[i]]$elimination, .var.name = paste0("x$variables[[", i, "]]$elimination"))
  }
}


#' @export
print.pxweb_metadata <- function(x, ...){
  cat("PXWEB METADATA\n")
  cat("variables:\n")
  for(i in seq_along(x$variables)){
    cat(" [[", i ,"]] ",  x$variables[[i]]$code,": ", x$variables[[i]]$text, "\n", sep = "")
  }
}