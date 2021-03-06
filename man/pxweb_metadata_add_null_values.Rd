% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pxweb_get.R
\name{pxweb_metadata_add_null_values}
\alias{pxweb_metadata_add_null_values}
\title{Add values to NULL value variables in PXWEB metadata objects}
\usage{
pxweb_metadata_add_null_values(x, px)
}
\arguments{
\item{x}{an object to check if is a \code{pxweb_metadata} object to which we should add values.}

\item{px}{a \code{pxweb} object}
}
\description{
Add values to NULL value variables in PXWEB metadata objects
}
\details{
Some metadata objects may have NULL values. In these cases the values are downloaded and added
to the metadata object.
}
\keyword{internal}
