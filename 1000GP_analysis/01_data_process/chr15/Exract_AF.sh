#!/bin/sh
#SBATCH --cpus-per-task 24
#SBATCH --partition normal
#SBATCH --job-name Extract_AF_15
source /myenv/bin/activate
cat 15_index.txt | /parallel-20211222/src/parallel -P 24 python3 /01_data_process/extract_INFO_GP.py --vcf 1000GP_chr15_no_genotype.vcf.gz --location {} --output {}
