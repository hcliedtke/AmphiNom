#' Get summary report of "synced" query
#'
#' This function produces a report of an undertaken aswSync() query
#'
#'
#' @details One logical arguments can be turned on to summarize in terms of numbers of cases, or to provide species names of conflicting issues.
#'
#' @param query_info output of the function aswSync()
#' @param verbose logical arguments can be turned on to list species which result in conflict. Default=FALSE
#' @return returns either a data frame or list of summary statitics
#' @examples
#' #check out amphibiaweb taxonomy and extract only Bufonidae
#' head(amphweb$species)
#' amphweb.bufonidae<-amphweb[amphweb$family=="Bufonidae",]
#' #query bufonidae against ASW database and inspect
#' bufonidae.asw<-aswSync(query=amphweb.bufonidae$species)
#' synonymReport(bufonidae.asw)
#' @export



synonymReport<-function(query_info, verbose=F){

  if(verbose==F){
    out<-data.frame(row.names=c("queries","names_up_to_date","names_successfully_updated","names_not_found","ambiguities","duplicates_produced"), number_of_units=c(
      nrow(query_info),
      length(which(query_info$status=="up_to_date")),
      length(which(query_info$status=="updated")),
      length(which(query_info$status=="name_not_found")),
      length(which(query_info$status=="ambiguous")),
      length(which(query_info$warnings=="duplicated"))
    ))
  }

  if(verbose==T){
    out<-list()
    out$names_not_found<-query_info$query[query_info$status=="name_not_found"]
    out$query<-query_info$query[query_info$status=="updated"]
    out$ASW_names<-query_info$ASW_names[query_info$status=="updated"]
    out$ambiguities$query<-query_info$query[query_info$status=="ambiguous"]
    out$ambiguities$ASW_names<-query_info$ASW_names[query_info$status=="ambiguous"]
    out$duplicated$query<-query_info$query[query_info$warnings %in% "duplicated"]
    out$duplicated$ASW_names<-query_info$ASW_names[query_info$warnings %in% "duplicated"]
  }

  return(out)
}
