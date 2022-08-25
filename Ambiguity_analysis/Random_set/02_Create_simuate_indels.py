from Bio import SeqIO
import pandas as pd
import random

random.seed(1234)

def read_reference_sequence(input_file,chromosome):
	for seq_record in SeqIO.parse(input_file, "fasta"):
		if seq_record.id==chromosome:
			sequence_chr=str(seq_record.seq)
	return sequence_chr

df = pd.read_csv("Random_set.txt",sep="\t")
chr_name=""
pattern_list=[]
nucleotide="ATGC"
for i in range(0,df.shape[0]):
	chromosome=df.iloc[i]["chr"]
	if chr_name!=chromosome:
		chr_name=chromosome
		reference=read_reference_sequence("genome.fa",chr_name)
	if df.iloc[i]["type"]=="del":
		# the position in file are 1 based
		pattern=reference[int(df.iloc[i]["pos"])-1:int(df.iloc[i]["pos"])-1+int(df.iloc[i]["len"])].upper()
		pattern_list.append(pattern)
	elif df.iloc[i]["type"]=="ins":
		length=-int(df.iloc[i]["len"])
		pattern=""
		for i in range(0,length):
			n=random.randint(0,3)
			pattern=pattern+nucleotide[n]
		pattern_list.append(pattern)

df["Pattern"]=pattern_list
df.to_csv("Random_set_pattern.txt", index = False, header=True, sep='\t')

# deletion position is 1 based, the first base of pattern position on reference sequence 
# insertion position is 1 based, the left flanking base on reference genome


















