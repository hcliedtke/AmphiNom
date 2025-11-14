## ----setup, include=FALSE-------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,  warning = FALSE, message = FALSE, echo = TRUE, tidy = FALSE, size="small")
options(width=100)

## ----message=FALSE, eval=FALSE--------------------------------------------------------------------
# library(devtools)
# install_github("hcliedtke/AmphiNom", build_vignettes = FALSE)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(AmphiNom)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
library(knitr)

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
# #asw_taxonomy<-get_taxonomy()
# head(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(head(asw_taxonomy), padding=2)

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
# asw_stats(asw_taxonomy)

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(asw_stats(asw_taxonomy))

## ----message=FALSE, warning=FALSE, eval=FALSE-----------------------------------------------------
# asw_stats(asw_taxonomy, Family="Plethodontidae")

## ----echo=F, message=FALSE, warning=FALSE---------------------------------------------------------
kable(asw_stats(asw_taxonomy, Family="Plethodontidae"))

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
asw_stats(asw_taxonomy, Family = "Plethodontidae",verbose = T)

## ----message=FALSE, warning=FALSE, dev="png"------------------------------------------------------
plethodontid.stats<-asw_stats(asw_taxonomy, Family = "Plethodontidae",verbose = T)
par(mar=c(1,1,1,1))
pie(plethodontid.stats$Genera[order(plethodontid.stats$Genera, decreasing = T)], cex=0.5, main = "No. of Species per Genus", col = rainbow(length(plethodontid.stats$Genera),s = 0.5), clockwise = T, border = NA)

