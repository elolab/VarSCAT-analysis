# Perfect STR annotation of HG002.txt by VarSCAT can be found under GIAB_Platinum_analysis folder
VarSCAT_perfect <- read.table("HG002.txt",header = T,sep = "\t",quote=NULL)
VarSCAT_perfect <- VarSCAT_perfect[VarSCAT_perfect$Repeat_Score!="",]
VarSCAT_perfect_redundant <- VarSCAT_perfect[grepl(",",VarSCAT_perfect$Motifs),]
region_perfect <- vector()
period_perfect <- vector()
size_perfect <- vector()
for (i in 1:dim(VarSCAT_perfect_redundant)[1])
{
  print(i)
  if (grepl(",",VarSCAT_perfect_redundant[i,12]))
  {
    period_string <- strsplit(as.character(VarSCAT_perfect_redundant[i,8]),",")
    size_string <- strsplit(as.character(VarSCAT_perfect_redundant[i,9]),",")
    start_string <- strsplit(as.character(VarSCAT_perfect_redundant[i,10]),",")
    end_string <- strsplit(as.character(VarSCAT_perfect_redundant[i,11]),",")
    for (j in 1:length(period_string[[1]]))
    {
      print(j)
      start1 <- as.numeric(as.character(start_string[[1]][j]))
      end1 <- as.numeric(as.character(end_string[[1]][j]))
      region_perfect <- c(region_perfect,end1-start1+1)
      period_perfect <- c(period_perfect,as.numeric(as.character(period_string[[1]][j])))
      size_perfect <- c(size_perfect,as.numeric(as.character(size_string[[1]][j])))
    }
  }
}
VarSCAT_perfect_clean <- VarSCAT_perfect[!(grepl(",",VarSCAT_perfect[,7])),]
start1 <- as.numeric(as.character(VarSCAT_perfect_clean[,10]))
end1 <- as.numeric(as.character(VarSCAT_perfect_clean[,11]))
region_perfect <- c(region_perfect,end1-start1+1)
period_perfect <- c(period_perfect,as.numeric(as.character(VarSCAT_perfect_clean[,8])))
size_perfect <- c(size_perfect,as.numeric(as.character(VarSCAT_perfect_clean[,9])))

# imperfect HG002 STR annotation by VarSCAT can be found under Benchmarking folder
VarSCAT_90 <- read.table("revision_90_HG002.txt",header = T,sep = "\t",quote=NULL)
VarSCAT_90 <- VarSCAT_90[VarSCAT_90[,12]!="",]
VarSCAT_90_redundant <- VarSCAT_90[grepl(",",VarSCAT_90[,7]),]
region_90 <- vector()
period_90 <- vector()
size_90 <- vector()
for (i in 1:dim(VarSCAT_90_redundant)[1])
{
  print(i)
  if (grepl(",",VarSCAT_90_redundant[i,12]))
  {
    period_string <- strsplit(as.character(VarSCAT_90_redundant[i,8]),",")
    size_string <- strsplit(as.character(VarSCAT_90_redundant[i,9]),",")
    start_string <- strsplit(as.character(VarSCAT_90_redundant[i,10]),",")
    end_string <- strsplit(as.character(VarSCAT_90_redundant[i,11]),",")
    for (j in 1:length(period_string[[1]]))
    {
      print(j)
      start1 <- as.numeric(as.character(start_string[[1]][j]))
      end1 <- as.numeric(as.character(end_string[[1]][j]))
      region_90 <- c(region_90,end1-start1+1)
      period_90 <- c(period_90,as.numeric(as.character(period_string[[1]][j])))
      size_90 <- c(size_90,as.numeric(as.character(size_string[[1]][j])))
    }
  }
}
VarSCAT_90_clean <- VarSCAT_90[!(grepl(",",VarSCAT_90[,7])),]
start1 <- as.numeric(as.character(VarSCAT_90_clean[,10]))
end1 <- as.numeric(as.character(VarSCAT_90_clean[,11]))
region_90 <- c(region_90,end1-start1+1)
period_90 <- c(period_90,as.numeric(as.character(VarSCAT_90_clean[,8])))
size_90 <- c(size_90,as.numeric(as.character(VarSCAT_90_clean[,9])))

V1 <- c(sum(size_perfect == 1),sum(size_perfect == 2),sum(size_perfect == 3),
        sum(size_perfect == 4),sum(size_perfect == 5),sum(size_perfect == 6))
V2 <- c(sum(size_90 == 1),sum(size_90 == 2),sum(size_90 == 3),
        sum(size_90 == 4),sum(size_90 == 5),sum(size_90 == 6))
data <- t(matrix(rbind(V1,V2), nrow=3))
row.names(data) <- c("STR motif 1bp","STR motif 2bp","STR motif 3bp",
                     "STR motif 4bp","STR motif 5bp","STR motif 6bp")
colnames(data) <- c("VarSCAT 100% match","VarSCAT 90% match")
