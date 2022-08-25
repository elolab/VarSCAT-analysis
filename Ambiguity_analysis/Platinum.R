read_ambiguity_Platinum <- function(file_path)
{
  chr_name <- c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X")
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
    file_name <- paste0(file_path,"VarSCAT_chr",chromosome,".txt")
    file_chr <- read.table(file_name,header = T, sep = "\t", quote=NULL)
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

NA12877_ambiguity <- read_ambiguity_Platinum("~/VarSCAT_analysis/Platinum_GIAB_analysis/Platinum/NA12877/")
NA12877_ambiguity_del <- NA12877_ambiguity[2]/NA12877_ambiguity[1]
NA12877_ambiguity_ins <- NA12877_ambiguity[3]/NA12877_ambiguity[1]
NA12877_unique_del <- NA12877_ambiguity[4]/NA12877_ambiguity[1]
NA12877_unique_ins <- NA12877_ambiguity[5]/NA12877_ambiguity[1]
NA12877_dup_del <- NA12877_ambiguity[6]/NA12877_ambiguity[1]
NA12877_dup_ins <- NA12877_ambiguity[7]/NA12877_ambiguity[1]
NA12877_non_dup_del <- NA12877_ambiguity[8]/NA12877_ambiguity[1]
NA12877_non_dup_ins <- NA12877_ambiguity[9]/NA12877_ambiguity[1]
NA12877_group <- c(NA12877_ambiguity_del,NA12877_ambiguity_ins,NA12877_unique_del ,NA12877_unique_ins,
                   NA12877_dup_del,NA12877_dup_ins,NA12877_non_dup_del,NA12877_non_dup_ins)

NA12878_ambiguity <- read_ambiguity_Platinum("~/VarSCAT_analysis/Platinum_GIAB_analysis/Platinum/NA12878/")
NA12878_ambiguity_del <- NA12878_ambiguity[2]/NA12878_ambiguity[1]
NA12878_ambiguity_ins <- NA12878_ambiguity[3]/NA12878_ambiguity[1]
NA12878_unique_del <- NA12878_ambiguity[4]/NA12878_ambiguity[1]
NA12878_unique_ins <- NA12878_ambiguity[5]/NA12878_ambiguity[1]
NA12878_dup_del <- NA12878_ambiguity[6]/NA12878_ambiguity[1]
NA12878_dup_ins <- NA12878_ambiguity[7]/NA12878_ambiguity[1]
NA12878_non_dup_del <- NA12878_ambiguity[8]/NA12878_ambiguity[1]
NA12878_non_dup_ins <- NA12878_ambiguity[9]/NA12878_ambiguity[1]
NA12878_group <- c(NA12878_ambiguity_del,NA12878_ambiguity_ins,NA12878_unique_del ,NA12878_unique_ins,
                   NA12878_dup_del,NA12878_dup_ins,NA12878_non_dup_del,NA12878_non_dup_ins)

remove(NA12877_ambiguity_del,NA12877_ambiguity_ins,NA12877_unique_del,NA12877_unique_ins,NA12877_dup_del,NA12877_dup_ins,
       NA12877_non_dup_del,NA12877_non_dup_ins)
remove(NA12878_ambiguity_del,NA12878_ambiguity_ins,NA12878_unique_del,NA12878_unique_ins,NA12878_dup_del,NA12878_dup_ins,
       NA12878_non_dup_del,NA12878_non_dup_ins)
