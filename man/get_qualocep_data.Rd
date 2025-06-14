% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_qualocep_data.R
\name{get_qualocep_data}
\alias{get_qualocep_data}
\title{Get Qual o CEP data}
\usage{
get_qualocep_data(file = NULL, pattern = "2024-11-12.rds", force = FALSE)
}
\arguments{
\item{file}{(optional) A \code{\link[base:character]{character}} string with the
path to a Qual o CEP dataset file. If \code{NULL}, the dataset will be
downloaded from the package's \href{https://osf.io/9ky4g/}{OSF repository}.
(default: \code{NULL}).}

\item{pattern}{(optional) A \code{\link[base:character]{character}} string with
the pattern of the Qual o CEP dataset file to download. Click
\href{https://osf.io/k5hyq/files/osfstorage}{here} to see the available
patterns (default: \code{"2024-11-12.rds"}).}

\item{force}{(optional) A \code{\link[base:logical]{logical}} flag to force the
download of the Qual o CEP dataset file. If \code{TRUE}, the dataset will
be downloaded even if it already exists in the temporary directory
(default: \code{FALSE}).}
}
\value{
A \code{\link[tibble:tibble]{tibble}} containing the Qual o CEP dataset with
the following columns:
\itemize{
\item \code{postal_code}: A \code{\link[base:character]{character}} vector with the postal
codes.
\item \code{street_type}: A \code{\link[base:character]{character}} vector with the type of
streets.
\item \code{street_name}: A \code{\link[base:character]{character}} vector with the name of
the streets.
\item \code{street}: A \code{\link[base:character]{character}} vector with the full name of
the streets.
\item \code{complement}: A \code{\link[base:character]{character}} vector with the
complement of the addresses.
\item \code{place}: A \code{\link[base:character]{character}} vector with the place of the
addresses.
\item \code{neighborhood}: A \code{\link[base:character]{character}} vector with the
neighborhoods
\item \code{municipality_code}: An \code{\link[base:integer]{integer}} vector with the codes
of the Brazilian Institute of Geography and Statistics
(\href{https://www.ibge.gov.br/}{IBGE}) for Brazilian municipalities.
\item \code{municipality}: A \code{\link[base:character]{character}} vector with the name of
the municipalities.
\item \code{state_code}: An \code{\link[base:integer]{integer}} vector with the codes of the
Brazilian Institute of Geography and Statistics
(\href{https://www.ibge.gov.br/}{IBGE}) for the Brazilian state.
\item \code{state}: A \code{\link[base:character]{character}} vector with the name of the
states.
\item \code{federal_unit}: A \code{\link[base:character]{character}} vector with the
abbreviations of the Brazilian federal unit.
\item \code{latitude}: A \code{\link[base:numeric]{numeric}} vector with the latitude values
of the postal codes (retrieved using Google Geocoding API).
\item \code{longitude}: A \code{\link[base:numeric]{numeric}} vector with the longitude
values of the postal codes (retrieved using Google Geocoding API).
}
}
\description{
\code{get_qualocep_data()} retrieves a validated dataset of Qual o CEP from the
package's \href{https://osf.io/9ky4g/}{OSF repository}.
}
\details{
\href{https://www.qualocep.com}{Qual o CEP} is a database of Brazilian addresses
and postal codes geocoded made using the Google Geocoding API.

Please note the year of the pattern. Some values could be
}
\examples{
\dontrun{
  get_qualocep_data()
}
}
\concept{API functions}
