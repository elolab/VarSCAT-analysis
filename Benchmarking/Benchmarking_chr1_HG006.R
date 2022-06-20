get_id <- function(input)
{
  chr <- read.table(input,sep = "\t")
  chr_TR <- chr[grepl("bed3=Name",as.character(chr[,8],fixed = TRUE)),]
  ID <- paste0(as.character(chr_TR[,1]),"_",as.character(chr_TR[,2]),"_",
               as.character(chr_TR[,4]),"_",as.character(chr_TR[,5]))
  return(ID)
}

Krait_SSR <- get_id("HG006.Krait.perfect.hg38_multianno.vcf")
TRF_perfect <- get_id("HG006_chr1.TRF.perfect.hg38_multianno.vcf")
TRF_UCSC <- get_id("HG006_chr1.TRF.UCSC.hg38_multianno.vcf")
RM_UCSC <- get_id("HG006_chr1.RM.UCSC.hg38_multianno.vcf")
TRF_UCSC_100 <- get_id("/HG006_chr1.TRF.UCSC_100_match.hg38_multianno.vcf")
RM_UCSC_100 <- get_id("HG006_chr1.RM.UCSC_100_match.hg38_multianno.vcf")

GATK_file <- "GATK_HG006_chr1_TR.vcf"
GATK_R_chr <- read.table(GATK_file,sep = "\t")
GATK_R_repeat <- GATK_R_chr[grepl("STR",as.character(GATK_R_chr[,8])),]
remove(GATK_R_chr)
RPA_ref <- vector()
RU <- vector()
for (i in 1:dim(GATK_R_repeat)[1])
{
  print(i)
  item <- as.character(GATK_R_repeat[i,8])
  index_1 <- regexpr(pattern ="RPA=",item)
  substring_1 <- substr(item, index_1, nchar(item))
  index_2 <- regexpr(pattern =",",substring_1)-1
  RPA_ref <- c(RPA_ref,substr(substring_1, 5, index_2))
  index_3 <- regexpr(pattern ="RU=",substring_1)
  substring_2 <- substr(substring_1, index_3, nchar(substring_1))
  index_4 <- regexpr(pattern =";",substring_2)-1
  RU <- c(RU,substr(substring_2,4,index_4))
}
GATK_repeat_results <- cbind(GATK_R_repeat[,c(1,2,4,5,10)],RPA_ref,RU)
remove(GATK_R_repeat)
# No pattern larger than 6bp
GATK_repeat_results_pick <- GATK_repeat_results[nchar(as.character(GATK_repeat_results[,7]))<=6,]
# at least 10bp TR
GATK_repeat_results_pick <- GATK_repeat_results_pick[as.numeric(as.character(GATK_repeat_results_pick[,6]))*nchar(as.character(GATK_repeat_results_pick[,7]))>=10,]
# repeat time requirement (10 for 1bp, 5 for 2 bp, 4 for 3bp,4bp,5bp and 6bp)
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==1 & 
                                                    as.numeric(as.character(GATK_repeat_results_pick[,6]))<10),]
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==2 & 
                                                         as.numeric(as.character(GATK_repeat_results_pick[,6]))<5),]
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==3 & 
                                                         as.numeric(as.character(GATK_repeat_results_pick[,6]))<4),]
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==4 & 
                                                         as.numeric(as.character(GATK_repeat_results_pick[,6]))<4),]
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==5 & 
                                                         as.numeric(as.character(GATK_repeat_results_pick[,6]))<4),]
GATK_repeat_results_pick <- GATK_repeat_results_pick[!(nchar(as.character(GATK_repeat_results_pick[,7]))==6 & 
                                                         as.numeric(as.character(GATK_repeat_results_pick[,6]))<4),]
remove(GATK_repeat_results)
GATK_id <- paste0(as.character(GATK_repeat_results_pick[,1]),"_",
                  as.character(GATK_repeat_results_pick[,2]),"_",
                  as.character(GATK_repeat_results_pick[,3]),"_",
                  as.character(GATK_repeat_results_pick[,4]))

VarSCAT_results_perfect <- read.table("05_03_2022_chr1_p.txt",
                                      header = T,sep = "\t",quote=NULL)
VarSCAT_results_perfect <- VarSCAT_results_perfect[VarSCAT_results_perfect[,11]!="",]
VarSCAT_results_ID_perfect <- paste0(as.character(VarSCAT_results_perfect[,1]),"_",
                                as.character(VarSCAT_results_perfect[,2]),"_",
                                as.character(VarSCAT_results_perfect[,3]),"_",
                                as.character(VarSCAT_results_perfect[,4]))

library(ggVennDiagram)
library(ggplot2)

z = list("GATK TandemRepeat"=GATK_id,"VarSCAT"=VarSCAT_results_ID_perfect, "UCSC RepeatMasker"=RM_UCSC,
         "UCSC TRF"=TRF_UCSC,"Krait"=Krait_SSR)
tiff("vennDiagram_HG006.tiff",width = 70,height = 70,res = 300, units = "mm")
ggVennDiagram(z,label = "count",set_color = "white",set_size = 1,label_alpha=0,label_size = 2,edge_size = 0.5, 
              category.names = c("GATK","VarSCAT","RepeatMasker","TRF","Krait"))+ 
  scale_fill_gradient(low = "#F4FAFE", high = "#F4FAFE")+
  theme(legend.position = "none")
dev.off() 

x = list("GATK TandemRepeat"=GATK_id,"VarSCAT"=VarSCAT_results_ID_perfect, "UCSC RepeatMasker 100"=RM_UCSC_100,
         "UCSC TRF 100"=TRF_UCSC_100,"Krait"=Krait_SSR)
tiff("vennDiagram_HG006_100.tiff",width = 70,height = 70,res = 300, units = "mm")
ggVennDiagram(x,label = "count",set_color = "white",set_size = 1,label_alpha=0,label_size = 2,edge_size = 0.5, 
              category.names = c("GATK","VarSCAT","RepeatMasker","TRF","Krait"))+ 
  scale_fill_gradient(low = "#F4FAFE", high = "#F4FAFE")+
  theme(legend.position = "none")
dev.off() 
