library(ggplot2)
#Figure S9-S14
copyN_grouped_size <- function(data_plot_read,sample_name)
{
  data_plot <- data_plot_read[2][[1]]
  data_plot$V2 <- factor(as.character(data_plot$V2))
  for (i in 1:6)
  {
    data_plot_sub <- data_plot[data_plot[,2]==i,]
    p <- ggplot(data_plot_sub, aes(copy_num_all)) + 
      geom_bar() 
    lab_x <- paste0("Copy Number")
    p <- p + labs(x = lab_x)
    lab_y <- paste0("Count")
    p <- p + labs(y = lab_y)
    p <- p + theme(
      axis.text.x = element_text(color = "black",size=6),
      axis.text.y = element_text(color = "black",size=6),
      axis.title.x = element_text(size = 8),
      axis.title.y = element_text(size = 8),
      panel.background = element_blank(),
      panel.grid.minor = element_line(colour="gray", size=0.1),
      axis.ticks.x = element_line(colour="black",size=0.5))
    if (i ==1)
    {
      p <- p + coord_cartesian(ylim = c(0,33000),xlim = c(9,40))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==2)
    {
      p <- p + coord_cartesian(ylim = c(0,13000),xlim = c(4,40))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==3)
    {
      p <- p + coord_cartesian(ylim = c(0,4700),xlim =c(3,30))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==4)
    {
      p <- p + coord_cartesian(ylim = c(0,8200),xlim =c(3,30))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==5)
    {
      p <- p + coord_cartesian(ylim = c(0,3000),xlim = c(3,20))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==6)
    {
      p <- p + coord_cartesian(ylim = c(0,950), xlim =c(3,15))
      figure_name <- paste0("./CopyN_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
  }
}
copyN_grouped_size(NA12877_TR_p,"NA12877_p")
copyN_grouped_size(NA12878_TR_p,"NA12878_p")
copyN_grouped_size(HG002_TR_p,"HG002_p")
copyN_grouped_size(HG003_TR_p,"HG003_p")
copyN_grouped_size(HG004_TR_p,"HG004_p")
copyN_grouped_size(HG005_TR_p,"HG005_p")
copyN_grouped_size(HG006_TR_p,"HG006_p")
copyN_grouped_size(HG007_TR_p,"HG007_p")

#Figure6
results_proportion <- vector()
proportion_calculate <- function(TR_proportion)
{
  TR_snp <- TR_proportion[1]/(TR_proportion[1]+TR_proportion[2]+TR_proportion[3])
  TR_del <- TR_proportion[2]/(TR_proportion[1]+TR_proportion[2]+TR_proportion[3])
  TR_ins <- TR_proportion[3]/(TR_proportion[1]+TR_proportion[2]+TR_proportion[3])
  non_TR_snp <- TR_proportion[4]/(TR_proportion[4]+TR_proportion[5]+TR_proportion[6])
  non_TR_del <- TR_proportion[5]/(TR_proportion[4]+TR_proportion[5]+TR_proportion[6])
  non_TR_ins <- TR_proportion[6]/(TR_proportion[4]+TR_proportion[5]+TR_proportion[6])
  total_variant <- TR_proportion[1]+TR_proportion[2]+TR_proportion[3]+TR_proportion[4]+TR_proportion[5]+TR_proportion[6]
  TR_num <- TR_proportion[1]+TR_proportion[2]+TR_proportion[3]
  TR_per <- TR_num/total_variant
  non_TR_num <- TR_proportion[4]+TR_proportion[5]+TR_proportion[6]
  non_TR_per <- non_TR_num/total_variant
  results <- c(TR_snp,TR_ins,TR_del,non_TR_snp,non_TR_ins,non_TR_del,
               TR_num,TR_per,non_TR_num,non_TR_per)
  
  return(results)
}
results_proportion <- rbind(results_proportion,proportion_calculate(NA12877_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(NA12878_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG002_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG003_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG004_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG005_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG006_TR_p[1][[1]]))
results_proportion <- rbind(results_proportion,proportion_calculate(HG007_TR_p[1][[1]]))
results_proportion <- as.data.frame(results_proportion)
results_proportion <- cbind(c("Platinum NA12877","Platinum NA12878","GIAB HG002","GIAB HG003",
                                   "GIAB HG004","GIAB HG005","GIAB HG006","GIAB HG007"),results_proportion)
colnames(results_proportion) <- c("Sample","STR_SNP","STR_Insertion","STR_Deletion",
                                  "Non_STR_SNP","Non_STR_Insertion","Non_STR_Deletion",
                                  "TR_num","TR_per","Non_TR_num","Non_TR_per")

TR_num_list <- as.character(results_proportion[,8])
TR_per_list <- paste0(sprintf("%.2f", round(results_proportion[,9],4)*100),"%")
non_TR_num_list <- as.character(results_proportion[,10])
non_TR_per_list <- paste0(sprintf("%.2f", round(results_proportion[,11],4)*100),"%")

library(tidyr)
TR_long <- gather(results_proportion[,c(1,2,3,4)], variant_type, variant_percentage, STR_SNP:STR_Deletion, factor_key=TRUE)
non_TR_long <- gather(results_proportion[,c(1,5,6,7)], variant_type, variant_percentage, 
                      Non_STR_SNP:Non_STR_Deletion, factor_key=TRUE)
TR_long$Sample <- factor(TR_long$Sample,
                        levels = c("GIAB HG007","GIAB HG006","GIAB HG005","GIAB HG004",
                                   "GIAB HG003","GIAB HG002","Platinum NA12878","Platinum NA12877"))
non_TR_long$Sample <- factor(non_TR_long$Sample,
                            levels = c("GIAB HG007","GIAB HG006","GIAB HG005","GIAB HG004",
                                       "GIAB HG003","GIAB HG002","Platinum NA12878","Platinum NA12877"))
make_plot <- function(results_frame,output_name,num_list,per_list)
{
  p <- ggplot(data=results_frame, aes(x=Sample, y=variant_percentage, fill=variant_type)) +
    geom_bar(stat="identity") + coord_flip()
  p <- p + scale_fill_manual(values=c("#d95f02","#1b9e77","#7570b3"),
                             labels=c("SNV","Insertion","Deletion"))
  p <- p + theme(
    axis.text.x = element_text(color = "black",size=5),
    axis.text.y = element_text(color = "black",size=5),
    axis.title.x = element_text(size = 6),
    axis.title.y = element_blank(),
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.line.x = element_line(colour="black",size=0.2),
    axis.line.y = element_blank(),
    axis.ticks.x = element_line(colour="black",size=0.3),
    axis.ticks.y = element_line(colour="black",size=0.1),
    panel.grid.minor = element_line(colour="gray", size=0.2))
  p <- p + guides(fill=guide_legend(reverse = T)) + labs(y = output_name)
  for (i in 1:8)
  {
    index_1 <- i
    index_2 <- i+8
    index_3 <- i+16
    if (output_name=="Non-STR Variant Proportion")
    {
      p <- p + annotate("text", x=9-i, y=results_frame[index_1,3]/2+results_frame[index_2,3]+results_frame[index_3,3], 
                        label= paste0(sprintf("%.2f", round(results_frame[index_1,3],4)*100),"%"),colour = "white",size = 1.6) 
      p <- p + annotate("text", x=9-i, y=results_frame[index_3,3]+results_frame[index_2,3]/2, 
                        label= paste0(sprintf("%.2f", round(results_frame[index_2,3],4)*100),"%"),colour = "white",
                        size = 1.6,angle = 270) 
      p <- p + annotate("text", x=9-i, y=results_frame[index_3,3]/2, 
                        label= paste0(sprintf("%.2f", round(results_frame[index_3,3],4)*100),"%"),colour = "white",
                        size = 1.6,angle = 270) 
    }
    else
    {
      p <- p + annotate("text", x=9-i, y=results_frame[index_1,3]/2+results_frame[index_2,3]+results_frame[index_3,3], 
                        label= paste0(sprintf("%.2f", round(results_frame[index_1,3],4)*100),"%"),colour = "white",size = 1.6) 
      p <- p + annotate("text", x=9-i, y=results_frame[index_3,3]+results_frame[index_2,3]/2, 
                        label= paste0(sprintf("%.2f", round(results_frame[index_2,3],4)*100),"%"),colour = "white",size = 1.6) 
      p <- p + annotate("text", x=9-i, y=results_frame[index_3,3]/2, 
                        label= paste0(sprintf("%.2f", round(results_frame[index_3,3],4)*100),"%"),colour = "white",size = 1.6) 
    }
    p <- p + annotate("text", x=i+0.15, y=1.06, label= num_list[9-i],colour = "black",size = 1.5) 
    p <- p + annotate("text", x=i-0.15, y=1.06, label= per_list[9-i],colour = "black",size = 1.5) 
  }
  output_file <- paste0(output_name,".tif")
  tiff(filename =output_file,width = 85,height = 60, res=300,units = "mm")
  print(p)
  dev.off()
}
make_plot(TR_long,"STR Variant Proportion",TR_num_list,TR_per_list)
make_plot(non_TR_long,"Non-STR Variant Proportion",non_TR_num_list,non_TR_per_list)

# Figure S3-S8
options(scipen=999)
length_grouped_size <- function(data_plot_read,sample_name)
{
  data_plot <- data_plot_read[3][[1]]
  colnames(data_plot) <- c("indel_length","size","Type")
  data_plot <- data_plot[data_plot[,1]<=30,]
  data_plot$indel_length <- factor(as.numeric(as.character(data_plot$indel_length)))
  data_plot["Type"][data_plot["Type"] == 1] <- "Deletion"
  data_plot["Type"][data_plot["Type"] == 2] <- "Insertion"
  for (i in 1:6)
  {
    data_plot_sub <- data_plot[data_plot[,2]==i,]
    p <- ggplot(data_plot_sub, aes(x=indel_length,fill=Type)) + 
      geom_bar()+
      scale_fill_manual(values=c("#1f78b4", "#33a02c")) +
      scale_x_discrete(drop=FALSE)
    lab_x <- paste0("Indel Size (bp)")
    p <- p + labs(x = lab_x)
    lab_y <- paste0("Count")
    p <- p + labs(y = lab_y)
    p <- p + theme(
      axis.text.x = element_text(color = "black",size=4.5),
      axis.text.y = element_text(color = "black",size=6),
      axis.title.x = element_text(size = 8),
      axis.title.y = element_text(size = 8),
      panel.background = element_blank(),
      panel.grid.minor = element_line(colour="gray", size=0.1),
      axis.ticks.x = element_line(colour="black",size=0.25),
      legend.position = "none")
    if (i ==1)
    {
      p <- p + coord_cartesian(ylim = c(0,150000))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==2)
    {
      p <- p + coord_cartesian(ylim = c(0,40000))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==3)
    {
      p <- p + coord_cartesian(ylim = c(0,6200))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==4)
    {
      p <- p + coord_cartesian(ylim = c(0,17500))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==5)
    {
      p <- p + coord_cartesian(ylim = c(0,3800))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
    else if (i ==6)
    {
      p <- p + coord_cartesian(ylim = c(0,830))
      figure_name <- paste0("./Indel_Size_Motif_",i,"/",sample_name,"_",i,".tif")
      tiff(figure_name,width = 85, height = 35, res=300,units = "mm")
      print(p)
      dev.off()
    }
  }
}
length_grouped_size(NA12877_TR_p,"NA12877_p")
length_grouped_size(NA12878_TR_p,"NA12878_p")
length_grouped_size(HG002_TR_p,"HG002_p")
length_grouped_size(HG003_TR_p,"HG003_p")
length_grouped_size(HG004_TR_p,"HG004_p")
length_grouped_size(HG005_TR_p,"HG005_p")
length_grouped_size(HG006_TR_p,"HG006_p")
length_grouped_size(HG007_TR_p,"HG007_p")

one_span_STR_list <- vector()
only_span_one_STR <- function(input)
{
  one_span_STR <- dim(input[3][[1]])[1]/(input[1][[1]][1]+input[1][[1]][2]+input[1][[1]][3])
  return(one_span_STR)
}
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(NA12877_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(NA12878_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG002_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG003_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG004_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG005_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG006_TR_p))
one_span_STR_list <- c(one_span_STR_list,only_span_one_STR(HG007_TR_p))
