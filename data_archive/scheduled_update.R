setwd("~/Documents/AmphiNom_project/amphinom/data_archive/")

library(AmphiNom)
library(glue)

date<-gsub(Sys.Date(), pattern="-", replacement="")
print(glue("today is: {date}"))

(info<-sessionInfo())


# get amphibiaweb
print("gathering amphibiaweb data...")
amphweb_tax<-read.csv("https://amphibiaweb.org/amphib_names.txt", sep="\t")

print("saving amphibiaweb data...")
write.csv(amphweb_tax, glue("amphweb_{date}.csv"), row.names = F)



## get asw
print("gathering ASW taxonomic data...")
tax<-getTaxonomy()

print("gathering ASW synonyms data...")
synon<-getSynonyms(asw_taxonomy = tax)

# store in archives
print("saving ASW data...")
write.csv(tax, glue("asw_taxonomy_{date}.csv"), row.names = F)
write.csv(synon, glue("asw_synonyms_{date}.csv"), row.names = F)









