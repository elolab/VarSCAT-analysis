# The whole script: file is 1 based, python is 0 based
import pandas as pd
from Bio import SeqIO

def left_ambiguity(pos,pattern,ref):
	pos=pos-1

	pos_left_flank=pos-1
	flank_left=ref[pos_left_flank]
	
	while flank_left==pattern[len(pattern)-1]:
		pos_left_flank=pos_left_flank-1
		flank_left=ref[pos_left_flank]
		pattern=pattern[len(pattern)-1]+pattern[0:len(pattern)-1]

	pos_left_flank=pos_left_flank+2 

	return pos_left_flank

def right_ambiguity(pos,pattern,length,ref): 
	pos=pos-1
	
	pos_right_flank=pos+length
	flank_right=ref[pos_right_flank]

	while flank_right==pattern[0]:
		pos_right_flank=pos_right_flank+1
		flank_right=ref[pos_right_flank]
		pattern=pattern[1:]+pattern[0]

	pos_right_flank=pos_right_flank-int(length)+1

	return pos_right_flank 

def read_reference_sequence(input_file,chromosome):
	for seq_record in SeqIO.parse(input_file, "fasta"):
		if seq_record.id==chromosome:
			sequence_chr=str(seq_record.seq)
	return sequence_chr

df = pd.read_csv("Random_set_pattern.txt",sep="\t")
chr_name=""
left_most=[]
right_most=[]
for i in range(0,df.shape[0]):
	chromosome=df.loc[i,"chr"]
	print(chromosome)
	if chr_name!=chromosome:
		chr_name=chromosome
		reference=read_reference_sequence("genome.fa",chr_name)
	
	print(chr_name,int(df.loc[i,"pos"]))
	#left align and right align position
	if df.loc[i,"type"]=="del":
		left_align = left_ambiguity(int(df.loc[i,"pos"]),df.loc[i,"Pattern"],reference)
		right_align = right_ambiguity(int(df.loc[i,"pos"]),df.loc[i,"Pattern"],int(df.loc[i,"len"]),reference)
		left_most.append(left_align)
		right_most.append(right_align)

	elif df.loc[i,"type"]=="ins":
		left_align = left_ambiguity(int(df.loc[i,"pos"])+1,df.loc[i,"Pattern"],reference)-1
		right_align = right_ambiguity(int(df.loc[i,"pos"]),df.loc[i,"Pattern"],1,reference)
		left_most.append(left_align)
		right_most.append(right_align)

df["left_most"]=left_most
df["right_most"]=right_most
df.to_csv("Random_set_pattern_position.txt", index = False, header=True, sep='\t')



















