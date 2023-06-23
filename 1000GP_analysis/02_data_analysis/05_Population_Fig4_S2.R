library("readxl")
library(ggplot2)
# http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/
sample_population <- read_excel("./20130606_sample_info.xlsx")
sample_population <- as.data.frame(sample_population[,c(1,3)])
sample_list <- read.table("./03_TR_proportion/sample_list.txt",header = F)
sample_list <- sample_list[,1]
sample_population <- sample_population[sample_population[,1] %in% sample_list,]
population_category1 <- unique(sample_population$Population)
population_category2 <- c("EUR","AFR","EAS","SAS","AMR") 

sample_population$Superpopulation <- "EUR"
sample_population$Superpopulation[sample_population$Population=="ESN"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="GWD"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="LWK"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="MSL"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="YRI"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="ACB"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="ASW"] <- "AFR"
sample_population$Superpopulation[sample_population$Population=="CDX"] <- "EAS"
sample_population$Superpopulation[sample_population$Population=="CHB"] <- "EAS"
sample_population$Superpopulation[sample_population$Population=="CHS"] <- "EAS"
sample_population$Superpopulation[sample_population$Population=="JPT"] <- "EAS"
sample_population$Superpopulation[sample_population$Population=="KHV"] <- "EAS"
sample_population$Superpopulation[sample_population$Population=="BEB"] <- "SAS"
sample_population$Superpopulation[sample_population$Population=="GIH"] <- "SAS"
sample_population$Superpopulation[sample_population$Population=="ITU"] <- "SAS"
sample_population$Superpopulation[sample_population$Population=="PJL"] <- "SAS"
sample_population$Superpopulation[sample_population$Population=="STU"] <- "SAS"
sample_population$Superpopulation[sample_population$Population=="CLM"] <- "AMR"
sample_population$Superpopulation[sample_population$Population=="MXL"] <- "AMR"
sample_population$Superpopulation[sample_population$Population=="PEL"] <- "AMR"
sample_population$Superpopulation[sample_population$Population=="PUR"] <- "AMR"
# https://pophuman.uab.cat/files/html/custom_DataDescription.html

results_df <- read.table("VarSCAT-analysis/1000GP_analysis/02_data_analysis/03_TR_proportion/perfect/output_sample.txt",
                         header = T,sep = "\t")

sample_population <- cbind(sample_population,results_df)

num_TR <- sample_population$TR_SNP+sample_population$TR_DEL+sample_population$TR_INS
num_non_TR <- sample_population$NON_TR_SNP+sample_population$NON_TR_DEL+sample_population$NON_TR_INS
percetage_TR <- num_TR/(num_TR+num_non_TR)
sample_population <- cbind(sample_population,num_TR)
sample_population <- cbind(sample_population,num_non_TR)
sample_population <- cbind(sample_population,percetage_TR)

num_INDEL <- sample_population$TR_DEL+sample_population$TR_INS
num_non_INDEL <- sample_population$NON_TR_DEL+sample_population$NON_TR_INS
percetage_INDEL <- num_INDEL/(num_INDEL+num_non_INDEL)
sample_population <- cbind(sample_population,num_INDEL)
sample_population <- cbind(sample_population,num_non_INDEL)
sample_population <- cbind(sample_population,percetage_INDEL)
sample_population <- sample_population[order(sample_population$Superpopulation),]

sample_population2 <- data.frame(Population=factor(sample_population$Population,levels=unique(sample_population$Population)), 
                                 Superpopulation=factor(sample_population$Superpopulation,levels=unique(sample_population$Superpopulation)),
                                 percetage_TR = sample_population$percetage_TR,
                                 percetage_INDEL = sample_population$percetage_INDEL)

average_TR <- c(as.integer(mean(sample_population$num_TR[sample_population$Superpopulation=="AFR"])),
                as.integer(mean(sample_population$num_TR[sample_population$Superpopulation=="AMR"])),
                as.integer(mean(sample_population$num_TR[sample_population$Superpopulation=="EAS"])),
                as.integer(mean(sample_population$num_TR[sample_population$Superpopulation=="EUR"])),
                as.integer(mean(sample_population$num_TR[sample_population$Superpopulation=="SAS"])))

average_INDEL <- c(as.integer(mean(sample_population$num_INDEL[sample_population$Superpopulation=="AFR"])),
                   as.integer(mean(sample_population$num_INDEL[sample_population$Superpopulation=="AMR"])),
                   as.integer(mean(sample_population$num_INDEL[sample_population$Superpopulation=="EAS"])),
                   as.integer(mean(sample_population$num_INDEL[sample_population$Superpopulation=="EUR"])),
                   as.integer(mean(sample_population$num_INDEL[sample_population$Superpopulation=="SAS"])))

y_location <- 0.0785

p <- ggplot(sample_population2, aes(x=Superpopulation, y=percetage_TR)) + 
  geom_boxplot(outlier.size = 1)
p <- p + labs(y = "Proportions of variants in STR regions", x = "Superpopulation")
p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
p <- p + theme(
  axis.text.x = element_text(color = "black",size=8,angle = 30),
  axis.text.y = element_text(color = "black",size=7),
  axis.title.x = element_text(size = 8),
  axis.title.y = element_text(size = 8),
  panel.background = element_blank(),
  panel.grid.minor = element_line(colour="gray", size=0.5),
  legend.title = element_blank(),
  legend.position="none")
p <- p + annotate("text", x = 1:5, y = y_location, label = average_TR,size=2.5)
p <- p + expand_limits(y=c(0.065, 0.0780))
p <- p + scale_x_discrete(labels=c("AFR"="African","AMR"="American","EAS"="East Asian","EUR"="European","SAS"="South Asian"))
tiff("Fig4A.tif",width = 85, height = 85, res=300,units = "mm")
print(p)
dev.off()

p <- ggplot(sample_population2, aes(x=Population, y=percetage_TR,fill=Superpopulation)) + 
  geom_boxplot(outlier.size = 0.5)
p <- p + labs(y = "Proportions of variants in STR regions")
p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
p <- p + theme(
  axis.text.x = element_text(color = "black",size=6,angle = 90, vjust = 0.5, hjust=1),
  axis.text.y = element_text(color = "black",size=7),
  axis.title.x = element_text(size = 8),
  axis.title.y = element_text(size = 8),
  panel.background = element_blank(),
  panel.grid.minor = element_line(colour="gray", size=0.5),
  legend.title = element_blank(),
  legend.position="none")
p <- p + scale_x_discrete(labels=unique(sample_population$Population))
p <- p + expand_limits(y=c(0.065, 0.0780))
tiff("S2 FigA.tif",width = 85, height = 85, res=300,units = "mm")
print(p)
dev.off()

y_location2 <- 0.388

p <- ggplot(sample_population2, aes(x=Superpopulation, y=percetage_INDEL)) + 
  geom_boxplot(outlier.size = 1)
p <- p + labs(y = "Proportions of Indels in STR regions", x = "Superpopulation")
p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
p <- p + theme(
  axis.text.x = element_text(color = "black",size=8,angle = 30),
  axis.text.y = element_text(color = "black",size=7),
  axis.title.x = element_text(size = 8),
  axis.title.y = element_text(size = 8),
  panel.background = element_blank(),
  panel.grid.minor = element_line(colour="gray", size=0.5),
  legend.title = element_blank(),
  legend.position="none")
p <- p + annotate("text", x = 1:5, y = y_location2, label = average_INDEL,size=2.5)
p <- p + expand_limits(y=c(0.340, 0.385))
p <- p + scale_x_discrete(labels=c("AFR"="African","AMR"="American","EAS"="East Asian","EUR"="European","SAS"="South Asian"))
tiff("Fig 4B.tif",width = 85, height = 85, res=300,units = "mm")
print(p)
dev.off()

p <- ggplot(sample_population2, aes(x=Population, y=percetage_INDEL,fill=Superpopulation)) + 
  geom_boxplot(outlier.size = 0.5)
p <- p + labs(y = "Proportions of Indels in STR regions")
p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
p <- p + theme(
  axis.text.x = element_text(color = "black",size=6,angle = 90, vjust = 0.5, hjust=1),
  axis.text.y = element_text(color = "black",size=7),
  axis.title.x = element_text(size = 8),
  axis.title.y = element_text(size = 8),
  panel.background = element_blank(),
  panel.grid.minor = element_line(colour="gray", size=0.5),
  legend.title = element_blank(),
  legend.position="none")
p <- p + scale_x_discrete(labels=unique(sample_population$Population))
p <- p + expand_limits(y=c(0.340, 0.385))
tiff("S2 FigB.tif",width = 85, height = 85, res=300,units = "mm")
print(p)
dev.off()
