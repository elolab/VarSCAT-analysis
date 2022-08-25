set.seed(1234)
chr_name <- c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X")
Indels_set <- vector()
for (i in 1:length(chr_name))
{
  file_name <- paste0("~/VarSCAT_analysis/Platinum_GIAB_analysis/Platinum/NA12878/VarSCAT_chr",i,".txt")
  Indel_results <- read.table(file_name,header = T,sep = "\t",quote=NULL)
  Indel_results <- Indel_results[nchar(as.character(Indel_results[,3]))!=nchar(as.character(Indel_results[,4])),]
  Indel_length <- nchar(as.character(Indel_results[,3]))-nchar(as.character(Indel_results[,4]))
  Indels_data <- cbind(rep(paste0("chr",chr_name[i]),length(Indel_length)),Indel_length)
  Indels_set <- rbind(Indels_set,Indels_data)
}
Indels_set <- cbind(Indels_set,rep("del",dim(Indels_set)[1]))
Indels_set[Indels_set[,2]<0,3] <- "ins"
Indels_set <- as.data.frame(Indels_set)

hg38_gap <- read.table("Gap_hg38.txt",header = T,sep = "\t")
# Get from: https://www.ncbi.nlm.nih.gov/grc/human/data
chromosome_length <- c(248956422,242193529,198295559,	190214555,181538259,170805979,159345973,145138636,138394717,133797422,
                       135086622,133275309,114364328,107043718,101991189,90338345,83257441,80373285,58617616,64444167,46709983,
                       50818468,156040895)
chr_no_gap_len <- vector()
for (i in 1:length(chr_name))
{
  chr_pick <- paste0("chr",chr_name[i])
  gap_chr <- hg38_gap[hg38_gap[,2]==chr_pick,]
  chr_no_gap_len <- c(chr_no_gap_len,(chromosome_length[i]-sum(gap_chr$size)))
}
Indel_random_position <- vector()

for (i in 1:length(chr_name))
{
  chr_pick <- paste0("chr",chr_name[i])
  number_indel <- dim(Indels_set[Indels_set[,1]==chr_pick,])[1]
  ramdom_pos <- sample(1:chr_no_gap_len[i], number_indel, replace=F)
  random_item <- cbind(rep(chr_pick,number_indel),ramdom_pos)
  random_item <- random_item[order(as.numeric(random_item[,2])),]
  
  gap_chr <- hg38_gap[hg38_gap[,2]==chr_pick,]
  gap_chr <- gap_chr[order(gap_chr[,3]),]
  for (j in 1:dim(gap_chr)[1])
  {
    random_item[as.numeric(as.character(random_item[,2]))>=gap_chr[j,3],2] <- as.numeric(as.character(random_item[as.numeric(as.character(random_item[,2]))>=gap_chr[j,3],2]))+gap_chr[j,7]
  }
  Indel_random_position <- rbind(Indel_random_position,random_item)
}
rows <- sample(nrow(Indels_set))
Indels_set <- Indels_set[rows, ]
Indel_random_position <- cbind(Indel_random_position,Indels_set[,c(2,3)])
rownames(Indel_random_position) <- NULL
colnames(Indel_random_position) <- c("chr","pos","len","type")
write.table(Indel_random_position,"Random_set.txt",row.names = F,col.names = T,quote = F, sep = "\t")
