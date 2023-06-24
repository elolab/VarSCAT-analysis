#!/bin/bash
#SBATCH --job-name=NA12878
#SBATCH --account=project
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --partition=small

module load tykky
export PATH="/VarSCAT/bin:$PATH"

python VarSCAT.py -T --vcf NA12878.vcf.gz --reference hg38.fa --output NA12878
