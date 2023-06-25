library(readr)

# Names are manually changed
sample <- "NA12878"
UPS_name <- paste("./",sample,"_UPS.uvcf",sep = "")
UPS.indel <- read.table(UPS_name,sep = "\t")
UPS.indel <- UPS.indel[,c(1,2,4,5,8)]
UPS.indel <- UPS.indel[!grepl("N",as.character(UPS.indel[,5])),]
UPS.indel <- UPS.indel[!(as.character(UPS.indel[,4])=="*"),]
ups.corrdination <- strsplit(as.character(UPS.indel[,5])," - ")
ups.left <- unlist(lapply(ups.corrdination, `[[`, 1))
ups.left <- substr(ups.left,2,nchar(ups.left))
ups.left <- parse_number(ups.left)
ups.right <- unlist(lapply(ups.corrdination, `[[`, 2))
ups.right <- parse_number(ups.right)
UPS.indel <- cbind(UPS.indel,ups.left,ups.right)
UPS.indel[nchar(as.character(UPS.indel[,3]))<nchar(as.character(UPS.indel[,4])),c(6,7)] <- UPS.indel[nchar(as.character(UPS.indel[,3]))<nchar(as.character(UPS.indel[,4])),c(6,7)]-1
rownames(UPS.indel) <- NULL
ID_UPS <- paste(as.character(UPS.indel[,1]),as.character(UPS.indel[,2]), #as.character(UPS.indel[,3]),as.character(UPS.indel[,4]),
                as.character(UPS.indel[,6]),as.character(UPS.indel[,7]))
ID_vt_UPS <- paste(as.character(vt_UPS.indel[,1]),as.character(vt_UPS.indel[,2]),# as.character(vt_UPS.indel[,3]),as.character(vt_UPS.indel[,4]),
                   as.character(vt_UPS.indel[,6]),as.character(vt_UPS.indel[,7]))
ID_UPS[duplicated(ID_UPS)] <- paste(ID_UPS[duplicated(ID_UPS)],"_",sep = "")


VarSCAT_name <- paste("./VarSCAT_",sample,".txt",sep = "")
VarSCAT.indel <- read.table(VarSCAT_name,sep = "\t",header = T,quote = NULL)
VarSCAT.indel <- VarSCAT.indel[!(as.character(VarSCAT.indel[,4])=="*"),]
VarSCAT.indel <- VarSCAT.indel[nchar(as.character(VarSCAT.indel[,3]))!=nchar(as.character(VarSCAT.indel[,4])),]
rownames(VarSCAT.indel) <- NULL
ID_VarSCAT <- paste(as.character(VarSCAT.indel[,1]),as.character(VarSCAT.indel[,2]), #as.character(VarSCAT.indel[,3]),as.character(VarSCAT.indel[,4]),
                    as.character(VarSCAT.indel[,6]),as.character(VarSCAT.indel[,7]))
ID_VarSCAT[duplicated(ID_VarSCAT)] <- paste(ID_VarSCAT[duplicated(ID_VarSCAT)],"_",sep = "")

vt_UPS_name <- paste("./normalized_UPS_",sample,".uvcf",sep = "")
vt_UPS.indel <- read.table(vt_UPS_name,sep = "\t")
vt_UPS.indel <- vt_UPS.indel[,c(1,2,4,5,8)]
vt_UPS.indel <- vt_UPS.indel[!grepl("N",as.character(vt_UPS.indel[,5])),]
vt_UPS.indel <- vt_UPS.indel[!(as.character(vt_UPS.indel[,4])=="*"),]
vt_ups.corrdination <- strsplit(as.character(vt_UPS.indel[,5])," - ")
vt_ups.left <- unlist(lapply(vt_ups.corrdination, `[[`, 1))
vt_ups.left <- substr(vt_ups.left,2,nchar(vt_ups.left))
vt_ups.left <- parse_number(vt_ups.left)
vt_ups.right <- unlist(lapply(vt_ups.corrdination, `[[`, 2))
vt_ups.right <- parse_number(vt_ups.right)
vt_UPS.indel <- cbind(vt_UPS.indel,vt_ups.left,vt_ups.right)
vt_UPS.indel[nchar(as.character(vt_UPS.indel[,3]))<nchar(as.character(vt_UPS.indel[,4])),c(6,7)] <- vt_UPS.indel[nchar(as.character(vt_UPS.indel[,3]))<nchar(as.character(vt_UPS.indel[,4])),c(6,7)]-1
rownames(vt_UPS.indel) <- NULL
ID_vt_UPS <- paste(as.character(vt_UPS.indel[,1]),as.character(vt_UPS.indel[,2]),# as.character(vt_UPS.indel[,3]),as.character(vt_UPS.indel[,4]),
                   as.character(vt_UPS.indel[,6]),as.character(vt_UPS.indel[,7]))
ID_vt_UPS[duplicated(ID_vt_UPS)] <- paste(ID_vt_UPS[duplicated(ID_vt_UPS)],"_",sep = "")

library(ggVennDiagram)
library(ggplot2)
z = list("VarSCAT"=sample(ID_VarSCAT),"UPS-indel"=sample(ID_UPS), "UPS-indel(normalized)"=sample(ID_vt_UPS))
tiff(paste("vennDiagram_",sample,"_VarSCAT_UPS.tiff",sep=""),width = 70,height = 70,res = 300, units = "mm")
ggVennDiagram(z,label = "count",set_color = "white",set_size = 2,label_alpha=0,label_size = 3,edge_size = 1, 
              category.names = c("VarSCAT","UPS-indel","UPS-indel(normalized)"))+ 
  scale_fill_gradient(low = "#F4FAFE", high = "#F4FAFE")+
  theme(legend.position = "none")
dev.off() 

diff_U <- UPS.indel[ID_UPS!=ID_vt_UPS,]
diff_U <- diff_U[!(duplicated(diff_U[,2])),]
diff_V <- UPS.indel[ID_vt_UPS!=ID_VarSCAT,]
output_diff <- cbind(VarSCAT.indel[row.names(VarSCAT.indel) %in% row.names(diff_U),c(1,2,3,4,6,7)],
                     UPS.indel[row.names(UPS.indel) %in% row.names(diff_U),c(1,2,3,4,6,7)],
                     vt_UPS.indel[row.names(vt_UPS.indel) %in% row.names(diff_U),c(1,2,3,4,6,7)])
colnames(output_diff) <- c(rep(c("Chromosome","Position","REF","ALT","5'_align","3'_align"),3))
output_diff2 <- cbind(VarSCAT.indel[row.names(VarSCAT.indel) %in% row.names(diff_V),c(1,2,3,4,6,7)],
                      UPS.indel[row.names(UPS.indel) %in% row.names(diff_V),c(1,2,3,4,6,7)],
                      vt_UPS.indel[row.names(vt_UPS.indel) %in% row.names(diff_V),c(1,2,3,4,6,7)])
colnames(output_diff2) <- c(rep(c("Chromosome","Position","REF","ALT","5'_align","3'_align"),3))
output_diff <- rbind(output_diff,output_diff2)
output_diff[] <- lapply(output_diff, as.character)
output_diff[,1] <- paste("chr",output_diff[,1],sep = "")
output_diff[,7] <- paste("chr",output_diff[,7],sep = "")
output_diff[,13] <- paste("chr",output_diff[,13],sep = "")
write.table(output_diff,paste(sample,"_v_U.txt"),quote = F, sep = "\t",row.names = F,col.names = TRUE)
