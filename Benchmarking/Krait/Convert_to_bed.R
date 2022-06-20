SSR <- read.table("Krait_GRCh38_GIAB_chr1_perfect_SSR.txt",header = T,sep = "\t")
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



















































































































