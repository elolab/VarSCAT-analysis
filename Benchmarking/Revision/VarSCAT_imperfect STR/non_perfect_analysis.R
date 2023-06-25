options(scipen=999)
library(ggplot2)
library(tidyr)
positions <- colnames(data)

data2 <- vector()
for (i in 1:dim(data)[2])
{
  name_T <- colnames(data)[i]
  for (j in 1:dim(data)[1])
  {
    item <- c(substr(name_T,9,nchar(name_T)),substr(row.names(data)[j],11,nchar(row.names(data)[j])),as.numeric(data[j,i]))
    data2 <- rbind(data2,item)
  }
}
colnames(data2) <- c("match","motif","counts")
data2 <- as.data.frame(data2)
data2$motif <- factor(data2$motif,levels=c("6bp","5bp","4bp","3bp","2bp","1bp"))

p <- ggplot(data2,aes(fill=motif,y=as.numeric(as.character(counts)),x=match)) + 
  geom_bar(stat="identity",color="black",width = 0.75) +
  scale_x_discrete(limits = c("100% match","90% match")) +
  scale_fill_manual(values=c("#d73027","#e0f3f8","#fc8d59","#91bfdb","#fee090","#4575b4"),labels=c("6bp","5bp","4bp","3bp","2bp","1bp"))+
  xlab("VarSCAT HG002") + ylab("Numbers of annotated STR regions")+
  theme(
  axis.text.x = element_text(color = "black",size=18),
  axis.text.y = element_text(color = "black",size=18),
  axis.title.x = element_text(color = "black",size=20),
  axis.title.y = element_text(color = "black",size=20),
  legend.text = element_text(size=18),
  legend.title = element_text(size=18),
  panel.background = element_blank(),
  axis.line.x = element_line(colour="black",size=1),
  axis.line.y = element_blank(),
  axis.ticks.x = element_line(colour="black",size=1.25),
  panel.grid.minor = element_line(colour="gray", size=0.5)) 
p <- p + annotate("text", x = 1:2, y = as.numeric(colSums(data))+20000, label = as.character(colSums(data)),size=7)
p <- p + guides(fill=guide_legend(title="motif size"))
tiff("WG_VarSCAT_counts_100_90.tiff",width = 450,height = 550)
print(p)
dev.off()


# period boxplot
VarSCAT_preiod_perfect <- rbind(rep("100% match",length(period_perfect)),period_perfect,size_perfect)
VarSCAT_preiod_perfect <- t(VarSCAT_preiod_perfect)
colnames(VarSCAT_preiod_perfect) <- c("match","period","size")
VarSCAT_preiod_90 <- rbind(rep("90% match",length(period_90)),period_90,size_90)
VarSCAT_preiod_90 <- t(VarSCAT_preiod_90)
colnames(VarSCAT_preiod_90) <- c("match","period","size")
VarSCAT_period <- as.data.frame(rbind(VarSCAT_preiod_perfect,VarSCAT_preiod_90))

p <- ggplot(VarSCAT_period, aes(x=match, y=as.numeric(as.character(VarSCAT_period[,2])))) + 
  geom_boxplot(outlier.shape = NA,varwidth = 0.1) +
  coord_cartesian(ylim =  c(4,32)) +
  scale_x_discrete(limits = c("100% match","90% match"))+
  xlab("VarSCAT HG002") + ylab("Copy numbers of annotated STR regions")+
  theme(
    axis.text.x = element_text(color = "black",size=18),
    axis.text.y = element_text(color = "black",size=18),
    axis.title.x = element_text(color = "black",size=20),
    axis.title.y = element_text(color = "black",size=20),
    legend.text = element_text(size=20),
    legend.title = element_text(size=22),
    panel.background = element_blank(),
    axis.line.x = element_line(colour="black",size=1),
    axis.line.y = element_blank(),
    axis.ticks.x = element_line(colour="black",size=1.25),
    panel.grid.minor = element_line(colour="gray", size=0.5)) 
p <- p + annotate("text", x = 1:2, y = c(median(as.numeric(as.character(VarSCAT_period[VarSCAT_period[,1]=="100% match",2])))+1,
                                         median(as.numeric(as.character(VarSCAT_period[VarSCAT_period[,1]=="90% match",2])))+1),
                  label = c(round(mean(as.numeric(as.character(VarSCAT_period[VarSCAT_period[,1]=="100% match",2]))), digits = 2),
                            round(mean(as.numeric(as.character(VarSCAT_period[VarSCAT_period[,1]=="90% match",2]))), digits = 2)),
                  size=7)
tiff("WG_VarSCAT_period_100_90.tiff",width = 450,height = 550)
print(p)
dev.off()


# region boxplot
VarSCAT_region_perfect <- rbind(rep("100% match",length(region_perfect)),region_perfect,size_perfect)
VarSCAT_region_perfect <- t(VarSCAT_region_perfect)
colnames(VarSCAT_region_perfect) <- c("match","region","size")
VarSCAT_region_90 <- rbind(rep("90% match",length(region_90)),region_90,size_90)
VarSCAT_region_90 <- t(VarSCAT_region_90)
colnames(VarSCAT_region_90) <- c("match","region","size")
VarSCAT_region <- as.data.frame(rbind(VarSCAT_region_perfect,VarSCAT_region_90))

p <- ggplot(VarSCAT_region, aes(x=match, y=as.numeric(as.character(VarSCAT_region[,2])))) + 
  geom_boxplot(outlier.shape = NA,varwidth = 0.1) +
  coord_cartesian(ylim =  c(10,55)) +
  scale_x_discrete(limits = c("100% match","90% match"))+
  xlab("VarSCAT HG002") + ylab("Sizes of annotated STR regions")+
  theme(
    axis.text.x = element_text(color = "black",size=18),
    axis.text.y = element_text(color = "black",size=18),
    axis.title.x = element_text(color = "black",size=20),
    axis.title.y = element_text(color = "black",size=20),
    legend.text = element_text(size=20),
    legend.title = element_text(size=22),
    panel.background = element_blank(),
    axis.line.x = element_line(colour="black",size=1),
    axis.line.y = element_blank(),
    axis.ticks.x = element_line(colour="black",size=1.25),
    panel.grid.minor = element_line(colour="gray", size=0.5)) 
p <- p + annotate("text", x = 1:2, y = c(median(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="100% match",2])))+2,
                                         median(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="90% match",2])))+2),
                                         #median(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="80% match",2])))+2),
                  label = c(round(mean(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="100% match",2]))), digits = 2),
                            round(mean(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="90% match",2]))), digits = 2)),
                            #round(mean(as.numeric(as.character(VarSCAT_region[VarSCAT_region[,1]=="80% match",2]))), digits = 2)),
                  size=7)
tiff("WG_VarSCAT_region_100_90.tiff",width = 450,height = 550)
print(p)
dev.off()
