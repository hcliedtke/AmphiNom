setwd("~/Documents/AmphiNom_project/amphinom/data_archive/")

library(AmphiNom)
library(glue)
library(tidyverse)

date<-gsub(Sys.Date(), pattern="-", replacement="")
print(glue("today is: {date}"))

(info<-sessionInfo())


# get amphibiaweb
print("gathering amphibiaweb data...")
amphweb_tax<-read_tsv("https://amphibiaweb.org/amphib_names.txt", quote = "")

print("saving amphibiaweb data...")
write.csv(amphweb_tax, glue("amphweb_{date}.csv"), row.names = F)




## get asw taxonomy
print("gathering ASW taxonomic data...")
tax<-getTaxonomy()

print("saving ASW taxonomic data...")
write.csv(tax, glue("asw_taxonomy_{date}.csv"), row.names = F)




## get asw synonyms
print("gathering ASW synonyms data...")
synon<-getSynonyms(asw_taxonomy = tax)

print("saving ASW data...")
write.csv(synon, glue("asw_synonyms_{date}.csv"), row.names = F)


q(save="no")






