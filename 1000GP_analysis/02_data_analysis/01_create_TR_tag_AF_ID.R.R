output_path <- "./01_TR_Tag/"

chromosome_list <- as.character(seq(1,22))
n=0
for (i in chromosome_list)
{
  print(i)
  common_path <- paste0("~/VarSCAT_analysis/1000GP_analysis/01_data_process/chr",i)
  chr_file_index <- paste0(common_path,"/",i,"_index.txt")
  index_file <- read.table(chr_file_index)
  
  results_df <- vector()
  for (j in 1:dim(index_file)[1])
  {
    file_name_af <- paste0(common_path,"/",index_file[j,],".txt")
    print(file_name_af)
    results_af <- read.table(file_name_af,header = T, sep = "\t",quote = NULL)
    results_af <- results_af[,c(1,2,3,4,5,6)]
    
    file_name_p <- paste0(common_path,"/",index_file[j,],".txt")
    print(file_name_p)
    results_p <- read.table(file_name_p,header = T, sep = "\t",quote = NULL)
    results_p$type <- 1
    results_p$type[nchar(results_p$REF)>nchar(results_p$ALT)] <- 2
    results_p$type[nchar(results_p$REF)<nchar(results_p$ALT)] <- 3
    results_p$type[nchar(results_p$REF)==nchar(results_p$ALT) & results_p$Motifs!=""] <- 4
    results_p$type[nchar(results_p$REF)>nchar(results_p$ALT) & results_p$Motifs!=""] <- 5
    results_p$type[nchar(results_p$REF)<nchar(results_p$ALT) & results_p$Motifs!=""] <- 6
    results_p$ID <- seq(n,n+dim(results_p)[1]-1)
    n=n+dim(results_p)[1]
    
    results_df_index <- cbind(results_p$type,results_af,results_p$ID)
    results_df <- rbind(results_df,results_df_index)
  }
  colnames(results_df) <- c("p",colnames(results_af))
  output_name <- paste0(output_path,"/chr",i,"_results_df_2.txt")
  write.table(results_df,output_name,quote = F,sep = "\t",row.names = F,col.names = T)
}

common_path <- paste0("~/VarSCAT_analysis/1000GP_analysis/01_data_process/chr","X")
chr_file_index <- paste0(common_path,"/","X","_index.txt")
index_file <- read.table(chr_file_index)

file_name_af <- paste0(common_path,"/AF_info.txt")
print(file_name_af)
results_af <- read.table(file_name_af,header = T, sep = "\t",quote = NULL)
results_af <- results_af[,c(1,2,3,4,5,6)]

results_df <- vector()
results_ID <- vector()
for (j in 1:dim(index_file)[1])
{
  file_name_p <- paste0(common_path,"/",index_file[j,],".txt")
  print(file_name_p)
  results_p <- read.table(file_name_p,header = T, sep = "\t",quote = NULL)
  results_p$type <- 1
  results_p$type[nchar(results_p$REF)>nchar(results_p$ALT)] <- 2
  results_p$type[nchar(results_p$REF)<nchar(results_p$ALT)] <- 3
  results_p$type[nchar(results_p$REF)==nchar(results_p$ALT) & results_p$Motifs!=""] <- 4
  results_p$type[nchar(results_p$REF)>nchar(results_p$ALT) & results_p$Motifs!=""] <- 5
  results_p$type[nchar(results_p$REF)<nchar(results_p$ALT) & results_p$Motifs!=""] <- 6
  results_p$ID <- seq(n,n+dim(results_p)[1]-1)
  n=n+dim(results_p)[1]
  
  results_df <- c(results_df,results_p$type)
  results_ID <- c(results_ID,results_p$ID)
}
results_df <- cbind(results_df,results_af,results_ID)
colnames(results_df) <- c("p",colnames(results_af))
output_name <- paste0(output_path,"/chr","X","_results_df_2.txt")
write.table(results_df,output_name,quote = F,sep = "\t",row.names = F,col.names = T)
