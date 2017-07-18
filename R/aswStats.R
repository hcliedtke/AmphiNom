#' Get summary statistics of current taxonomy
#'
#' This function uses the ASW taxnomy table created with the function getTaxonomy() and summarizes counts of units per taxonomic level
#'
#'
#' @details One logical arguments can be turned on to summarize at given taxonomic levels or to give numbers of each unit per taxonomic level
#' @param asw_taxonomy output of the function frostScraper() default will take defrostR's stored version, which might be outdated
#' @param Order string to specify summary statistics of only a specific order
#' @param Superfamily string to specify summary statistics of only a specific superfamily
#' @param Family string to specify summary statistics of only a specific Family
#' @param Subfamily string to specify summary statistics of only a specific subfamily
#' @param Genus string to specify summary statistics of only a specific genus
#' @param verbose logical arguments can be turned on to summarize at given taxonomic levels or to give numbers of each unit per taxonomic level. default is switched off (FALSE)
#' @return returns either a data frame or list of summary statitics
#' @examples
#' aswStats()
#' aswStats(verbose=TRUE, Family="Rhacophoridae")
#' @export

aswStats<-function(asw_taxonomy=defrostR::asw_taxonomy,verbose=F, Order=NA, Superfamily=NA, Family=NA,Subfamily=NA, Genus=NA){

  if(!is.na(Order)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$order==Order,]
  if(!is.na(Superfamily)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$superfamily==Superfamily,]
  if(!is.na(Family)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$family==Family,]
  if(!is.na(Subfamily)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$subfamily==Subfamily,]
  if(!is.na(Genus)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$genus==Genus,]

  asw_taxonomy<-as.data.frame(apply(X=asw_taxonomy, MARGIN=2, FUN=factor))
  asw_taxonomy<-asw_taxonomy[!is.na(asw_taxonomy$url),]


  if(verbose==F){
    out<-data.frame(row.names=c("Oders","Families","Genera","Species"), number_of_units=c(
      length(levels(asw_taxonomy$order)),
      length(levels(asw_taxonomy$family)),
      length(levels(asw_taxonomy$genus)),
      length(levels(asw_taxonomy$species))
    ))
  }


  if(verbose==T){
    out<-list()
    out$Orders<-table(asw_taxonomy$order)
    out$Super_families<-table(na.omit(asw_taxonomy$superfamily))
    out$Families<-table(na.omit(asw_taxonomy$family))
    out$Sub_families<-table(na.omit(asw_taxonomy$subfamily))
    out$Genera<-table(asw_taxonomy$genus)
    out$Species<-as.character(asw_taxonomy$species)
  }

 return(out)
}
