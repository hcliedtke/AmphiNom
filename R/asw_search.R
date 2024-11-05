#' Search the Amphibian Species of the World database (Species search)
#'
#' This function searches species accounts on the ASW website and returns all available information listed. This currently works only at the species level, not higher taxonomic levels. The URL for a specific species account can be used as the query, or alternatively, the binomial species name. For the latter, unless specified otherwise, the function will look up the species' URL based on the information stored in AmphiNom's internal records, which may be outdated.
#'
#' @param query search term. Binomial species name either separated by a space or "_"
#' @param asw_taxonomy version of taxonomy to use (output of get_taxonomy()). By default, internally stored version is used (which may be out of data)
#' @return returns all available information in list form
#' @export
#' @import utils
#' @examples
#' asw_search(query="Pleurodeles waltl")
#' asw_search(query="https://amphibiansoftheworld.amnh.org/Amphibia/Caudata/Salamandridae/Pleurodelinae/Pleurodeles/Pleurodeles-waltl")


###
asw_search<-function (query, asw_taxonomy = AmphiNom::asw_taxonomy)
{

  if(grepl(x = query,pattern="^http")){
    sp.url <- query} else {
      query <- gsub(query, pattern = "_", replacement = " ")
      sp.url <- as.character(asw_taxonomy$url[grep(query, asw_taxonomy$species,
                                                   ignore.case = TRUE, value = F)])
    }

  if (length(sp.url) == 0) {
    print("No species of that name or URL found. If using a URL, make sure this link exists. If using species neam, make sure that the binomial name is separated either by a space of an underscore, there are no spelling mistakes and that the name is the accepted name in the version of the ASW used (check date of internal dataset if you did not specify the asw_taxonomy argument). Note, synonym searches are currently not supported, use asw_sync() instead to find the current accepted name.")
    return()
  }
  html <- readLines(sp.url)
  sp.info <- setNames(as.list(rep(NA, 8)), c("species", "author",
                                             "taxonomy", "synonyms", "common_names", "distribution",
                                             "geographic_occurrence",
                                             "comment"))
  name <- grep(html, pattern = "<i>", value = T)[1]
  name <- unlist(strsplit(gsub(name, pattern = "  |<i>", replacement = ""),
                          "</i> "))
  sp.info$species <- name[1]
  sp.info$author <- name[2]
  sp.info$taxonomy <- gsub(sp.url, pattern = "https://amphibiansoftheworld.amnh.org/Amphibia/",
                           replacement = "")
  syn <- grep(html, pattern = "<p>", value = T)[1]
  syn <- unlist(strsplit(syn, split = "<p>"))
  syn <- gsub(syn, pattern = "<.*?>|  |&nbsp;", replacement = "")
  syn <- gsub(syn, pattern = "&quot;", replacement = "'")
  syn <- syn[syn != ""]
  sp.info$synonyms <- list(syn)[[1]]
  check <- strsplit(grep(html, pattern = "<h2>", value = T),
                    "</h2>")
  eng <- grep(html, pattern = "<h2>")[grep(x = check, pattern = "Common Names",
                                           ignore.case = T)]
  dis <- grep(html, pattern = "<h2>")[grep(x = check, pattern = "Distribution",
                                           ignore.case = T)]
  geo <- grep(html, pattern = "<h2>")[grep(x = check, pattern = "Geographic Occurrence",
                                           ignore.case = T)]
  com <- grep(html, pattern = "<h2>")[grep(x = check, pattern = "Comment",
                                           ignore.case = T)]
  if (length(eng) > 0) {
    t <- html[(eng + 1):length(html)]
    t <- t[1:(grep(t, pattern = "<h2>", value = F)[1] - 1)]
    t <- unlist(strsplit(t, split = "<p>"))
    t <- gsub(t, pattern = "<.*?>|  |&nbsp;", replacement = "")
    sp.info$common_names <- t[t != ""]
  }
  if (length(dis) > 0) {
    t <- html[(dis + 1):length(html)]
    t <- t[1:(grep(t, pattern = "<h2>", value = F)[1] - 1)]
    t <- unlist(strsplit(t, split = "<p>"))
    t <- gsub(t, pattern = "<.*?>|  |&nbsp;", replacement = "")
    sp.info$distribution <- t[t != ""]
  }
  if (length(geo) > 0) {
    t <- html[(geo + 1):length(html)]
    t <- t[1:(grep(t, pattern = "<h2>", value = F)[1] - 1)]
    t <- unlist(strsplit(t, split = "<p>"))
    t <- gsub(t, pattern = "<.*?>|  |&nbsp;", replacement = "")
    sp.info$geographic_occurrence <- t[t != ""]
  }
  if (length(com) > 0) {
    t <- html[(com + 1):length(html)]
    t <- t[1:(grep(t, pattern = "<h2>", value = F)[1] - 1)]
    t <- unlist(strsplit(t, split = "<p>"))
    t <- gsub(t, pattern = "<.*?>|  |&nbsp;", replacement = "")
    sp.info$comment <- t[t != ""]
  }
  return(sp.info)
}

