load("List_Data.RData")
install.packages("ggVennDiagram")
library("ggVennDiagram")
library(ggplot2)
options(scipen=999)

p2 <- ggVennDiagram(TR.list_p,label_percent_digit = 1, label = "percent",label_size = 2, label_alpha = 0,set_size = 3,
                    set_color = "white")
p2 <- p2 + scale_fill_distiller(palette = "Reds", direction = 1)
p2 <- p2 + theme(legend.text = element_text(size=5),
                 legend.key.size = unit(0.3, 'cm'),
                 legend.title = element_text(size=6))
tiff(filename ="Fig5A.tif",width = 80,height = 70, res=300,units = "mm")
p2
dev.off()


p4 <- ggVennDiagram(non_TR.list_p,label_percent_digit = 1, label = "percent",label_size = 2, label_alpha = 0,set_size = 3,
                    set_color = "white")
p4 <- p4 + scale_fill_distiller(palette = "Reds", direction = 1)
p4 <- p4 + theme(legend.text = element_text(size=5),
                 legend.key.size = unit(0.3, 'cm'),
                 legend.title = element_text(size=6))
tiff(filename ="Fig5B.tif",width = 80,height = 70, res=300,units = "mm")
p4
dev.off()






































































































