# AmphiNom

This package is designed to simplify the workflow of combining amphibian data sets from sources that use different taxonomic nomenclature, by conforming to the most current system suggested by the [Amphibian Species of the World](http://research.amnh.org/vz/herpetology/amphibia/). Comparative studies require the combination of data from a range of sources such as spatial or conservation data from the [IUCN red list](http://www.iucnredlist.org/), information on evolutionary history from published phylogenies such as [Pyron 2014, Syst Biol](https://doi.org/10.1093/sysbio/syu042) or life history data from [AnAge](http://genomics.senescence.info/species/). These sources have either made the decision to follow a specific taxonomic system or, more often, are no longer up-to-date. It can therefore be complicated to establish a universal or current nomenclature to be able to efficientlty combine data sets. As such, the main objective of this package is to harvest taxonomic classifications of all amphibian species listed on the ASW website, harvest all listed synonyms per species and then using this information, suggest ASW names for any given list of taxa.

This package could also be useful for easily updating museum catalogs etc., and includes functions for producing summary statistics on species numbers at various taxonomic levels, or to update species names in manuscripts etc. after a taxonomic group has received nomenclature revisions

A detailed tutorial will be uploaded soon



## Package Installation

You can install AmphiNom in R directly using devtools:

library(devtools)

install_github("hcliedtke/AmphiNom", build_vignettes = TRUE)

(The installation may crash if your dependencies are not up to date.)

## Package citation

H. Christoph Liedtke (2017). AmphiNom: A tool for keeping up with amphibian taxonomy. R package version 1.0.0.
  http://github.com/hcliedtke/AmphiNom
