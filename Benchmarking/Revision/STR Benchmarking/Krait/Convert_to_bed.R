SSR <- read.table("Krait_chr1_perfect_SSR.txt",header = T,sep = "\t")
SSR <- SSR[SSR$type<=6,]
SSR <- SSR[SSR$length>=10,]
SSR <- SSR[!(SSR$type==3 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==4 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==5 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==6 & SSR$repeat.<4),]
bed_string <- paste0(as.character(SSR[,2]),"_",as.character(SSR[,4]),"_",as.character(SSR[,5]),"_",as.character(SSR[,6]),"_",
                     as.character(SSR[,7]),"_",as.character(SSR[,8]),"_",as.character(SSR[,9]))
bed_file <- cbind(as.character(SSR[,2]),SSR[,7],SSR[,8],bed_string)
bed_file <- as.data.frame(bed_file)
write.table(bed_file,"chr1_Krait_SSR_05_03.bed",row.names = F,col.names = F,quote = F,sep = "\t")


# Revision
SSR <- read.table("Krait_chr1_perfect_SSR.txt",header = T,sep = "\t")
SSR <- SSR[SSR$type<=6,]
SSR <- SSR[SSR$length>=10,]
SSR <- SSR[!(SSR$type==3 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==4 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==5 & SSR$repeat.<4),]
SSR <- SSR[!(SSR$type==6 & SSR$repeat.<4),]
bed_string <- paste0(as.character(SSR[,2]),"_",as.character(SSR[,4]),"_",as.character(SSR[,5]),"_",as.character(SSR[,6]),"_",
                     as.character(SSR[,7]),"_",as.character(SSR[,8]),"_",as.character(SSR[,9]))
bed_file <- cbind(as.character(SSR[,2]),SSR[,7],SSR[,8],bed_string)
bed_file <- as.data.frame(bed_file)

iSSR <- read.table("Krait_chr1_imperfect_SSR.txt",header = T,sep = "\t")
iSSR <- iSSR[iSSR$type<=6,]
iSSR <- iSSR[iSSR$length>=10,]
iSSR <- iSSR[!(iSSR$type==3 & ((iSSR$length)/(iSSR$type))<4),]
iSSR <- iSSR[!(iSSR$type==4 & ((iSSR$length)/(iSSR$type))<4),]
iSSR <- iSSR[!(iSSR$type==5 & ((iSSR$length)/(iSSR$type))<4),]
iSSR <- iSSR[!(iSSR$type==6 & ((iSSR$length)/(iSSR$type))<4),]
iSSR <- iSSR[(iSSR$match/iSSR$length)>=0.9,]
bed_string <- paste0(as.character(iSSR[,2]),"_",as.character(iSSR[,4]),"_",as.character(iSSR[,5]),"_",as.character(iSSR[,6]),"_",
                     as.character(iSSR[,7]),"_",as.character(iSSR[,8]),"_",as.character(iSSR[,9]))
bed_file_make <- cbind(as.character(iSSR[,2]),iSSR[,7],iSSR[,8],bed_string)
bed_file_make <- as.data.frame(bed_file_make)
bed_file_90 <- rbind(bed_file,bed_file_make)
write.table(bed_file_90,"chr1_Krait_SSR_iSSR90_revision.bed",row.names = F,col.names = F,quote = F,sep = "\t")
