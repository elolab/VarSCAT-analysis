#!/bin/sh
#SBATCH --cpus-per-task 48
#SBATCH --partition long
#SBATCH --job-name parallel_chr18
cat chr18_extract_sample_GP.txt | /parallel-20211222/src/parallel -P 48 {}
