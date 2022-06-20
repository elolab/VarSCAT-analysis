library("readxl")
library(ggplot2)
# http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/
sample_population <- read_excel("20130606_sample_info.xlsx")
sample_population <- as.data.frame(sample_population[,c(1,3)])
sample_list <- read.table("sample_list.txt",header = F)
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

interpret_result <- function(TR_type,sample_population1)
{
  file_suffix <- c("a","b","c","d","e","f","g","h","i","j")
  results_df <- vector()
  for (item in file_suffix)
  {
    file_name <- paste0("/03_TR_proportion/",TR_type,"/output_a",item,".txt")
    results_file <- read.table(file_name,header = T,sep = "\t")
    results_df <- rbind(results_df,results_file)
  }
  remove(results_file)
  
  sample_population1 <- cbind(sample_population1,results_df)
  
  num_TR <- sample_population1$TR_SNP+sample_population1$TR_DEL+sample_population1$TR_INS
  num_non_TR <- sample_population1$NON_TR_SNP+sample_population1$NON_TR_DEL+sample_population1$NON_TR_INS
  percetage_TR <- num_TR/(num_TR+num_non_TR)
  sample_population1 <- cbind(sample_population1,num_TR)
  sample_population1 <- cbind(sample_population1,num_non_TR)
  sample_population1 <- cbind(sample_population1,percetage_TR)
  
  num_INDEL <- sample_population1$TR_DEL+sample_population1$TR_INS
  num_non_INDEL <- sample_population1$NON_TR_DEL+sample_population1$NON_TR_INS
  percetage_INDEL <- num_INDEL/(num_INDEL+num_non_INDEL)
  sample_population1 <- cbind(sample_population1,num_INDEL)
  sample_population1 <- cbind(sample_population1,num_non_INDEL)
  sample_population1 <- cbind(sample_population1,percetage_INDEL)
  sample_population1 <- sample_population1[order(sample_population1$Superpopulation),]
  
  population_list <- levels(as.factor(sample_population1$Population))
  superpopulation_list <- levels(as.factor(sample_population1$Superpopulation))
  population_df_all <- vector()
  population_df_indel <- vector()
  for (i in superpopulation_list)
  {
    population_df_all <- rbind(population_df_all,summary(sample_population1$percetage_TR[sample_population1$Superpopulation==i]))
    population_df_indel <- rbind(population_df_indel,summary(sample_population1$percetage_INDEL[sample_population1$Superpopulation==i]))
  }
  for (i in population_list)
  {
    population_df_all <- rbind(population_df_all,summary(sample_population1$percetage_TR[sample_population1$Population==i]))
    population_df_indel <- rbind(population_df_indel,summary(sample_population1$percetage_INDEL[sample_population1$Population==i]))
  }
  row.names(population_df_all) <- c(superpopulation_list,population_list)
  row.names(population_df_indel) <- c(superpopulation_list,population_list)
  file_table_name_all <- paste("population_df_all",TR_type,".txt")
  file_table_name_indel <- paste("population_df_indel",TR_type,".txt")
  write.table(population_df_all,file_table_name_all,quote = FALSE,sep = "\t",row.names = TRUE,col.names = TRUE)
  write.table(population_df_indel,file_table_name_indel,quote = FALSE,sep = "\t",row.names = TRUE,col.names = TRUE)
  
  
  sample_population2 <- data.frame(Population=factor(sample_population1$Population,levels=unique(sample_population1$Population)), 
                                   Superpopulation=factor(sample_population1$Superpopulation,levels=unique(sample_population1$Superpopulation)),
                                   percetage_TR = sample_population1$percetage_TR,
                                   percetage_INDEL = sample_population1$percetage_INDEL)
  
  average_TR <- c(as.integer(mean(sample_population1$num_TR[sample_population1$Superpopulation=="AFR"])),
                  as.integer(mean(sample_population1$num_TR[sample_population1$Superpopulation=="AMR"])),
                  as.integer(mean(sample_population1$num_TR[sample_population1$Superpopulation=="EAS"])),
                  as.integer(mean(sample_population1$num_TR[sample_population1$Superpopulation=="EUR"])),
                  as.integer(mean(sample_population1$num_TR[sample_population1$Superpopulation=="SAS"])))
  
  average_INDEL <- c(as.integer(mean(sample_population1$num_INDEL[sample_population1$Superpopulation=="AFR"])),
                  as.integer(mean(sample_population1$num_INDEL[sample_population1$Superpopulation=="AMR"])),
                  as.integer(mean(sample_population1$num_INDEL[sample_population1$Superpopulation=="EAS"])),
                  as.integer(mean(sample_population1$num_INDEL[sample_population1$Superpopulation=="EUR"])),
                  as.integer(mean(sample_population1$num_INDEL[sample_population1$Superpopulation=="SAS"])))

  y_location <- 0.0765

  p <- ggplot(sample_population2, aes(x=Superpopulation, y=percetage_TR)) + 
    geom_boxplot(outlier.size = 1)
  p <- p + labs(y = "Proportion of STR region variants", x = "Superpopulation")
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
  p <- p + expand_limits(y=c(0.062, 0.0765))
  p <- p + scale_x_discrete(labels=c("AFR"="African","AMR"="American","EAS"="East Asian","EUR"="European","SAS"="South Asian"))
  figure_name1 <- paste0("Metapopulation_boxplot_",TR_type,".tif")
  tiff(figure_name1,width = 85, height = 85, res=300,units = "mm")
  print(p)
  dev.off()
  
  p <- ggplot(sample_population2, aes(x=Population, y=percetage_TR,fill=Superpopulation)) + 
    geom_boxplot(outlier.size = 0.5)
  p <- p + labs(y = "Proportion of STR region variants")
  p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
  p <- p + theme(
    axis.text.x = element_text(color = "black",size=6,angle = 90, vjust = 0.5, hjust=1),
    axis.text.y = element_text(color = "black",size=7),
    axis.title.x = element_text(size = 8),
    axis.title.y = element_text(size = 8),
    panel.background = element_blank(),
    panel.grid.minor = element_line(colour="gray", size=0.5),
    legend.position="bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.3, 'cm'),
    legend.title = element_text(size=8))
  p <- p + scale_x_discrete(labels=unique(sample_population1$Population))
  p <- p + expand_limits(y=c(0.062, 0.0765))
  figure_name2 <- paste0("Population_boxplot_",TR_type,".tif")
  tiff(figure_name2,width = 85, height = 85, res=300,units = "mm")
  print(p)
  dev.off()
  
  y_location2 <- 0.374
  
  p <- ggplot(sample_population2, aes(x=Superpopulation, y=percetage_INDEL)) + 
    geom_boxplot(outlier.size = 1)
  p <- p + labs(y = "Proportion of STR region Indels", x = "Superpopulation")
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
  p <- p + expand_limits(y=c(0.328, 0.366))
  p <- p + scale_x_discrete(labels=c("AFR"="African","AMR"="American","EAS"="East Asian","EUR"="European","SAS"="South Asian"))
  figure_name3 <- paste0("Metapopulation_boxplot_",TR_type,"_indel.tif")
  tiff(figure_name3,width = 85, height = 85, res=300,units = "mm")
  print(p)
  dev.off()
  
  p <- ggplot(sample_population2, aes(x=Population, y=percetage_INDEL,fill=Superpopulation)) + 
    geom_boxplot(outlier.size = 0.5)
  p <- p + labs(y = "Proportion of STR region Indels")
  p <- p + scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
  p <- p + theme(
    axis.text.x = element_text(color = "black",size=6,angle = 90, vjust = 0.5, hjust=1),
    axis.text.y = element_text(color = "black",size=7),
    axis.title.x = element_text(size = 8),
    axis.title.y = element_text(size = 8),
    panel.background = element_blank(),
    panel.grid.minor = element_line(colour="gray", size=0.5),
    legend.position="bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.3, 'cm'),
    legend.title = element_text(size=8))
  p <- p + scale_x_discrete(labels=unique(sample_population1$Population))
  #p <- p + annotate("text", x = c(4,9.5,14,19,24), y = y_location2, label = average_INDEL,size=2.5)
  p <- p + expand_limits(y=c(0.328, 0.366))
  figure_name4 <- paste0("Population_boxplot_",TR_type,"_indel.tif")
  tiff(figure_name4,width = 85, height = 85, res=300,units = "mm")
  print(p)
  dev.off()
}

interpret_result("perfect",sample_population)
