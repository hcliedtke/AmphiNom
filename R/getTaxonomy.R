#' Construct taxonomy used by Amphibian Species of the World
#'
#' This function takes no arguments. It cycles through the ASW website (http://research.amnh.org/vz/herpetology/amphibia/index.php/) in an attempt to scrap all taxonomic information from Order to Species. As there are 5 taxonomic levels within each order (Superfamily/Family/Subfamily/Genus/Species), one can expect the function to require 1 initial loop followed by 4 more, but it is designed to keep going until all lineages have reached the species level.
#'
#'
#' @return returns a dataframe listing all species and their taxonomic backbone as well as all URLs per species.
#' @export
#' @examples
#' asw_taxonomy_table<-getTaxonomy()



###

getTaxonomy<-function(){

  #1. build function that extacts taxonomic information to build the URL stems
  urlExtender<-function(url.stem){
    temp<-list()
    new.url.stem<-list()
    pb<- txtProgressBar(max=length(url.stem),style=3)
    for(i in 1:length(url.stem)){
      if(!grepl(x=url.stem[i],pattern="-")){
        l<-readLines(paste("http://research.amnh.org/vz/herpetology/amphibia/index.php//Amphibia/",url.stem[i],sep = ""))
        l1<-grep(l, pattern=url.stem[i], value=T)
        pat<-paste('.*', url.stem[i],'/(.*)\">.*', sep="")
        temp[[i]]<-gsub(pattern = pat, "\\1", x = l1)
        temp[[i]]<-temp[[i]][grep("[[:blank:]]", temp[[i]],invert = T)]
        new.url.stem[[i]]<-paste(url.stem[i],temp[[i]], sep="/")
      }
      else{
        new.url.stem[[i]]<-url.stem[i]
      }
      setTxtProgressBar(pb,i)
    }
    new.url.stem<-unlist(new.url.stem)
    return(new.url.stem)
  }


  #2. loop through the website until ever stem ends with a species (with an escape of 10 rounds)
  print("Building Superfamily and Family backbones...")
  url.stem<-urlExtender(c("Anura","Caudata","Gymnophiona"))
  i=1
  print("Populating Families/Subfamilies/Genera/Species. Expecting ca. 4 rounds...")
  while(length(grep(url.stem, pattern="-"))<length(url.stem)){
    if(i>9) {break; print("Oops! this is taking too long... something is wrong")}

    print(paste("Round ", i, " of ca. 4"))
    url.stem<-urlExtender(url.stem)

    i=i+1
  }



  #3. split url strings to populate table
  tabulator<-function(url.stem){

    split.stem<-strsplit(url.stem, '/')
    tmp.tbl<-data.frame(order=rep(NA, length(url.stem)),superfamily=NA, family=NA, subfamily=NA, genus=NA, species=NA, url=NA)

    for(i in 1:length(split.stem)){
      tmp.tbl$order[i]<-split.stem[[i]][1]
      tmp.tbl$superfamily[i]<-ifelse(length(grep(split.stem[[i]][2], pattern="oidea", value=F))==0, NA, grep(split.stem[[i]][2], pattern="oidea", value=T))
      tmp.tbl$family[i]<-ifelse(length(grep(split.stem[[i]], pattern="idae", value=F))==0, NA, grep(split.stem[[i]], pattern="idae", value=T))
      tmp.tbl$subfamily[i]<-ifelse(length(grep(split.stem[[i]][-length(split.stem[[i]])], pattern="inae", value=F))==0, NA, grep(split.stem[[i]][-length(split.stem[[i]])], pattern="inae", value=T))
      tmp.tbl$species[i]<-sub(x = tail(split.stem[[i]],n=1),pattern="(\\w+)-", replacement = "\\1 ")
      tmp.tbl$url[i]<-paste("http://research.amnh.org/vz/herpetology/amphibia/Amphibia/",url.stem[i], collapse="",sep="")
    }
    tmp.tbl$genus<-gsub(tmp.tbl$species, pattern=" .*", replacement = "")
    return(tmp.tbl)
  }

  asw_taxonomy<-tabulator(url.stem)


  return(asw_taxonomy)


}



