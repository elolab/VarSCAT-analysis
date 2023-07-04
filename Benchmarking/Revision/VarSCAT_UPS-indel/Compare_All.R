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
ID_UPS[duplicated(ID_UPS)] <- paste(ID_UPS[duplicated(ID_UPS)],"_",sep = "")


VarSCAT_name <- paste("./VarSCAT_",sample,".txt",sep = "")
VarSCAT.indel <- read.table(VarSCAT_name,sep = "\t",header = T,quote = NULL)
VarSCAT.indel <- VarSCAT.indel[!(as.character(VarSCAT.indel[,4])=="*"),]
VarSCAT.indel <- VarSCAT.indel[nchar(as.character(VarSCAT.indel[,3]))!=nchar(as.character(VarSCAT.indel[,4])),]
rownames(VarSCAT.indel) <- NULL
ID_VarSCAT <- paste(as.character(VarSCAT.indel[,1]),as.character(VarSCAT.indel[,2]), #as.character(VarSCAT.indel[,3]),as.character(VarSCAT.indel[,4]),
                    as.character(VarSCAT.indel[,6]),as.character(VarSCAT.indel[,7]))
ID_VarSCAT[duplicated(ID_VarSCAT)] <- paste(ID_VarSCAT[duplicated(ID_VarSCAT)],"_",sep = "")

library(ggVennDiagram)
library(ggplot2)
z = list("VarSCAT"=sample(ID_VarSCAT),"UPS-indel"=sample(ID_UPS), "UPS-indel(normalized)"=sample(ID_vt_UPS))
tiff(paste("vennDiagram_",sample,"_VarSCAT_UPS.tiff",sep=""),width = 70,height = 70,res = 300, units = "mm")
ggVennDiagram(z,label = "count",set_color = "white",set_size = 2,label_alpha=0,label_size = 3,edge_size = 1, 
              category.names = c("VarSCAT","UPS-indel","UPS-indel(normalized)"))+ 
  scale_fill_gradient(low = "#F4FAFE", high = "#F4FAFE")+
  theme(legend.position = "none")
dev.off() 
