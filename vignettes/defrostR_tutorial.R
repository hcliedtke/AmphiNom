## ----setup, include=FALSE-------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,  warning = FALSE, message = FALSE, echo = TRUE, tidy = FALSE, size="small")
options(width=100)

## ----message=FALSE, eval=FALSE--------------------------------------------------------------------
#  library(devtools)
#  install_github("hcliedtke/defrostR", build_vignettes = TRUE)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(defrostR)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
library(knitr)

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  #asw_taxonomy<-getTaxonomy()
#  head(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(asw_taxonomy), padding=2)

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  aswStats(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(aswStats(asw_taxonomy))

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  aswStats(asw_taxonomy, Family="Plethodontidae")

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(aswStats(asw_taxonomy, Family="Plethodontidae"))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
aswStats(asw_taxonomy, Family = "Plethodontidae",verbose = T)

## ----message=FALSE, warning=FALSE, dev="png"------------------------------------------------------
plethodontid.stats<-aswStats(asw_taxonomy, Family = "Plethodontidae",verbose = T)
par(mar=c(1,1,1,1))
pie(plethodontid.stats$Genera[order(plethodontid.stats$Genera, decreasing = T)], cex=0.5, main = "No. of Species per Genus", col = rainbow(length(plethodontid.stats$Genera),s = 0.5), clockwise = T, border = NA)

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
agalychnis_synonyms<-getSynonyms(Genus="Agalychnis")
head(agalychnis_synonyms,n = 15)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(agalychnis_synonyms,n = 15))

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  summary(agalychnis_synonyms$species)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(summary(agalychnis_synonyms$species))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
amphweb_latest<-read.csv(url("https://amphibiaweb.org/amphib_names.txt"), sep="\t")

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  head(amphweb)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(amphweb))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
amphweb.hyla<-amphweb[amphweb$genus=="Hyla",]

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
hyla.defrosted<-defrost(query=paste(amphweb.hyla$genus, amphweb.hyla$species),asw = asw_synonyms)
head(hyla.defrosted, n=15)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(hyla.defrosted, n=15))

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  synonymReport(hyla.defrosted)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(synonymReport(hyla.defrosted))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
synonymReport(hyla.defrosted, verbose=T)

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
hyla.defrosted[hyla.defrosted$status=="ambiguous",]

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  hyla.defrosted[hyla.defrosted$warnings %in% "duplicated",]

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(hyla.defrosted[hyla.defrosted$warnings %in% "duplicated",])

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
#  amphweb.hyla$ASW_names<-hyla.defrosted$ASW_names

