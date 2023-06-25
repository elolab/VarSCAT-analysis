file <- read.table("varscan_whole.vcf.gz")
file_FN <- file[grepl("FN",file[,10]),]
file_FP <- file[grepl("FP",file[,11]),]
file_TP <- file[grepl("TP",file[,10]),]
write.table(file_FN,"varscan_FN.vcf",quote = F, sep = "\t",row.names = F,col.names = F)
write.table(file_FP,"varscan_FP.vcf",quote = F, sep = "\t",row.names = F,col.names = F)
write.table(file_TP,"varscan_TP.vcf",quote = F, sep = "\t",row.names = F,col.names = F)

file <- read.table("GATK_whole.vcf.gz")
file_FN <- file[grepl("FN",file[,10]),]
file_FP <- file[grepl("FP",file[,11]),]
file_TP <- file[grepl("TP",file[,11]),]
write.table(file_FN,"GATK_FN.vcf",quote = F, sep = "\t",row.names = F,col.names = F)
write.table(file_FP,"GATK_FP.vcf",quote = F, sep = "\t",row.names = F,col.names = F)
write.table(file_TP,"GATK_TP.vcf",quote = F, sep = "\t",row.names = F,col.names = F)
