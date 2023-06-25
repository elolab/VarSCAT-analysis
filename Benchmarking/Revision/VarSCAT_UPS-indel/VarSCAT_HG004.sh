#!/bin/bash
#SBATCH --job-name=VarSCAT_3
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module load tykky
export PATH="/VarSCAT/bin:$PATH"

python VarSCAT.py -A --LRP 1 --vcf UPS.HG004.indel.recode.vcf --reference reference.fa --output VarSCAT_HG004
