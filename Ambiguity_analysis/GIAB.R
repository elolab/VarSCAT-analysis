read_ambiguity_Platinum <- function(file_path)
{
  chr_name <- c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22")
  num_indels=0
  DEL_ambiguity=0
  INS_ambiguity=0
  DEL_unique=0
  INS_unique=0
  DEL_dup=0
  INS_dup=0
  DEL_non_dup=0
  INS_non_dup=0
  for (chromosome in chr_name)
  {
    print(chromosome)
    file_name <- paste0(file_path,"05_03_2022_chr",chromosome,"_p.txt")
    file_chr <- read.table(file_name,header = T, sep = "\t",quote = NULL)
    file_num_indel <- dim(file_chr[(nchar(as.character(file_chr$REF))-nchar(as.character(file_chr$ALT)))!=0,])[1]
    # complex del, ins
    file_DEL <- file_chr[(nchar(as.character(file_chr$REF))-nchar(as.character(file_chr$ALT)))>0,]
    file_DEL_ambiguity <- file_DEL[as.numeric(file_DEL$X5._aligned)!=as.numeric(file_DEL$X3._aligned),]
    file_DEL_dup <- file_DEL[(as.numeric(file_DEL$X3._aligned)-as.numeric(file_DEL$X5._aligned))>=
                               abs(nchar(as.character(file_DEL$REF))-nchar(as.character(file_DEL$ALT))),]
    file_INS <- file_chr[(nchar(as.character(file_chr$REF))-nchar(as.character(file_chr$ALT)))<0,]
    file_INS_ambiguity <- file_INS[as.numeric(file_INS$X5._aligned)!=as.numeric(file_INS$X3._aligned),]
    file_INS_dup <- file_INS[(as.numeric(file_INS$X3._aligned)-as.numeric(file_INS$X5._aligned))>=
                               abs(nchar(as.character(file_INS$REF))-nchar(as.character(file_INS$ALT))),]
    
    num_indels=num_indels+file_num_indel
    DEL_ambiguity=DEL_ambiguity+dim(file_DEL_ambiguity)[1]
    INS_ambiguity=INS_ambiguity+dim(file_INS_ambiguity)[1]
    DEL_unique=DEL_unique+(dim(file_DEL)[1]-dim(file_DEL_ambiguity)[1])
    INS_unique=INS_unique+(dim(file_INS)[1]-dim(file_INS_ambiguity)[1])
    DEL_dup=DEL_dup+dim(file_DEL_dup)[1]
    INS_dup=INS_dup+dim(file_INS_dup)[1]
    DEL_non_dup=DEL_non_dup+(dim(file_DEL)[1]-dim(file_DEL_dup)[1])
    INS_non_dup=INS_non_dup+(dim(file_INS)[1]-dim(file_INS_dup)[1])
    
  }
  results_list <- c(num_indels,DEL_ambiguity,INS_ambiguity,DEL_unique,INS_unique,
                    DEL_dup,INS_dup,DEL_non_dup,INS_non_dup)
  return(results_list)
}

HG002_ambiguity <- read_ambiguity_Platinum("/GIAB/HG002/")
HG002_ambiguity_del <- HG002_ambiguity[2]/HG002_ambiguity[1]
HG002_ambiguity_ins <- HG002_ambiguity[3]/HG002_ambiguity[1]
HG002_unique_del <- HG002_ambiguity[4]/HG002_ambiguity[1]
HG002_unique_ins <- HG002_ambiguity[5]/HG002_ambiguity[1]
HG002_dup_del <- HG002_ambiguity[6]/HG002_ambiguity[1]
HG002_dup_ins <- HG002_ambiguity[7]/HG002_ambiguity[1]
HG002_non_dup_del <- HG002_ambiguity[8]/HG002_ambiguity[1]
HG002_non_dup_ins <- HG002_ambiguity[9]/HG002_ambiguity[1]
HG002_group <- c(HG002_ambiguity_del,HG002_ambiguity_ins,HG002_unique_del,HG002_unique_ins,
                 HG002_dup_del,HG002_dup_ins,HG002_non_dup_del,HG002_non_dup_ins)

HG003_ambiguity <- read_ambiguity_Platinum("/GIAB/HG003/")
HG003_ambiguity_del <- HG003_ambiguity[2]/HG003_ambiguity[1]
HG003_ambiguity_ins <- HG003_ambiguity[3]/HG003_ambiguity[1]
HG003_unique_del <- HG003_ambiguity[4]/HG003_ambiguity[1]
HG003_unique_ins <- HG003_ambiguity[5]/HG003_ambiguity[1]
HG003_dup_del <- HG003_ambiguity[6]/HG003_ambiguity[1]
HG003_dup_ins <- HG003_ambiguity[7]/HG003_ambiguity[1]
HG003_non_dup_del <- HG003_ambiguity[8]/HG003_ambiguity[1]
HG003_non_dup_ins <- HG003_ambiguity[9]/HG003_ambiguity[1]
HG003_group <- c(HG003_ambiguity_del,HG003_ambiguity_ins,HG003_unique_del ,HG003_unique_ins,
                 HG003_dup_del,HG003_dup_ins,HG003_non_dup_del,HG003_non_dup_ins)

HG004_ambiguity <- read_ambiguity_Platinum("/GIAB/HG004/")
HG004_ambiguity_del <- HG004_ambiguity[2]/HG004_ambiguity[1]
HG004_ambiguity_ins <- HG004_ambiguity[3]/HG004_ambiguity[1]
HG004_unique_del <- HG004_ambiguity[4]/HG004_ambiguity[1]
HG004_unique_ins <- HG004_ambiguity[5]/HG004_ambiguity[1]
HG004_dup_del <- HG004_ambiguity[6]/HG004_ambiguity[1]
HG004_dup_ins <- HG004_ambiguity[7]/HG004_ambiguity[1]
HG004_non_dup_del <- HG004_ambiguity[8]/HG004_ambiguity[1]
HG004_non_dup_ins <- HG004_ambiguity[9]/HG004_ambiguity[1]
HG004_group <- c(HG004_ambiguity_del,HG004_ambiguity_ins,HG004_unique_del ,HG004_unique_ins,
                 HG004_dup_del,HG004_dup_ins,HG004_non_dup_del,HG004_non_dup_ins)

HG005_ambiguity <- read_ambiguity_Platinum("/GIAB/HG005/")
HG005_ambiguity_del <- HG005_ambiguity[2]/HG005_ambiguity[1]
HG005_ambiguity_ins <- HG005_ambiguity[3]/HG005_ambiguity[1]
HG005_unique_del <- HG005_ambiguity[4]/HG005_ambiguity[1]
HG005_unique_ins <- HG005_ambiguity[5]/HG005_ambiguity[1]
HG005_dup_del <- HG005_ambiguity[6]/HG005_ambiguity[1]
HG005_dup_ins <- HG005_ambiguity[7]/HG005_ambiguity[1]
HG005_non_dup_del <- HG005_ambiguity[8]/HG005_ambiguity[1]
HG005_non_dup_ins <- HG005_ambiguity[9]/HG005_ambiguity[1]
HG005_group <- c(HG005_ambiguity_del,HG005_ambiguity_ins,HG005_unique_del ,HG005_unique_ins,
                 HG005_dup_del,HG005_dup_ins,HG005_non_dup_del,HG005_non_dup_ins)

HG006_ambiguity <- read_ambiguity_Platinum("/GIAB/HG006/")
HG006_ambiguity_del <- HG006_ambiguity[2]/HG006_ambiguity[1]
HG006_ambiguity_ins <- HG006_ambiguity[3]/HG006_ambiguity[1]
HG006_unique_del <- HG006_ambiguity[4]/HG006_ambiguity[1]
HG006_unique_ins <- HG006_ambiguity[5]/HG006_ambiguity[1]
HG006_dup_del <- HG006_ambiguity[6]/HG006_ambiguity[1]
HG006_dup_ins <- HG006_ambiguity[7]/HG006_ambiguity[1]
HG006_non_dup_del <- HG006_ambiguity[8]/HG006_ambiguity[1]
HG006_non_dup_ins <- HG006_ambiguity[9]/HG006_ambiguity[1]
HG006_group <- c(HG006_ambiguity_del,HG006_ambiguity_ins,HG006_unique_del ,HG006_unique_ins,
                 HG006_dup_del,HG006_dup_ins,HG006_non_dup_del,HG006_non_dup_ins)

HG007_ambiguity <- read_ambiguity_Platinum("/GIAB/HG007/")
HG007_ambiguity_del <- HG007_ambiguity[2]/HG007_ambiguity[1]
HG007_ambiguity_ins <- HG007_ambiguity[3]/HG007_ambiguity[1]
HG007_unique_del <- HG007_ambiguity[4]/HG007_ambiguity[1]
HG007_unique_ins <- HG007_ambiguity[5]/HG007_ambiguity[1]
HG007_dup_del <- HG007_ambiguity[6]/HG007_ambiguity[1]
HG007_dup_ins <- HG007_ambiguity[7]/HG007_ambiguity[1]
HG007_non_dup_del <- HG007_ambiguity[8]/HG007_ambiguity[1]
HG007_non_dup_ins <- HG007_ambiguity[9]/HG007_ambiguity[1]
HG007_group <- c(HG007_ambiguity_del,HG007_ambiguity_ins,HG007_unique_del ,HG007_unique_ins,
                 HG007_dup_del,HG007_dup_ins,HG007_non_dup_del,HG007_non_dup_ins)

remove(HG002_ambiguity_del,HG002_ambiguity_ins,HG002_unique_del,HG002_unique_ins,HG002_dup_del,
       HG002_dup_ins,HG002_non_dup_del,HG002_non_dup_ins)
remove(HG003_ambiguity_del,HG003_ambiguity_ins,HG003_unique_del,HG003_unique_ins,HG003_dup_del,
       HG003_dup_ins,HG003_non_dup_del,HG003_non_dup_ins)
remove(HG004_ambiguity_del,HG004_ambiguity_ins,HG004_unique_del,HG004_unique_ins,HG004_dup_del,
       HG004_dup_ins,HG004_non_dup_del,HG004_non_dup_ins)
remove(HG005_ambiguity_del,HG005_ambiguity_ins,HG005_unique_del,HG005_unique_ins,HG005_dup_del,
       HG005_dup_ins,HG005_non_dup_del,HG005_non_dup_ins)
remove(HG006_ambiguity_del,HG006_ambiguity_ins,HG006_unique_del,HG006_unique_ins,HG006_dup_del,
       HG006_dup_ins,HG006_non_dup_del,HG006_non_dup_ins)
remove(HG007_ambiguity_del,HG007_ambiguity_ins,HG007_unique_del,HG007_unique_ins,HG007_dup_del,
       HG007_dup_ins,HG007_non_dup_del,HG007_non_dup_ins)
