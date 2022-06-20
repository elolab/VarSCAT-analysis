for i in range(1,23):
	file_write_name="/1000GP/chr"+str(i)+"/perfect/GNU_"+str(i) + "_run.sh"
	file_write=open(file_write_name,"a")
	command1="#!/bin/sh"+"\n"
	file_write.write(command1)
	command2="#SBATCH --cpus-per-task 24"+"\n"
	file_write.write(command2)
	command3="#SBATCH --partition long"+"\n"
	file_write.write(command3)
	command4="#SBATCH --output gnu.output.txt"+"\n"
	file_write.write(command4)
	command5="#SBATCH --error gnu.Errors.txt"+"\n"
	file_write.write(command5)
	command6="#SBATCH --job-name 02_gnu"+"\n"
	file_write.write(command6)
	command7="source /myenv/bin/activate"+"\n"
	file_write.write(command7)
	command8="time cat "+str(i)+"_index.txt | /parallel-20211222/src/parallel -P 24 python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf /1000GP/chr"+str(i)+"/1000GP_chr"+str(i)+"_no_genotype.vcf.gz --reference Homo_sapiens.GRCh38.dna.primary_assembly.fa --similarity 100 --gap_tolerate 0 --location {} --output {}"+"\n"
	file_write.write(command8)
	file_write.close()

file_write_name="/1000GP/chr"+"X"+"/perfect/GNU_"+"X"+"_run.sh"
file_write=open(file_write_name,"a")
command1="#!/bin/sh"+"\n"
file_write.write(command1)
command2="#SBATCH --cpus-per-task 24"+"\n"
file_write.write(command2)
command3="#SBATCH --partition long"+"\n"
file_write.write(command3)
command4="#SBATCH --output gnu.output.txt"+"\n"
file_write.write(command4)
command5="#SBATCH --error gnu.Errors.txt"+"\n"
file_write.write(command5)
command6="#SBATCH --job-name 02_gnu"+"\n"
file_write.write(command6)
command7="source /myenv/bin/activate"+"\n"
file_write.write(command7)
command8="time cat "+"X"+"_index.txt | /parallel-20211222/src/parallel -P 24 python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf /1000GP/chr"+"X"+"/1000GP_chr"+"X"+"_no_genotype.vcf.gz --reference Homo_sapiens.GRCh38.dna.primary_assembly.fa --similarity 100 --gap_tolerate 0 --location {} --output {}"+"\n"
file_write.write(command8)
file_write.close()

