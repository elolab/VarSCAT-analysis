#!/bin/sh
#SBATCH --cpus-per-task 48
#SBATCH --partition long
#SBATCH --output extract_gp.output.txt
#SBATCH --error extract_gp.Errors.txt
#SBATCH --job-name G_1
cat chr1_command.txt | /data/epouta1/B18067_Complex_variation/1000GP/1000GP_phase3/parallel-20211222/src/parallel -P 48 {}
