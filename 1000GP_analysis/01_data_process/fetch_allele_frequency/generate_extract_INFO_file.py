for i in range(1,23):
	file_write_name="/1000GP/chr"+str(i)+"/Exract_info.sh"
	file_write=open(file_write_name,"a")
	command1="#!/bin/sh"+"\n"
	file_write.write(command1)
	command2="#SBATCH --cpus-per-task 24"+"\n"
	file_write.write(command2)
	command3="#SBATCH --partition normal"+"\n"
	file_write.write(command3)
	command9="#SBATCH --time 12:00:00"+"\n"
	file_write.write(command9)
	command4="#SBATCH --output extract_info.output.txt"+"\n"
	file_write.write(command4)
	command5="#SBATCH --error extract_info.Errors.txt"+"\n"
	file_write.write(command5)
	command6="#SBATCH --job-name E_"+str(i)+"\n"
	file_write.write(command6)
	command7="source /myenv/bin/activate"+"\n"
	file_write.write(command7)
	command8="cat "+str(i)+"_index.txt | /parallel-20211222/src/parallel -P 24 python3 /1000GP/ALL/extract_INFO_GP.py --vcf /1000GP/chr"+str(i)+"/1000GP_chr"+str(i)+"_no_genotype.vcf.gz --location {} --output {}"+"\n"
	file_write.write(command8)
	file_write.close()

