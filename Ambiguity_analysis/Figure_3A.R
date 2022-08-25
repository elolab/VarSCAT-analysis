load(Data.RData)
complex_group <- cbind(clinvar_group,NA12877_group,NA12878_group,HG002_group,HG003_group,
                       HG004_group,HG005_group,HG006_group,HG007_group,Random_group)
colnames(complex_group) <- c("ClinVar","NA12877","NA12878","HG002","HG003",
                             "HG004","HG005","HG006","HG007","Semi-random")
df <- data.frame(indel_type=rep(c("A_D","A_I","U_D","U_I"), each=10),
                  sample_name=rep(c("ClinVar","Platinum NA12877","Platinum NA12878","GIAB HG002","GIAB HG003",
                                    "GIAB HG004","GIAB HG005","GIAB HG006","GIAB HG007","Semi-random"),4),
                  Percentage=c(complex_group[1,],complex_group[2,],complex_group[3,],complex_group[4,]))
df$sample_name <- factor(df$sample_name, levels = c("Semi-random","GIAB HG007","GIAB HG006","GIAB HG005","GIAB HG004","GIAB HG003",
                                                    "GIAB HG002","Platinum NA12878","Platinum NA12877","ClinVar"))
df$indel_type <- factor(df$indel_type,levels = c("U_I","U_D","A_I","A_D"))

total_indel <- c(clinvar_ambiguity[2]+clinvar_ambiguity[3],
                 NA12877_ambiguity[2]+NA12877_ambiguity[3],
                 NA12878_ambiguity[2]+NA12878_ambiguity[3],
                 HG002_ambiguity[2]+HG002_ambiguity[3],
                 HG003_ambiguity[2]+HG003_ambiguity[3],
                 HG004_ambiguity[2]+HG004_ambiguity[3],
                 HG005_ambiguity[2]+HG005_ambiguity[3],
                 HG006_ambiguity[2]+HG006_ambiguity[3],
                 HG007_ambiguity[2]+HG007_ambiguity[3],
                 Random_ambiguity[2]+Random_ambiguity[3])

library(ggplot2)

p <- ggplot(data=df, aes(x=sample_name, y=Percentage, fill=indel_type)) +
  geom_bar(stat="identity") + coord_flip()
p <- p + scale_fill_manual(values=c("#b2df8a","#a6cee3","#33a02c","#1f78b4"),
                           labels=c("Unique Position Insertions","Unique Position Deletions", 
                                    "Breakpoint Ambiguous Insertions","Breakpoint Ambiguous Deletions"))
p <- p + theme(
  axis.text.x = element_text(color = "black",size=5),
  axis.text.y = element_text(color = "black",size=6),
  axis.title.x = element_text(size = 6),
  axis.title.y = element_blank(),
  #legend.position = "none",
  legend.position = "bottom",
  legend.text = element_text(size=6),
  legend.title = element_blank(),
  legend.key.size = unit(0.2, 'cm'),
  legend.margin=margin(t=-0.2, r=0, b=0, l=-0.3, unit="cm"),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.line.x = element_line(colour="black",size=0.2),
  axis.line.y = element_blank(),
  axis.ticks.x = element_line(colour="black",size=0.3),
  axis.ticks.y = element_line(colour="black",size=0.1),
  panel.grid.minor = element_line(colour="gray", size=0.2))
p <- p + guides(fill=guide_legend(reverse = T,nrow=2))

i <- 1
p <- p + annotate("text", x=11-i, y=df[i,3]/2, label= paste0(sprintf("%.2f", round(df[i,3],4)*100),"%"),
                  colour = "white",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]/2, label= paste0(sprintf("%.2f", round(df[10+i,3],4)*100),"%"),
                  colour = "white",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]/2,
                  label= paste0(sprintf("%.2f", round(df[20+i,3],4)*100),"%"),colour = "black",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]+df[30+i,3]/2, angle = 270,
                  label= paste0(sprintf("%.2f", round(df[30+i,3],4)*100),"%"),colour = "black",size = 1.3) 
p <- p + annotate("text", x=11-i, y=1.06, label= total_indel[i],colour = "black",size = 1.7) 
for (i in 2:9)
{
  p <- p + annotate("text", x=11-i, y=df[i,3]/2, label= paste0(sprintf("%.2f", round(df[i,3],4)*100),"%"),
                    colour = "white",size = 1.3) 
  p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]/2, label= paste0(sprintf("%.2f", round(df[10+i,3],4)*100),"%"),
                    colour = "white",size = 1.3) 
  p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]/2, angle = 270,
                    label= paste0(sprintf("%.2f", round(df[20+i,3],4)*100),"%"),colour = "black",size = 1.3) 
  p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]+df[30+i,3]/2, angle = 270,
                    label= paste0(sprintf("%.2f", round(df[30+i,3],4)*100),"%"),colour = "black",size = 1.3) 
  p <- p + annotate("text", x=11-i, y=1.06, label= total_indel[i],colour = "black",size = 1.7) 
}
i <- 10
p <- p + annotate("text", x=11-i, y=df[i,3]/2, label= paste0(sprintf("%.2f", round(df[i,3],4)*100),"%"),
                  colour = "white",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]/2, label= paste0(sprintf("%.2f", round(df[10+i,3],4)*100),"%"),
                  colour = "white",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]/2, 
                  label= paste0(sprintf("%.2f", round(df[20+i,3],4)*100),"%"),colour = "black",size = 1.3) 
p <- p + annotate("text", x=11-i, y=df[i,3]+df[10+i,3]+df[20+i,3]+df[30+i,3]/2, 
                  label= paste0(sprintf("%.2f", round(df[30+i,3],4)*100),"%"),colour = "black",size = 1.3) 
p <- p + annotate("text", x=11-i, y=1.06, label= total_indel[i],colour = "black",size = 1.7)

tiff(filename ="Figure_3A.tif",width = 85,height = 60, res=300,units = "mm")
p
dev.off()































































