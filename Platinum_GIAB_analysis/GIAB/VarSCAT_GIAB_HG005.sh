#!/bin/bash
#SBATCH --job-name=HG005
#SBATCH --account=project
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --partition=small

module load tykky
export PATH="/VarSCAT/bin:$PATH"

python VarSCAT.py -T --vcf HG005_GRCh38_1_22_v4.2.1_benchmark.vcf.gz --reference GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --output HG005
