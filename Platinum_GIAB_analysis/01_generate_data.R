read_TR_Platinum <- function(file_path,file_type)
{
  if (grepl("NA1287", file_path, fixed = TRUE))
  {
    chr_name <- c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X")
  }
  else
  {
    chr_name <- c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22")
  }
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
  for (chromosome in chr_name)
  {
    print(chromosome)
    file_name <- paste0(file_path,chromosome,file_type)
    file_chr <- read.table(file_name,header = T, sep = "\t",quote=NULL)
    file_SNP <- file_chr[nchar(as.character(file_chr[,"REF"]))==nchar(as.character(file_chr[,"ALT"])),]
    file_DEL <- file_chr[nchar(as.character(file_chr[,"REF"]))>nchar(as.character(file_chr[,"ALT"])),]
    file_INS <- file_chr[nchar(as.character(file_chr[,"REF"]))<nchar(as.character(file_chr[,"ALT"])),]
    total_SNP=total_SNP+dim(file_SNP)[1]
    total_DEL=total_DEL+dim(file_DEL)[1]
    total_INS=total_INS+dim(file_INS)[1]
    
    file_TR <- file_chr[as.character(file_chr[,"Motifs"])!="",]
    
    file_TR_SNP <- file_TR[nchar(as.character(file_TR[,"REF"]))==nchar(as.character(file_TR[,"ALT"])),]
    TR_SNP=TR_SNP+dim(file_TR_SNP)[1]
    file_TR_DEL <- file_TR[nchar(as.character(file_TR[,"REF"]))>nchar(as.character(file_TR[,"ALT"])),]
    TR_DEL=TR_DEL+dim(file_TR_DEL)[1]
    file_TR_INS <- file_TR[nchar(as.character(file_TR[,"REF"]))<nchar(as.character(file_TR[,"ALT"])),]
    TR_INS=TR_INS+dim(file_TR_INS)[1]
    
    copy_num <- as.numeric(unlist(strsplit(as.character(file_TR$Copy_number),",")))
    size <- as.numeric(unlist(strsplit(as.character(file_TR$Size),",")))
    copy_num_all <- c(copy_num_all,copy_num)
    size_all <- c(size_all,size)
    
    file_TR_DEL <- file_TR_DEL[!(grepl(",", file_TR_DEL[,"Size"], fixed = TRUE)),]
    file_TR_INS <- file_TR_INS[!(grepl(",", file_TR_INS[,"Size"], fixed = TRUE)),]
    indel_type <- c(rep(1,dim(file_TR_DEL)[1]),rep(2,dim(file_TR_INS)[1]))
    indel_length <- c(nchar(as.character(file_TR_DEL[,"REF"]))-nchar(as.character(file_TR_DEL[,"ALT"])),
                      nchar(as.character(file_TR_INS[,"ALT"]))-nchar(as.character(file_TR_INS[,"REF"])))
    indel_rp_size <- c(as.numeric(as.character(file_TR_DEL[,"Size"])),as.numeric(as.character(file_TR_INS[,"Size"])))
    indel_length_all <- c(indel_length_all,indel_length)
    indel_type_all <- c(indel_type_all,indel_type)
    indel_rp_size_all <- c(indel_rp_size_all,indel_rp_size)
  }
  TR_percentage <- c(TR_SNP,TR_DEL,TR_INS,total_SNP-TR_SNP,total_DEL-TR_DEL,total_INS-TR_INS)

  size_cn <- as.data.frame(cbind(copy_num_all,as.character(size_all)))
  size_cn$copy_num_all <- as.numeric(as.character(size_cn$copy_num_all))
  
  ratio <- as.data.frame(cbind(indel_length_all,indel_rp_size_all,indel_type_all))
  colnames(ratio) <- c("indel_length","size","Type")

  results <- list(TR_percentage,size_cn,ratio)
  return(results)
}

NA12877_TR_p <- read_TR_Platinum("/Platinum/NA12877/05_03_2022_chr","_p.txt")
NA12878_TR_p <- read_TR_Platinum("/Platinum/NA12878/05_03_2022_chr","_p.txt")
HG002_TR_p <- read_TR_Platinum("/GIAB/HG002/05_03_2022_chr","_p.txt")
HG003_TR_p <- read_TR_Platinum("/GIAB/HG003/05_03_2022_chr","_p.txt")
HG004_TR_p <- read_TR_Platinum("/GIAB/HG004/05_03_2022_chr","_p.txt")
HG005_TR_p <- read_TR_Platinum("/GIAB/HG005/05_03_2022_chr","_p.txt")
HG006_TR_p <- read_TR_Platinum("/GIAB/HG006/05_03_2022_chr","_p.txt")
HG007_TR_p <- read_TR_Platinum("/GIAB/HG007/05_03_2022_chr","_p.txt")
