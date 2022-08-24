reference_index_file = open("index_file.txt","r")
reference_index = reference_index_file.readlines()
for i in reference_index:
	item=i.split("\t")
	index_name = "/1000GP/chr"+str(item[0])+"/"+str(item[0]) + "_index.txt"
	index_chromosome = open(index_name,"a")
	chromosome_start=int(item[1])
	chromosome_end=int(item[2])
	sub=round((chromosome_end-chromosome_start)/24)
	for j in range(0,24):
		m=int(chromosome_start+sub*j)
		n=int(chromosome_start+sub*(j+1))
		sub_region=str(item[0])+":"+str(m)+"-"+str(n)+"\n"
		index_chromosome.write(sub_region)
	index_chromosome.close()


reference_index_file.close()
