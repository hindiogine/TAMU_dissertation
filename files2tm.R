files2tm <- function(Code,language="eng"){
 ## convert files from the rqda project into a corpus
 fcat <- RQDAQuery("select treefile.fid, filecat.name from treefile,
                    filecat on filecat.catid==treefile.catid and treefile.status==1 and
                    filecat.status==1")

 Encoding(fcat$name) <- "UTF-8"

 names(fcat) <- c("id","filecat")

 txt <-RQDAQuery("select name, id, file, owner, date from source where status==1")

 txt <- merge(txt,fcat,by="id",all.x=TRUE,all.y=FALSE)

 Encoding(txt$file) <- "UTF-8"

 Encoding(txt$name) <- "UTF-8"

 fcorpus <- tm:::Corpus(tm::VectorSource(txt$file),
                 readerControl = list(language = language))
 
 meta(fcorpus, tag = c("fname","id","owner","date","filecat")) <- txt[,c("name","id","owner","date","filecat")] fcorpus
}
