#' Search the Amphibian Species of the World database (Species search)
#'
#' This function searches species accounts on the ASW website (http://research.amnh.org/vz/herpetology/amphibia/index.php/) and returns all available information listed. The URL per species is taken from defrostR's internally stored records, unless specified otherwise.
#'
#' @param query search term. Binomial species name either separated by a space or "_"
#' @param asw_taxonomy version of taxonomy to use (output of getTaxonomy()). By default, internally stored version is used (which may be out of data)
#' @return returns all available information in list form
#' @export
#' @import utils
#' @examples
#' searchASW("Pleurodeles waltl")


###
searchASW<-function(query, asw_taxonomy=defrostR::asw_taxonomy){

  query<-gsub(query, pattern="_",replacement=" ")
  sp.url<-as.character(asw_taxonomy$url[grep(query,asw_taxonomy$species,ignore.case=TRUE,value=F)])

  if(length(sp.url)==0){
    print("Oops. no species of that name found. Check spelling?")
    return()}

  html<-readLines(sp.url)

  sp.info<-setNames(as.list(rep(NA, 7)), c("species","author","taxonomy","synonyms", "english_name","distribution","comment"))


  ## get species name and author
  name<-grep(html, pattern="<i>", value=T)[1]
  name<-unlist(strsplit(gsub(name, pattern="  |<i>", replacement=""),"</i> "))
  sp.info$species<-name[1]
  sp.info$author<-name[2]

  ##get taxonomic hierarchy
  sp.info$taxonomy<-gsub(sp.url, pattern="http://research.amnh.org/vz/herpetology/amphibia/", replacement = "")

  ## get synonym info
  syn<-grep(html, pattern="<p>", value=T)[1]
  syn<-unlist(strsplit(syn, split ="<p>"))
  syn<-gsub(syn, pattern='<.*?>|  |&nbsp;', replacement = "")
  syn<-gsub(syn, pattern='&quot;', replacement = "'")
  syn<-syn[syn!=""]
  sp.info$synonyms<-list(syn)[[1]]

  ## get english names, distribution and comments
  check<-strsplit(grep(html, pattern="<h3>", value=T), "</h3>")
  eng<-grep(html, pattern="<h3>")[grep(x=check, pattern="english", ignore.case=T)]
  dis<-grep(html, pattern="<h3>")[grep(x=check, pattern="distribution", ignore.case=T)]
  com<-grep(html, pattern="<h3>")[grep(x=check, pattern="comment", ignore.case=T)]


  if(length(eng)>0){
    t<-html[(eng+1):length(html)]
    t<-t[1:(grep(t, pattern="<h3>", value=F)[1]-1)]
    t<-unlist(strsplit(t, split ="<p>"))
    t<-gsub(t, pattern='<.*?>|  |&nbsp;', replacement = "")
    sp.info$english_name<-t[t!=""]
  }

  if(length(dis)>0){
    t<-html[(dis+1):length(html)]
    t<-t[1:(grep(t, pattern="<h3>", value=F)[1]-1)]
    t<-unlist(strsplit(t, split ="<p>"))
    t<-gsub(t, pattern='<.*?>|  |&nbsp;', replacement = "")
    sp.info$distribution<-t[t!=""]
  }

  if(length(com)>0){
    t<-html[(com+1):length(html)]
    t<-t[1:(grep(t, pattern="<h3>", value=F)[1]-1)]
    t<-unlist(strsplit(t, split ="<p>"))
    t<-gsub(t, pattern='<.*?>|  |&nbsp;', replacement = "")
    sp.info$comment<-t[t!=""]
  }

  return(sp.info)

}

