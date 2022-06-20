for i in range(1,10):
	command_name="/1000GP/chr"+str(i)+"/parallel_chr"+str(i)+"_bash.sh"
	commands=open(command_name,"a")
	command1="#!/bin/sh"+"\n"
	commands.write(command1)
	command2="#SBATCH --cpus-per-task 48"+"\n"
	commands.write(command2)
	command3="#SBATCH --partition long"+"\n"
	commands.write(command3)
	command4="#SBATCH --output extract_gp.output.txt"+"\n"
	commands.write(command4)
	command5="#SBATCH --error extract_gp.Errors.txt"+"\n"
	commands.write(command5)
	command6="#SBATCH --job-name G_"+str(i)+"\n"
	commands.write(command6)
	command7="cat chr"+str(i)+"_command.txt | /parallel-20211222/src/parallel -P 48 {}"+"\n"
	commands.write(command7)
	commands.close()

for i in range(10,23):
	command_name="/1000GP/chr"+str(i)+"/parallel_chr"+str(i)+"_bash.sh"
	commands=open(command_name,"a")
	command1="#!/bin/sh"+"\n"
	commands.write(command1)
	command2="#SBATCH --cpus-per-task 48"+"\n"
	commands.write(command2)
	command3="#SBATCH --partition normal"+"\n"
	commands.write(command3)
	command8="#SBATCH --time 12:00:00"+"\n"
	commands.write(command8)
	command4="#SBATCH --output extract_gp.output.txt"+"\n"
	commands.write(command4)
	command5="#SBATCH --error extract_gp.Errors.txt"+"\n"
	commands.write(command5)
	command6="#SBATCH --job-name G_"+str(i)+"\n"
	commands.write(command6)
	command7="cat chr"+str(i)+"_command.txt | /parallel-20211222/src/parallel -P 48 {}"+"\n"
	commands.write(command7)
	commands.close()

command_name="/1000GP/chr"+"X"+"/parallel_chr"+"X"+"_bash.sh"
commands=open(command_name,"a")
command1="#!/bin/sh"+"\n"
commands.write(command1)
command2="#SBATCH --cpus-per-task 48"+"\n"
commands.write(command2)
command3="#SBATCH --partition normal"+"\n"
commands.write(command3)
command8="#SBATCH --time 12:00:00"+"\n"
commands.write(command8)
command4="#SBATCH --output extract_gp.output.txt"+"\n"
commands.write(command4)
command5="#SBATCH --error extract_gp.Errors.txt"+"\n"
commands.write(command5)
command6="#SBATCH --job-name G_"+"X"+"\n"
commands.write(command6)
command7="cat chr"+"X"+"_command.txt | /parallel-20211222/src/parallel -P 48 {}"+"\n"
commands.write(command7)
commands.close()























