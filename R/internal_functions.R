### generate reference manual: in shell run
#R CMD Rd2pdf --title='AmphiNom' -o AmphiNom_manual.pdf .


urlBuilder<-function(x){
  #where x is a dataframe with various taxonomic levels as columns
  asw.url<-apply(x,1, FUN = paste, collapse="/")
  asw.url<-gsub(asw.url, pattern="/NA", replacement="")
  return(asw.url)
}



urlExtender<-function(url.stem){
  temp<-list()
  new.url.stem<-list()
  pb<- txtProgressBar(max=length(url.stem),style=3)
  for(i in 1:length(url.stem)){
    l<-readLines(paste("http://research.amnh.org/vz/herpetology/amphibia/index.php//Amphibia/",url.stem[i],sep = ""))
    l1<-grep(l, pattern=url.stem[i], value=T)
    pat<-paste('.*', url.stem[i],'/(.*)\">.*', sep="")
    temp[[i]]<-gsub(pattern = pat, "\\1", x = l1)
    temp[[i]]<-grep("^[[:alnum:]]*$", temp[[i]], value=TRUE)
    new.url.stem[[i]]<-paste(url.stem[i],temp[[i]], sep="/")
    setTxtProgressBar(pb,i)
  }
  new.url.stem<-unlist(new.url.stem)
  return(new.url.stem)
}




tabulator<-function(url.stem){

  split.stem<-strsplit(url.stem, '/')
  tmp.tbl<-data.frame(order=rep(NA, length(url.stem)),superfamily=NA, family=NA, subfamily=NA, species=NA, url=NA)

  for(i in 1:length(split.stem)){
    tmp.tbl$order[i]<-split.stem[[i]][1]
    tmp.tbl$superfamily[i]<-ifelse(length(grep(split.stem[[i]][2], pattern="oidea", value=F))==0, NA, grep(split.stem[[i]][2], pattern="oidea", value=T))
    tmp.tbl$family[i]<-ifelse(length(grep(split.stem[[i]], pattern="idae", value=F))==0, NA, grep(split.stem[[i]], pattern="idae", value=T))
    tmp.tbl$subfamily[i]<-ifelse(length(grep(split.stem[[i]][-length(split.stem[[i]])], pattern="inae", value=F))==0, NA, grep(split.stem[[i]][-length(split.stem[[i]])], pattern="inae", value=T))
    tmp.tbl$species[i]<-tail(split.stem[[i]],n=1)
    tmp.tbl$url[i]<-paste("http://research.amnh.org/vz/herpetology/amphibia/Amphibia/",url.stem[i], collapse="",sep="")
  }
  return(tmp.tbl)
}



