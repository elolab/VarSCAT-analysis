Random_genome <- read.table("~/VarSCAT_analysis/Ambiguity_analysis/Ramdom_set/Random_set_pattern_position.txt",
                            header = T, sep = "\t")
# complex del, ins
Random_DEL <- Random_genome[Random_genome$type=="del",]
Random_INS <- Random_genome[Random_genome$type=="ins",]
Random_DEL_ambiguity <- Random_DEL[as.numeric(Random_DEL$left_most)!=as.numeric(Random_DEL$right_most),]
Random_INS_ambiguity <- Random_INS[as.numeric(Random_INS$left_most)!=as.numeric(Random_INS$right_most),]
Random_ambiguity_del <- dim(Random_DEL_ambiguity)[1]/dim(Random_genome)[1]
Random_ambiguity_ins <- dim(Random_INS_ambiguity)[1]/dim(Random_genome)[1]
Random_unique_del <- (dim(Random_DEL)[1]-dim(Random_DEL_ambiguity)[1])/dim(Random_genome)[1]
Random_unique_ins <- (dim(Random_INS)[1]-dim(Random_INS_ambiguity)[1])/dim(Random_genome)[1]

Random_DEL_dup <- Random_DEL[(as.numeric(Random_DEL$right_most)-as.numeric(Random_DEL$left_most))>=
                               Random_DEL$len,]
Random_INS_dup <- Random_INS[(as.numeric(Random_INS$right_most)-as.numeric(Random_INS$left_most))>=
                               abs(Random_INS$len),]
Random_dup_del <- dim(Random_DEL_dup)[1]/dim(Random_genome)[1]
Random_dup_ins <- dim(Random_INS_dup)[1]/dim(Random_genome)[1]
Random_non_dup_del <- (dim(Random_DEL)[1]-dim(Random_DEL_dup)[1])/dim(Random_genome)[1]
Random_non_dup_ins <- (dim(Random_INS)[1]-dim(Random_INS_dup)[1])/dim(Random_genome)[1]

Random_group <- c(Random_ambiguity_del,Random_ambiguity_ins,Random_unique_del,Random_unique_ins,
                  Random_dup_del,Random_dup_ins,Random_non_dup_del,Random_non_dup_ins)
Random_ambiguity <- c(dim(Random_genome)[1],dim(Random_DEL_ambiguity)[1],dim(Random_INS_ambiguity)[1],
                      dim(Random_DEL)[1]-dim(Random_DEL_ambiguity)[1],dim(Random_INS)[1]-dim(Random_INS_ambiguity)[1],
                      dim(Random_DEL_dup)[1],dim(Random_INS_dup)[1],
                      dim(Random_DEL)[1]-dim(Random_DEL_dup)[1],dim(Random_INS)[1]-dim(Random_INS_dup)[1])

remove(Random_genome)
remove(Random_DEL)
remove(Random_INS)
remove(Random_DEL_ambiguity)
remove(Random_INS_ambiguity)
remove(Random_DEL_dup)
remove(Random_INS_dup)
remove(Random_ambiguity_del)
remove(Random_ambiguity_ins)
remove(Random_dup_del)
remove(Random_dup_ins)
remove(Random_non_dup_del)
remove(Random_non_dup_ins)
remove(Random_unique_del)
remove(Random_unique_ins)
