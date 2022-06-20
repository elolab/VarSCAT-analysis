chromosome_list <- chromosome_list <- c(as.character(seq(1,22)),"X")
repeat_af_p <- vector()
non_repeat_af_p <- vector()
for (i in chromosome_list)
{
  print(i)
  common_path <- paste0("/TR_Tag")
  chr_result_name <- paste0(common_path,"/chr",i,"_results_df_2.txt")
  chr_result <- read.table(chr_result_name,header = T,sep = "\t")
  repeat_af <- chr_result[chr_result[,1]==4|chr_result[,1]==5|chr_result[,1]==6,c(1,2,3,4,5,6,7)]
  non_repeat_af <- chr_result[chr_result[,1]==1|chr_result[,1]==2|chr_result[,1]==3,c(1,2,3,4,5,6,7)]
  # filter out rare variants
  repeat_af2 <- repeat_af[repeat_af[,2]!=0 | repeat_af[,3]!=0 | repeat_af[,4]!=0 | repeat_af[,5]!=0 |
                            repeat_af[,6]!=0 | repeat_af[,7]!=0,]
  non_repeat_af2 <- non_repeat_af[non_repeat_af[,2]!=0 | non_repeat_af[,3]!=0 | non_repeat_af[,4]!=0 | 
                                    non_repeat_af[,5]!=0 | non_repeat_af[,6]!=0 | non_repeat_af[,7]!=0,]
  repeat_af_p <- rbind(repeat_af_p,repeat_af2)
  non_repeat_af_p <- rbind(non_repeat_af_p,non_repeat_af2)
}
write.table(repeat_af_p[,2],"/AF_filtered_splited/AF_P.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(repeat_af_p[,3],"/AF_filtered_splited/AF_P_EAS.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(repeat_af_p[,4],"/AF_filtered_splited/AF_P_EUR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(repeat_af_p[,5],"/AF_filtered_splited/AF_P_AFR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(repeat_af_p[,6],"/AF_filtered_splited/AF_P_AMR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(repeat_af_p[,7],"/AF_filtered_splited/AF_P_SAS.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,2],"/AF_filtered_splited/non_AF_P.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,3],"/AF_filtered_splited/non_AF_P_EAS.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,4],"/AF_filtered_splited/non_AF_P_EUR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,5],"/AF_filtered_splited/non_AF_P_AFR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,6],"/AF_filtered_splited/non_AF_P_AMR.txt",quote = F,sep = "\t",row.names = F,col.names = T)
write.table(non_repeat_af_p[,7],"/AF_filtered_splited/non_AF_P_SAS.txt",quote = F,sep = "\t",row.names = F,col.names = T)
