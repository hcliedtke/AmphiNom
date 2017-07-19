## ----setup, include=FALSE-------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,  warning = FALSE, message = FALSE, echo = TRUE, tidy = FALSE, size="small")
options(width=100)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(defrostR)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
library(knitr)

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
#asw_taxonomy<-getTaxonomy()
head(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(asw_taxonomy), padding=2)

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
aswStats(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(aswStats(asw_taxonomy))

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
aswStats(asw_taxonomy, Family="Plethodontidae")

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

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
amphweb<-amphweb
head(amphweb$species)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
amphweb.hyla<-amphweb[amphweb$genus=="Hyla",]

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
hyla.defrosted<-defrost(query=amphweb.hyla$species,asw = asw_synonyms)
head(hyla.defrosted, n=15)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(hyla.defrosted, n=15))

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
synonymReport(hyla.defrosted)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(synonymReport(hyla.defrosted))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
synonymReport(hyla.defrosted, verbose=T)

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
hyla.defrosted[hyla.defrosted$status=="ambiguous",]

## ----message=FALSE, warning=FALSE, results='hide'-------------------------------------------------
hyla.defrosted[hyla.defrosted$warnings %in% "duplicated",]

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(hyla.defrosted[hyla.defrosted$warnings %in% "duplicated",])

