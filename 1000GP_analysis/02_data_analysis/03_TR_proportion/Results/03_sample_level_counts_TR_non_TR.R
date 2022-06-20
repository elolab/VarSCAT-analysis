args <- commandArgs(trailingOnly = TRUE)
srcFile <- args[1]
output_name <- args[2]
sample_list <- read.table(srcFile,header = F)
sample_list <- sample_list[,1]
chromosome_list <- paste0("chr",c(seq(1,22),"X"))

variant_category_list <- vector()
for (i in 1:length(chromosome_list))
{
  print(i)
  variant_file <- paste0("/TR_Tag/",
                         chromosome_list[i],"_results_df_2.txt")
  variant_category <- read.table(variant_file,header = T)
  variant_category_list <- append(variant_category_list,list(variant_category[,1]))
  rm(variant_category)
}

sample_df <- vector()
for (sample in sample_list)
{
  sample_summary <- vector()
  TR_SNP <- 0
  TR_DEL <- 0
  TR_INS <- 0
  NON_TR_SNP<- 0
  NON_TR_DEL <- 0
  NON_TR_INS <- 0
  for (i in 1:length(chromosome_list))
  {
    location <- paste0("/1000GP/",chromosome_list[i],"/GP/")
    
    file_GP <- paste0(location,sample,".txt")
    GP <- read.table(file_GP,header = F)
    variant_GP <- cbind(variant_category_list[[i]],GP)
    rm(GP)
    variant_GP <- variant_GP[variant_GP[,2]!="0|0",]
    TR_SNP <- TR_SNP + dim(variant_GP[variant_GP[,1]==4,])[1]
    TR_DEL <- TR_DEL + dim(variant_GP[variant_GP[,1]==5,])[1]
    TR_INS <- TR_INS + dim(variant_GP[variant_GP[,1]==6,])[1]
    NON_TR_SNP <- NON_TR_SNP + dim(variant_GP[variant_GP[,1]==1,])[1]
    NON_TR_DEL <- NON_TR_DEL + dim(variant_GP[variant_GP[,1]==2,])[1]
    NON_TR_INS <- NON_TR_INS + dim(variant_GP[variant_GP[,1]==3,])[1]
    rm(variant_GP)
  }
  sample_summary <- c(TR_SNP,TR_DEL,TR_INS,NON_TR_SNP,NON_TR_DEL,NON_TR_INS)
  sample_df <- rbind(sample_df,sample_summary)
}
row.names(sample_df) <- sample_list
colnames(sample_df) <- c("TR_SNP","TR_DEL","TR_INS","NON_TR_SNP","NON_TR_DEL","NON_TR_INS")
output_name <- args[2]
write.table(sample_df,output_name,quote = F,row.names = T,col.names = T,sep = "\t")
