% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_taxonomy.R
\name{get_taxonomy}
\alias{get_taxonomy}
\title{Compile amphibian taxonomy following the Amphibian Species of the World}
\usage{
get_taxonomy()
}
\value{
returns a dataframe listing all species and their taxonomic backbone as well as all URLs per species.
}
\description{
This function takes no arguments. It cycles through the ASW website (https://amphibiansoftheworld.amnh.org/) to scrap all taxonomic information from Order to Species. As there are 5 taxonomic levels within each Order (Superfamily/Family/Subfamily/Genus/Species), one can expect the function to require 1 initial loop followed by 4 more, but it is designed to keep going until all lineages have reached the species level.
}
\examples{
\dontrun{asw_taxonomy_table<-get_taxonomy()}
}
