chromosome_list <- c(seq(1,22),"X")
EAS_TR_P <- vector()
EUR_TR_P <- vector()
AFR_TR_P <- vector()
AMR_TR_P <- vector()
SAS_TR_P <- vector()
EAS_non_TR_P <- vector()
EUR_non_TR_P <- vector()
AFR_non_TR_P <- vector()
AMR_non_TR_P <- vector()
SAS_non_TR_P <- vector()
for (item in chromosome_list)
{
  print(item)
  file_open_name <- paste0("./01_TR_Tag/","chr",item,"_results_df.txt")
  file_open <- read.table(file_open_name,header = T,sep = "\t")
  file_common <- file_open[file_open[,2]>=0.05|file_open[,3]>=0.05|file_open[,4]>=0.05|
                             file_open[,5]>=0.05|file_open[,6]>=0.05|file_open[,7]>=0.05,]
  remove(file_open)
  remove(file_open_name)
  
  file_TR_P <- file_common[file_common[,1]==4|file_common[,1]==5|file_common[,1]==6,]
  EAS_TR_P <- c(EAS_TR_P,file_TR_P[file_TR_P[,3]>=0.05,8])
  EUR_TR_P <- c(EUR_TR_P,file_TR_P[file_TR_P[,4]>=0.05,8])
  AFR_TR_P <- c(AFR_TR_P,file_TR_P[file_TR_P[,5]>=0.05,8])
  AMR_TR_P <- c(AMR_TR_P,file_TR_P[file_TR_P[,6]>=0.05,8])
  SAS_TR_P <- c(SAS_TR_P,file_TR_P[file_TR_P[,7]>=0.05,8])
  file_non_TR_P <- file_common[file_common[,1]==1|file_common[,1]==2|file_common[,1]==3,]
  EAS_non_TR_P <- c(EAS_non_TR_P,file_non_TR_P[file_non_TR_P[,3]>=0.05,8])
  EUR_non_TR_P <- c(EUR_non_TR_P,file_non_TR_P[file_non_TR_P[,4]>=0.05,8])
  AFR_non_TR_P <- c(AFR_non_TR_P,file_non_TR_P[file_non_TR_P[,5]>=0.05,8])
  AMR_non_TR_P <- c(AMR_non_TR_P,file_non_TR_P[file_non_TR_P[,6]>=0.05,8])
  SAS_non_TR_P <- c(SAS_non_TR_P,file_non_TR_P[file_non_TR_P[,7]>=0.05,8])
  
  remove(file_common)
  remove(file_TR_P)
  remove(file_non_TR_P)
}


TR.list_p = list("EAS"=EAS_TR_P,"EUR"=EUR_TR_P,"AFR"=AFR_TR_P,"AMR"=AMR_TR_P,"SAS"=SAS_TR_P)
non_TR.list_p = list("EAS"=EAS_non_TR_P,"EUR"=EUR_non_TR_P,"AFR"=AFR_non_TR_P,"AMR"=AMR_non_TR_P,"SAS"=SAS_non_TR_P)

save(TR.list_p,non_TR.list_p,file = "List_Data.RData")
































































