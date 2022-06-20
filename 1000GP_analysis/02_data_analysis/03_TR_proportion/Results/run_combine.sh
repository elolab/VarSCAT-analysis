#!/bin/sh
#SBATCH --cpus-per-task 10
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --output gp.output.txt
#SBATCH --error gp.Errors.txt
#SBATCH --job-name GP
module add R
cat command_line.txt | /parallel-20211222/src/parallel -P 10 {}
