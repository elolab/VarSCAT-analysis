TRF_file <- read.table("chr1_UCSC_SimpleRepeat.txt",header = F,sep = "\t")
colnames(TRF_file) <- c("bin","chrom","chromStart","chromEnd","name","period","copyNum","consensusSize","perMatch","perIndel",
                        "score","A","C","G","T","entropy","sequence")
TRF_file_filter <- TRF_file[TRF_file[,"period"]<=6,]
TRF_file_filter <- TRF_file_filter[TRF_file_filter[,"chromEnd"]-TRF_file_filter[,"chromStart"]+1>=10,]
TRF_file_filter <- TRF_file_filter[TRF_file_filter[,"perMatch"]>=90,]
TRF_info <- paste0(as.character(TRF_file_filter[,3]),"_",as.character(TRF_file_filter[,4]),"_",
                   as.character(TRF_file_filter[,6]),"_",as.character(TRF_file_filter[,7]),"_",
                   as.character(TRF_file_filter[,9]),"_",as.character(TRF_file_filter[,10]),"_",
                   as.character(TRF_file_filter[,11]),"_",as.character(TRF_file_filter[,17]))
TRF_bed <- cbind(rep("chr1",length(TRF_info)),TRF_file_filter[,c(3,4)],TRF_info)
write.table(TRF_bed,"chr1_TRF_UCSC_90_match.bed",quote = F,sep = "\t",row.names = F,col.names = F)

RM_file <- read.table("chr1_UCSC_repeatmasker.txt",header = F,sep = "\t")
colnames(RM_file) <- c("bin","swScore","milliDiv","milliDel","milliIns","genoName","genoStart","genoEnd","genoLeft","strand",
                       "repName","repClass","repFamily","repStart","repEnd","repLeft","id")
RM_file_filter <- RM_file[RM_file[,"repClass"]=="Simple_repeat",]
RM_file_filter <- RM_file_filter[nchar(as.character(RM_file_filter[,"repName"]))-3<=6,]
RM_file_filter <- RM_file_filter[RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1>=10,]
RM_file_filter <- RM_file_filter[RM_file_filter[,"milliDiv"]+RM_file_filter[,"milliDel"]+RM_file_filter[,"milliIns"]<=100,]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==1 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<10),]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==2 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<5),]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==3 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<4),]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==4 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<4),]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==5 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<4),]
RM_file_filter <- RM_file_filter[!((nchar(as.character(RM_file_filter[,"repName"]))-3)==6 &
                                     (RM_file_filter[,"repEnd"]-RM_file_filter[,"repStart"]+1)/(nchar(as.character(RM_file_filter[,"repName"]))-3)<4),]
RM_file_filter$Unmatch <- RM_file_filter[,"milliDiv"]+RM_file_filter[,"milliDel"]+RM_file_filter[,"milliIns"]
RM_info <- paste0(as.character(RM_file_filter[,6]),"_",as.character(RM_file_filter[,7]),"_",as.character(RM_file_filter[,8]),"_",
                  as.character(RM_file_filter[,11]),"_",as.character(RM_file_filter[,14]),"_",
                  as.character(RM_file_filter[,15]),"_",as.character(RM_file_filter[,18]))
RM_bed <- cbind(rep("chr1",length(RM_info)),RM_file_filter[,c(7,8)],RM_info)
write.table(RM_bed,"chr1_RM_UCSC_90_match.bed",quote = F,sep = "\t",row.names = F,col.names = F)
