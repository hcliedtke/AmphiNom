pkgname <- "defrostR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('defrostR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("amphweb")
### * amphweb

flush(stderr()); flush(stdout())

### Name: amphweb
### Title: AmphibiaWeb Taxonomy
### Aliases: amphweb
### Keywords: datasets

### ** Examples

head(amphweb)
amphweb<-defrostR::amphweb



cleanEx()
nameEx("aswStats")
### * aswStats

flush(stderr()); flush(stdout())

### Name: aswStats
### Title: Get summary statistics of current taxonomy
### Aliases: aswStats

### ** Examples

aswStats()
aswStats(verbose=TRUE, Family="Rhacophoridae")



cleanEx()
nameEx("asw_synonyms")
### * asw_synonyms

flush(stderr()); flush(stdout())

### Name: asw_synonyms
### Title: Amphibian Species of the World synonyms
### Aliases: asw_synonyms
### Keywords: datasets

### ** Examples

head(asw_synonyms)
str(asw_synonyms)
asw_synonyms<-defrostR::asw_synonyms



cleanEx()
nameEx("asw_taxonomy")
### * asw_taxonomy

flush(stderr()); flush(stdout())

### Name: asw_taxonomy
### Title: Amphibian Species of the World Taxonomy
### Aliases: asw_taxonomy
### Keywords: datasets

### ** Examples

head(asw_taxonomy)
str(asw_taxonomy)
asw_taxonomy<-defrostR::asw_taxonomy



cleanEx()
nameEx("getSynonyms")
### * getSynonyms

flush(stderr()); flush(stdout())

### Name: getSynonyms
### Title: Compile dataframe of all synonyms listed on Amphibia Species of
###   the World
### Aliases: getSynonyms

### ** Examples

asw_synonyms<-getSynonyms()
breviceptid_synonyms<-getSynonyms(Family="Brevicipitidae")



cleanEx()
nameEx("synonymReport")
### * synonymReport

flush(stderr()); flush(stdout())

### Name: synonymReport
### Title: Get summary report of "defrosted" query
### Aliases: synonymReport

### ** Examples

amphweb<-defrostR::amphweb
head(amphweb$species)
amphweb.bufonidae<-amphweb[amphweb$family=="Bufonidae",]
bufonidae.defrosted<-defrost(query=amphweb.bufonidae$species)
synonymReport(bufonidae.defrosted)
synonymReport(bufonidae.defrosted,)



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
