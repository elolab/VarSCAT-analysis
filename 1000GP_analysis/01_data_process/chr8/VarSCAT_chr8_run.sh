#!/bin/bash
#SBATCH --job-name=1000_8
#SBATCH --account=project
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --partition=small

module load tykky
export PATH="/VarSCAT/bin:$PATH"

python VarSCAT.py -T --vcf 1000GP_chr8_no_genotype.vcf.gz --reference Homo_sapiens.GRCh38.dna.primary_assembly.fa --output chr8_1000
