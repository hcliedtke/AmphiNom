# defrostR

This package is aimed at trying to simplify the workflow of combining data sets from different sources that use different taxonomic nomenclature (specifically for amphibians). For example, two sources of important information for amphibian systematic are: Amphibian Species of the World (http://research.amnh.org/vz/herpetology/amphibia/) and Amphibia Web (http://amphibiaweb.org/). These use slightly different nomenclature. Moreover, in comparative studies, one often works with data from a range of sources such as spatial or conservation data from the IUCN red list (http://www.iucnredlist.org/) or phylogenetic information from published amphibian phylogenies such as those of Pyron and Wiens 2011 (MPE) and Pyron 2014 (Syst Biol). These sources have either made the decision to follow a specific taxonomic system or, more often, are no longer up to date. It can therefore be complicated to establish a universal or current nomenclature to be able to effectively combine data sets. As such, the main objective of this package is to harvest taxonomic classifications of all amphibian species listed on the ASW website, harvest all listed synonyms per species and then using this information, suggest “Frost” (ASW) names for any given list of taxa.

This package could also be useful for easily updating museum catalogs etc, or for producing summary statistics on species numbers for various taxonomic groupings, or to update species names in manuscripts etc. after a taxonomic group has received nomenclature revisions

A more detailed tutorial can be found [here](https://rawgit.com/hcliedtke/defrostR/master/inst/doc/defrostR_tutorial.html)



## Package Installation

You can install defrostR directly from R using devtools:

library(devtools)

install_github("hcliedtke/defrostR", build_vignettes = TRUE)

(The installation may crash if your dependencies are not up to date.)

## Package citation

H. Christoph Liedtke (2017). defrostR: A tool for keeping up with amphibian taxonomy. R package version 1.0.0.
  http://github.com/hcliedtke/defrostR
