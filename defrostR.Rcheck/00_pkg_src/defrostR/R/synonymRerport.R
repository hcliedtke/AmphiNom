#' Get summary report of "defrosted" query
#'
#' This function produces a report of an undertaken defrost() query
#'
#'
#' @details One logical arguments can be turned on to summarize in terms of numbers of cases, or to provide species names of conflicting issues.
#'
#' @param defrosted output of the function defrost()
#' @param verbose logical arguments can be turned on to list species which result in conflict. Default=FALSE
#' @return returns either a data frame or list of summary statitics
#' @examples
#' amphweb<-defrostR::amphweb
#' head(amphweb$species)
#' amphweb.bufonidae<-amphweb[amphweb$family=="Bufonidae",]
#' bufonidae.defrosted<-defrost(query=amphweb.bufonidae$species)
#' synonymReport(bufonidae.defrosted)
#' synonymReport(bufonidae.defrosted,)
#' @export



synonymReport<-function(defrosted, verbose=F){

  if(verbose==F){
    out<-data.frame(row.names=c("queries","names_up_to_date","names_successfully_defrosted","names_not_found","ambiguities","duplicates_produced"), number_of_units=c(
      nrow(defrosted),
      length(which(defrosted$status=="up_to_date")),
      length(which(defrosted$status=="defrosted")),
      length(which(defrosted$status=="name_not_found")),
      length(which(defrosted$status=="ambiguous")),
      length(which(defrosted$warnings=="duplicated"))
    ))
  }

  if(verbose==T){
    out<-list()
    out$names_not_found<-defrosted$query[defrosted$status=="name_not_found"]
    out$defrosted$query<-defrosted$query[defrosted$status=="defrosted"]
    out$defrosted$ASW_names<-defrosted$ASW_names[defrosted$status=="defrosted"]
    out$ambiguities$query<-defrosted$query[defrosted$status=="ambiguous"]
    out$ambiguities$ASW_names<-defrosted$ASW_names[defrosted$status=="ambiguous"]
    out$duplicated$query<-defrosted$query[defrosted$warnings %in% "duplicated"]
    out$duplicated$ASW_names<-defrosted$ASW_names[defrosted$warnings %in% "duplicated"]
  }

  return(out)
}
