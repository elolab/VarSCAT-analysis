read_TR_Platinum <- function(file_name)
{
  total_SNP=0
  total_DEL=0
  total_INS=0
  TR_SNP=0
  TR_DEL=0
  TR_INS=0
  copy_num_all <- vector()
  size_all <- vector()
  indel_length_all <- vector()
  indel_type_all <- vector()
  indel_rp_size_all <- vector()

  file_chr <- read.table(file_name,header = T, sep = "\t",quote=NULL)
  file_SNP <- file_chr[nchar(as.character(file_chr[,"REF"]))==nchar(as.character(file_chr[,"ALT"])),]
  file_DEL <- file_chr[nchar(as.character(file_chr[,"REF"]))>nchar(as.character(file_chr[,"ALT"])),]
  file_INS <- file_chr[nchar(as.character(file_chr[,"REF"]))<nchar(as.character(file_chr[,"ALT"])),]
  total_SNP=dim(file_SNP)[1]
  total_DEL=dim(file_DEL)[1]
  total_INS=dim(file_INS)[1]
  
  file_TR <- file_chr[as.character(file_chr[,"Motifs"])!="",]
  
  file_TR_SNP <- file_TR[nchar(as.character(file_TR[,"REF"]))==nchar(as.character(file_TR[,"ALT"])),]
  TR_SNP=dim(file_TR_SNP)[1]
  file_TR_DEL <- file_TR[nchar(as.character(file_TR[,"REF"]))>nchar(as.character(file_TR[,"ALT"])),]
  TR_DEL=dim(file_TR_DEL)[1]
  file_TR_INS <- file_TR[nchar(as.character(file_TR[,"REF"]))<nchar(as.character(file_TR[,"ALT"])),]
  TR_INS=dim(file_TR_INS)[1]
  
  copy_num_all <- as.numeric(unlist(strsplit(as.character(file_TR$Copy_number),",")))
  size_all <- as.numeric(unlist(strsplit(as.character(file_TR$Size),",")))

  
  file_TR_DEL <- file_TR_DEL[!(grepl(",", file_TR_DEL[,"Size"], fixed = TRUE)),]
  file_TR_INS <- file_TR_INS[!(grepl(",", file_TR_INS[,"Size"], fixed = TRUE)),]
  indel_type_all <- c(rep(1,dim(file_TR_DEL)[1]),rep(2,dim(file_TR_INS)[1]))
  indel_length_all <- c(nchar(as.character(file_TR_DEL[,"REF"]))-nchar(as.character(file_TR_DEL[,"ALT"])),
                    nchar(as.character(file_TR_INS[,"ALT"]))-nchar(as.character(file_TR_INS[,"REF"])))
  indel_rp_size_all <- c(as.numeric(as.character(file_TR_DEL[,"Size"])),as.numeric(as.character(file_TR_INS[,"Size"])))

  TR_percentage <- c(TR_SNP,TR_DEL,TR_INS,total_SNP-TR_SNP,total_DEL-TR_DEL,total_INS-TR_INS)
  
  size_cn <- as.data.frame(cbind(copy_num_all,as.character(size_all)))
  size_cn$copy_num_all <- as.numeric(as.character(size_cn$copy_num_all))
  
  ratio <- as.data.frame(cbind(indel_length_all,indel_rp_size_all,indel_type_all))
  colnames(ratio) <- c("indel_length","size","Type")
  
  results <- list(TR_percentage,size_cn,ratio)
  return(results)
}

NA12877_TR_p <- read_TR_Platinum("./Platinum/Revision/NA12877.txt")
NA12878_TR_p <- read_TR_Platinum("./Platinum/Revision/NA12878.txt")
HG002_TR_p <- read_TR_Platinum("./GIAB/Revision/HG002.txt")
HG003_TR_p <- read_TR_Platinum("./GIAB/Revision/HG003.txt")
HG004_TR_p <- read_TR_Platinum("./GIAB/Revision/HG004.txt")
HG005_TR_p <- read_TR_Platinum("./GIAB/Revision/HG005.txt")
HG006_TR_p <- read_TR_Platinum("./GIAB/Revision/HG006.txt")
HG007_TR_p <- read_TR_Platinum("./GIAB/Revision/HG007.txt")

save.image("Data.RData")

# The proportion of indels that only span on one STR
a <- dim(HG002_TR_p[[3]])[1]/sum(HG002_TR_p[[1]][2:3])+ 
dim(HG003_TR_p[[3]])[1]/sum(HG003_TR_p[[1]][2:3])+ 
dim(HG004_TR_p[[3]])[1]/sum(HG004_TR_p[[1]][2:3])+ 
dim(HG005_TR_p[[3]])[1]/sum(HG005_TR_p[[1]][2:3])+ 
dim(HG006_TR_p[[3]])[1]/sum(HG006_TR_p[[1]][2:3])+ 
dim(HG007_TR_p[[3]])[1]/sum(HG007_TR_p[[1]][2:3])+ 
dim(NA12877_TR_p[[3]])[1]/sum(NA12877_TR_p[[1]][2:3])+ 
dim(NA12878_TR_p[[3]])[1]/sum(NA12878_TR_p[[1]][2:3])
a/8
