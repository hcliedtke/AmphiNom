#' Compile dataframe of all synonyms listed on Amphibian Species of the World
#'
#' This function looks up any listed synonyms on the ASW website (http://research.amnh.org/vz/herpetology/amphibia/index.php/). It takes a minimum of one argument: the asw_taxonomy table generated with the function getTaxonomy(). If a full search is performed, this can take quite long (looking through ~7000 species webpages for upwards of 20 000 synonyms), but additional arguments can be included to restrict searches to a specified taxonomic group.
#'
#' @param asw_taxonomy the ASW taxonomy table obtained with getTaxonomy(). If no table is provided, by default it will use the internally stored data set. WARNING! this version of the amphibian taxonomy may be outdated
#' @param Order limit search to a user-specified amphibian order
#' @param Superfamily limit search to a user-specified amphibian superfamily
#' @param Family limit search to a user-specified amphibian family
#' @param Subfamily limit search to a user-specified amphibian subfamily
#' @param Genus limit search to a user-specified amphibian genus
#' @param Species limit search to a user-specified amphibian species
#' @return returns a dataframe listing all species and their listed synonyms
#' @details Users may experience issues with umlauts that are not supported by their system language. On Mac OSX, this can be changed by running the following line of code in R:
#'
#' system("defaults write org.R-project.R force.LANG en_US.UTF-8")
#'
#' and then restarting the session. Read more here: https://cran.r-project.org/bin/macosx/RMacOSX-FAQ.html#Internationalization-of-the-R_002eapp
#' @examples
#' #to get a full list of synonyms for all species, run:
#' \dontrun{asw_synonyms<-getSynonyms()}
#' #to get synonyms for a specific taxonomic group only:
#' \dontrun{breviceptid_synonyms<-getSynonyms(Family="Brevicipitidae")}
#' @import utils XML
#' @export


getSynonyms<-function(asw_taxonomy=AmphiNom::asw_taxonomy, Order=NA, Superfamily=NA, Family=NA,Subfamily=NA, Genus=NA, Species=NA){

  if(!is.na(Order)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$order %in% Order,]
  if(!is.na(Superfamily)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$superfamily %in% Superfamily,]
  if(!is.na(Family)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$family %in% Family,]
  if(!is.na(Subfamily)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$subfamily %in% Subfamily,]
  if(!is.na(Genus)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$genus %in% Genus,]
  if(!is.na(Species)) asw_taxonomy<-asw_taxonomy[asw_taxonomy$species %in% gsub(Species, pattern="_", replacement = " "),]

  if(nrow(asw_taxonomy)<1) print("No match found. Check spelling and make sure nested searches are compatible")
  if(nrow(asw_taxonomy)<1) return()

  asw_taxonomy<-asw_taxonomy[!is.na(asw_taxonomy$url),]
  if(nrow(asw_taxonomy)>1) asw_taxonomy<-as.data.frame(apply(X=asw_taxonomy, MARGIN=2, FUN=factor))


  print("Looking up synonyms. If performing a full search, this could take a while...")
  asw.syn.tab<-c()
  pb<- txtProgressBar(max=nrow(asw_taxonomy),style=3)
  for(i in 1:nrow(asw_taxonomy)){
    #get url and parse to document
    html<-readLines(as.character(asw_taxonomy$url[i]))

    #extract first paragraph (containing synonyms) and capture species names, based on the pattern that they occur before a
    #website link and is printed in bold (<b></b>)
    syn<-grep(html, pattern="<p>", value=T)[1]
    syn<-unlist(strsplit(syn, split ="<p>"))
    syn<-syn[grep(syn, pattern="<b>")] # keep only elements with a bold word in it
    syn<-gsub(syn, pattern="<a href=.*",replacement = "")
    syn<-gsub(syn, pattern="</b>.*", replacement = "")
    junk<-'<.*?>| |&nbsp;|\\s+'
    syn<-gsub(syn, pattern=junk, replacement = " ")
    syn<-gsub(syn, pattern="&quot;", replacement="'")
    syn<-gsub(syn, pattern="[^[:alnum:]]+$", replacement = " ")
    syn<-gsub(syn, pattern="^\\s+|\\s+$", replacement = "")
    syn<-gsub(syn, pattern="\\s+", replacement=" ")
    synon.names<-syn[syn!=""]




    #remove all single strings (binomials that were split due to inconsistent formatting)
    synon.names<-synon.names[grepl(synon.names, pattern="[[:blank:]]") & !grepl(synon.names, pattern="^\\w+$|^\\w+[[:blank:]]+$|^[[:blank:]]\\w+$")]

    #extract and divide sub genera
    sub.gen.pat<-"(\\w+ )(\\()(\\w+)(\\) )(\\w+)"
    sub.gen<-grep(synon.names, pattern=sub.gen.pat)
    synon.names<-c(synon.names,gsub(synon.names[sub.gen], pattern=sub.gen.pat, replacement=c("\\3 \\5")),gsub(synon.names[sub.gen], pattern=sub.gen.pat, replacement=c("\\1\\5")))

    #remove any non-alpha numerics at the end of the strings
    synon.names<-gsub(synon.names, pattern="[^[:alnum:]]+$", replacement="")

    #check if current species name is included in the list:
    if(!as.character(asw_taxonomy$species[i]) %in% synon.names) synon.names<-c(as.character(asw_taxonomy$species[i]),synon.names)

    #include also binomial species if only subspecies is lists
    triplets<-grep(synon.names, pattern="^\\w+ \\w+ \\w+$")
    if(length(triplets)>0){
      original<-triplets[which(sapply(strsplit(synon.names[triplets],split = " "), FUN=duplicated), arr.ind=T)[,"col"]]
      if(length(original)>0){
        synon.names<-c(synon.names, gsub(synon.names[original], pattern="(\\w+ )(\\w+)( \\w+)", replacement = "\\1\\2"))
      }
    }

    #remove any duplicates
    synon.names<-synon.names[!duplicated(synon.names)]

    # sort alphabetically
    synon.names<-synon.names[order(synon.names)]

    names(synon.names)<-rep(asw_taxonomy$species[i], length(synon.names))

    ##populate:
    asw.syn.tab<-c(asw.syn.tab, synon.names)

    # counter:
    setTxtProgressBar(pb,i)
  }

  # convert to table
  asw.syn.tab<-data.frame(species=names(asw.syn.tab), synonyms=asw.syn.tab)

  return(asw.syn.tab)
  ###end
}


