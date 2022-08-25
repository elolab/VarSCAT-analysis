# complex output total numer of indel, del, ins
clinvar_name <- paste0("~/VarSCAT_analysis/ClinVar/ambiguity_ClinVar_whole.txt")
clinvar_complex <- read.table(clinvar_name,header = T, sep = "\t",quote=NULL)
# non valid ALT not considered
clinvar_complex <- clinvar_complex[as.character(clinvar_complex$ALT)!="None",]
clinvar_num_indel <- dim(clinvar_complex[(nchar(as.character(clinvar_complex$REF))-nchar(as.character(clinvar_complex$ALT)))!=0,])[1]

# complex del, ins
clinvar_DEL <- clinvar_complex[(nchar(as.character(clinvar_complex$REF))-nchar(as.character(clinvar_complex$ALT)))>0,]
# delins can not be ambiguity
clinvar_DEL_prue <- clinvar_DEL[!grepl("delins", as.character(clinvar_DEL$HGVS), fixed = TRUE),]
clinvar_DEL_ambiguity <- clinvar_DEL_prue[as.numeric(clinvar_DEL_prue$X5._aligned)!=as.numeric(clinvar_DEL_prue$X3._aligned),]
clinvar_DEL_dup <- clinvar_DEL_prue[(as.numeric(clinvar_DEL_prue$X3._aligned)-as.numeric(clinvar_DEL_prue$X5._aligned))>=
                                    abs(nchar(as.character(clinvar_DEL_prue$REF))-nchar(as.character(clinvar_DEL_prue$ALT))),]
clinvar_INS <- clinvar_complex[(nchar(as.character(clinvar_complex$REF))-nchar(as.character(clinvar_complex$ALT)))<0,]
clinvar_INS_prue <- clinvar_INS[!grepl("delins", as.character(clinvar_INS$HGVS), fixed = TRUE),]
clinvar_INS_ambiguity <- clinvar_INS_prue[as.numeric(clinvar_INS_prue$X5._aligned)!=as.numeric(clinvar_INS_prue$X3._aligned),]
clinvar_INS_dup <- clinvar_INS_prue[(as.numeric(clinvar_INS_prue$X3._aligned)-as.numeric(clinvar_INS_prue$X5._aligned))>=
                                  abs(nchar(as.character(clinvar_INS_prue$REF))-nchar(as.character(clinvar_INS_prue$ALT))),]

# the proportion of non unique position insertions and deletions
clinvar_ambiguity_del <- dim(clinvar_DEL_ambiguity)[1]/clinvar_num_indel
clinvar_ambiguity_ins <- dim(clinvar_INS_ambiguity)[1]/clinvar_num_indel
clinvar_unique_del <- (dim(clinvar_DEL)[1]-dim(clinvar_DEL_ambiguity)[1])/clinvar_num_indel
clinvar_unique_ins <- (dim(clinvar_INS)[1]-dim(clinvar_INS_ambiguity)[1])/clinvar_num_indel
clinvar_group <- c(clinvar_ambiguity_del,clinvar_ambiguity_ins,clinvar_unique_del ,clinvar_unique_ins)
clinvar_ambiguity <- c(clinvar_num_indel,dim(clinvar_DEL_ambiguity)[1],dim(clinvar_INS_ambiguity)[1],
                       dim(clinvar_DEL)[1]-dim(clinvar_DEL_ambiguity)[1],
                       dim(clinvar_INS)[1]-dim(clinvar_INS_ambiguity)[1])

clinvar_dup_del <- dim(clinvar_DEL_dup)[1]/clinvar_num_indel
clinvar_dup_ins <- dim(clinvar_INS_dup)[1]/clinvar_num_indel
clinvar_non_dup_del <- (dim(clinvar_DEL)[1]-dim(clinvar_DEL_dup)[1])/clinvar_num_indel
clinvar_non_dup_ins <- (dim(clinvar_INS)[1]-dim(clinvar_INS_dup)[1])/clinvar_num_indel
clinvar_group_dup <- c(clinvar_dup_del,clinvar_dup_ins,clinvar_non_dup_del ,clinvar_non_dup_ins)
clinvar_dup <- c(clinvar_num_indel,dim(clinvar_DEL_dup)[1],dim(clinvar_INS_dup)[1],
                       dim(clinvar_DEL)[1]-dim(clinvar_DEL_dup)[1],
                       dim(clinvar_INS)[1]-dim(clinvar_INS_dup)[1])

remove(clinvar_name)
remove(clinvar_complex)
remove(clinvar_num_indel)
remove(clinvar_DEL)
remove(clinvar_DEL_prue)
remove(clinvar_DEL_ambiguity)
remove(clinvar_INS)
remove(clinvar_INS_prue)
remove(clinvar_INS_ambiguity)

clinvar_ambiguity <- c(clinvar_ambiguity,clinvar_dup[c(2,3,4,5)])
clinvar_group <- c(clinvar_group,clinvar_group_dup)

summary(nchar(c(as.character(clinvar_DEL$REF),as.character(clinvar_INS$ALT))))
