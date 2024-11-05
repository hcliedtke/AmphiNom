#' Submit query to find updates in nomenclautre
#'
#' This function takes a query (a list of taxon names to be assessed) and the amphibian species of the world synonym table (preferrably generated with the function getSynonyms(), or loaded from the data set stored internally) as input and returns an updated list of names.
#'
#'
#' Two logical arguments can be turned on to a) allow an "on the fly" decision to be made on what name to take if synonym matches multiple names (if not, it will return all possible names) and to b) return the original query name if no match is found
#' @param query vector of taxon names to be processed (can also be tip labels of a phylogeny for example)
#' @param asw amphibian species of the world synonym reference table on which to base new names on. Default setting will use the internally stored data set that may not be the most up-to-date.
#' @param interactive logical argument (default=FALSE) of whether to allow an "on the fly" decision to be made on what name to take if synonym matches multiple names. FLASE will return all possible names for a given query as a string, TRUE will ask the user to select one.
#' @param return.no.matches logical argument of whether to leave taxa not found in the reference table blank or whether to fill in the names provided by the query. default is FALSE
#' @return this function returns a data frame with the following information/columns: original/input names, "stripped" names with no formatting, status of what action has been taken, updated names as recommended by the reference table
#' @export
#' @examples
#' aswSync(query=c("Bufo calamita", "Bufo viridis"))


aswSync<-function(query, asw=AmphiNom::asw_synonyms, interactive=F, return.no.matches=F){


  ### first step is to remove all formatting from both names and the frost database

  query<-data.frame(query=query,stringsAsFactors=F)
  query$stripped<-gsub(query$query, pattern="[^[:alnum:]]",replacement="_")
  query$stripped<-tolower(query$stripped)

  asw$stripped<-gsub(asw$synonym, pattern="[^[:alnum:]]",replacement="_")
  asw$stripped<-tolower(asw$stripped)


  ###### then:


  #update names. if interactive=F then it will return a string of names if names are ambiguous
  query$status<-NA
  query$warnings<-NA
  query$ASW_names<-NA

  if(!interactive){
    for(i in 1:nrow(query)){
      if(length(unique(asw$species[asw$stripped==query$stripped[i]]))==1){
        query$ASW_names[i]<-as.character((asw$species[asw$stripped==query$stripped[i]])[1])
        query$status[i]<-"updated"
      }
      if(length(unique(asw$species[asw$stripped==query$stripped[i]]))>1){
        query$status[i]<-"ambiguous"
        query$ASW_names[i]<-paste(unique(asw$species[asw$stripped==query$stripped[i]]), collapse = ", ")
      }
    }
  }

  # if interactive=T, the user can resolve each case of ambiguity on the go

  if(interactive){
    for(i in 1:nrow(query)){
      if(length(unique(asw$species[asw$stripped==query$stripped[i]]))==1){
        query$ASW_names[i]<-as.character((asw$species[asw$stripped==query$stripped[i]])[1])
        query$status[i]<-"updated"
      }
      if(length(unique(asw$species[asw$stripped==query$stripped[i]]))>1){
        n <- readline(prompt=cat("",as.character(query$query[i]),"can be matched with multiple species names. Choose one of the following by entering the line number in the console:","",as.character(unique(asw$species[asw$stripped==query$stripped[i]])), sep="\n"))
        query$ASW_names[i]<-as.character(unique(asw$species[asw$stripped==query$stripped[i]])[as.integer(n)])
        query$status[i]<-"updated"
      }
    }
  }
  ### update the status column to show which query names were actually already up to date (i.e. matching frost)
  frost.stripped<-tolower(query$ASW_names)
  frost.stripped<-gsub(frost.stripped, pattern=" ",replacement="_")
  for(i in 1:nrow(query)){
    if(!is.na(frost.stripped[i]) & query$stripped[i]==frost.stripped[i]){
      query$status[i]<-"up_to_date"
    }
  }

  ##find names which are not listed in frost:
  if(!return.no.matches){
    query[which(!query$stripped %in% asw$stripped),"status"]<-"name_not_found"
    query[which(!query$stripped %in% asw$stripped),"ASW_names"]<-NA
  }
  if(return.no.matches){
    query[which(!query$stripped %in% asw$stripped),"status"]<-"name_not_found"
    query[query$status=="name_not_found","ASW_names"]<-as.character(query[query$status=="name_not_found","query"])
  }

  ##indicate which species names are duplicated as a result of the renaming:
  duplicates<-unique(query$ASW_names[duplicated(query$ASW_names)])
  query$warnings[query$ASW_names %in% duplicates[!is.na(duplicates)]]<-"duplicated"

  ##formate the output names the same way as the input names
  for(i in 1:nrow(query)){
    if(grepl(query$query[i], pattern="_")){
      query$ASW_names[i]<-gsub(query$ASW_names[i], pattern="([[:alpha:]]) ([[:alpha:]])", replacement="\\1_\\2")
    }
  }

  query$query<-as.character(query$query)

  return(query)
}

