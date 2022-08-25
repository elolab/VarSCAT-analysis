#!/bin/sh
#SBATCH --cpus-per-task 48
#SBATCH --partition long
#SBATCH --job-name parallel_chr22
cat chr22_extract_sample_GP.txt | /parallel-20211222/src/parallel -P 48 {}
