% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_brazil_region.R
\name{get_brazil_region}
\alias{get_brazil_region}
\title{Get Brazilian regions}
\usage{
get_brazil_region(x = NULL)
}
\arguments{
\item{x}{(optional) An \code{\link[base:is.recursive]{atomic}} vector containing the
names, abbreviations, or numeric codes of Brazilian states or federal
units. Region and municipality codes are also supported. If \code{NULL},
returns a vector with all Brazilian regions. (default: \code{NULL})}
}
\value{
A \code{\link[base:character]{character}} vector with the names of
Brazilian regions.
}
\description{
\code{get_brazil_region()} returns a vector with the names of
\href{https://en.wikipedia.org/wiki/Regions_of_Brazil}{Brazilian regions}.
}
\details{
The data from this function is based on data from the Brazilian Institute
of Geography and Statistics (IBGE, n.d.).
}
\examples{
get_brazil_region()
#> [1] "North" "Northeast" "South" "Southeast" "Central-West" # Expected

get_brazil_region("sp")
#> [1] "Southeast" # Expected

get_brazil_region("sao paulo")
#> [1] "Southeast" # Expected

get_brazil_region(c(1, 4))
#> [1] "North" "South" # Expected

get_brazil_region(35) # State of São Paulo
#> [1] "Southeast" # Expected

get_brazil_region(3550308) # Municipality of São Paulo
#> [1] "Southeast" # Expected

get_brazil_region(35503081) # >7 digits
#> [1] NA # Expected
}
\references{
Instituto Brasileiro de Geografia e Estatística. (n.d.). \emph{Território}
[Territory] [Dataset]. SIDRA. \url{https://sidra.ibge.gov.br/territorio}
}
\seealso{
Other Brazil functions: 
\code{\link{get_brazil_fu}()},
\code{\link{get_brazil_municipality}()},
\code{\link{get_brazil_municipality_code}()},
\code{\link{get_brazil_municipality_coords}()},
\code{\link{get_brazil_municipality_latitude}()},
\code{\link{get_brazil_municipality_longitude}()},
\code{\link{get_brazil_region_code}()},
\code{\link{get_brazil_state}()},
\code{\link{get_brazil_state_by_utc}()},
\code{\link{get_brazil_state_capital}()},
\code{\link{get_brazil_state_code}()},
\code{\link{get_brazil_state_latitude}()},
\code{\link{get_brazil_state_longitude}()},
\code{\link{render_brazil_address}()}
}
\concept{Brazil functions}
