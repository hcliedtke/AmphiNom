# AmphiNom

_NOTE: as of July 2021, the ASW website no longer permits access via R. This limits the functionality of AmphiNom, but it can still be sued with the internal stored dataset, last updated on the 5th of July 2021__ 
  
This package is designed to simplify the workflow of combining amphibian data sets from sources that use different taxonomic nomenclature (AmphiNom: Amphibian Nomenclature), by conforming to the most current system suggested by the [Amphibian Species of the World](http://research.amnh.org/vz/herpetology/amphibia/). Comparative studies require the combination of data from a range of sources such as spatial or conservation data from the [IUCN red list](http://www.iucnredlist.org/), information on evolutionary history from published phylogenies such as [Pyron 2014, Syst Biol](https://doi.org/10.1093/sysbio/syu042) or life history data from [AnAge](http://genomics.senescence.info/species/). These sources have either made the decision to follow a specific taxonomic system or, more often, are no longer up-to-date. It can therefore be complicated to establish a universal or current nomenclature to be able to efficientlty combine data sets. As such, the main objective of this package is to harvest taxonomic classifications of all amphibian species listed on the ASW website, harvest all listed synonyms per species and then using this information, suggest ASW names for any given list of taxa.

This package could also be useful for easily updating museum catalogs etc., and includes functions for producing summary statistics on species numbers at various taxonomic levels, or to update species names in manuscripts etc. after a taxonomic group has received nomenclature revisions.

Good places to start learning more about AmphiNom are this [Tutorial](https://cdn.rawgit.com/hcliedtke/AmphiNom/df576f91/vignettes/AmphiNom_tutorial.html) and this worked [Example](https://figshare.com/articles/dataset/AmphiNom_an_amphibian_systematics_tool/7235297).

This schametic is intended to outline how to use the functions of this package:
![](schematic.png)

## Package Installation

You can install AmphiNom in R directly using devtools:

```{r}
library(devtools)
install_github("hcliedtke/AmphiNom", build_vignettes = TRUE)
library(AmphiNom)
```

(The installation may crash if your dependencies are not up to date.)

## Internal datasets

Last updated on 5th July 2021

## Package citation

H. Christoph Liedtke (2019). AmphiNom: an amphibian systematics tool. Systematics and Biodiversity (17)1:1-6
