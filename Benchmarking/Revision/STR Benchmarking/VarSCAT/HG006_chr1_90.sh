#!/bin/bash
#SBATCH --job-name=HG006_90
#SBATCH --account=project
#SBATCH --time=08:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --partition=small

module load tykky
export PATH="/VarSCAT/bin:$PATH"

python VarSCAT.py -T --similarity 75 --gap_tolerate -1 --min_match_per 90 --vcf HG006_GRCh38_1_22_v4.2.1_benchmark.chr1.vcf --reference GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --output revision_90_HG006_chr1

