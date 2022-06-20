samples=open("/1000GP/sample_list.txt","r")
sample_line=samples.readlines()
for i in range(1,10):
	command_name="/1000GP/chr"+str(i)+"/chr"+str(i)+"_command.txt"
	commands=open(command_name,"a")
	for j in sample_line:
		command="/bcftools-1.5/bcftools view -s "+str(j).replace("\n","")+" /1000GP/chr"+str(i)+"/ALL.chr"+str(i)+".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz| /bcftools-1.5/bcftools query -f '[%GT"+r"\n]' -o ./GP/"+str(j).replace("\n","")+".txt"+"\n"
		commands.write(command)
	commands.close()

for i in range(10,23):
	command_name="/1000GP/chr"+str(i)+"/chr"+str(i)+"_command.txt"
	commands=open(command_name,"a")
	for j in sample_line:
		command="/bcftools-1.5/bcftools view -s "+str(j).replace("\n","")+" /1000GP/chr"+str(i)+"/ALL.chr"+str(i)+".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz| /bcftools-1.5/bcftools query -f '[%GT"+r"\n]' -o ./GP/"+str(j).replace("\n","")+".txt"+"\n"
		commands.write(command)
	commands.close()

command_name="/1000GP/chr"+"X"+"/chr"+"X"+"_command.txt"
commands=open(command_name,"a")
for j in sample_line:
	command="/bcftools-1.5/bcftools view -s "+str(j).replace("\n","")+" /1000GP/chr"+"X"+"/ALL.chr"+"X"+".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz| /bcftools-1.5/bcftools query -f '[%GT"+r"\n]' -o ./GP/"+str(j).replace("\n","")+".txt"+"\n"
	commands.write(command)
commands.close()

samples.close()
