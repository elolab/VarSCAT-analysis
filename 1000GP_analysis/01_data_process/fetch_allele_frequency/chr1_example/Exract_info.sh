#!/bin/sh
#SBATCH --cpus-per-task 24
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --output extract_info.output.txt
#SBATCH --error extract_info.Errors.txt
#SBATCH --job-name E_1
source /myenv/bin/activate
cat 1_index.txt | /parallel-20211222/src/parallel -P 24 python3 extract_INFO_GP.py --vcf /1000GP/chr1/1000GP_chr1_no_genotype.vcf.gz --location {} --output {}
