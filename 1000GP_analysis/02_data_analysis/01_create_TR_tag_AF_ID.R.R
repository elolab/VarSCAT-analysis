chromosome_list <- c(as.character(seq(1,22)),"X")
n=0
results_df <- vector()
for (i in chromosome_list)
{
  print(i)
  common_path <- paste0("/VarSCAT-analysis/1000GP_analysis/01_data_process/chr",
                        i,"/",sep = "")
  chr_file_index <- paste0(common_path,"/",i,"_index.txt")
  index_file <- read.table(chr_file_index)
  
  if (i != "X")
  {
    results_af <- vector()
    for (j in 1:dim(index_file)[1])
    {
      file_name_af <- paste0(common_path,"AF/",index_file[j,],".txt")
      print(file_name_af)
      file_af <- read.table(file_name_af,header = T, sep = "\t",quote = NULL)
      file_af <- file_af[,c(1,2,3,4,5,6)]
      results_af <- rbind(results_af, file_af)
      remove(file_af)
    }
  }
  else if (i == "X")
  {
    file_name_af <- paste0(common_path,"AF_info.txt")
    print(file_name_af)
    results_af <- read.table(file_name_af,header = T, sep = "\t",quote = NULL)
    results_af <- results_af[,c(1,2,3,4,5,6)]
  }
  
  filename_p <- paste("/VarSCAT-analysis/1000GP_analysis/01_data_process/chr",
                       i,"/chr",i,"_1000.txt",sep = "")
  print(filename_p)
  results_p <- read.table(filename_p,header = T, sep = "\t",quote = NULL)
  results_p$type <- 1
  results_p$type[nchar(results_p$REF)>nchar(results_p$ALT)] <- 2
  results_p$type[nchar(results_p$REF)<nchar(results_p$ALT)] <- 3
  results_p$type[nchar(results_p$REF)==nchar(results_p$ALT) & results_p$Motifs!=""] <- 4
  results_p$type[nchar(results_p$REF)>nchar(results_p$ALT) & results_p$Motifs!=""] <- 5
  results_p$type[nchar(results_p$REF)<nchar(results_p$ALT) & results_p$Motifs!=""] <- 6
  results_p$ID_v <- seq(n,n+dim(results_p)[1]-1)
  n=n+dim(results_p)[1]
  
  results_df <- cbind(results_p$type,results_af,results_p$ID_v)

  colnames(results_df) <- c("p",colnames(results_af),"ID")
  output_name <- paste0("/VarSCAT-analysis/1000GP_analysis/02_data_analysis/01_TR_Tag/chr",i,"_results_df.txt")
  write.table(results_df,output_name,quote = F,sep = "\t",row.names = F,col.names = T)
}
