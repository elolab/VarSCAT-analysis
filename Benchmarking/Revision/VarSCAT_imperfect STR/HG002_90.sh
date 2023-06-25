#!/bin/bash
#SBATCH --job-name=HG002
#SBATCH --account=project_2005545
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --partition=small
##SBATCH --mail-type=ning.wang@utu.fi

module load tykky
export PATH="/projappl/project_2005545/VarSCAT_site/bin:$PATH"

python /scratch/project_2005545/Ning/VarSCAT_site/VarSCAT/VarSCAT.py -T --vcf /scratch/project_2005545/Ning/data/HG002/HG002_GRCh38_1_22_v4.2.1_benchmark.vcf --reference /scratch/project_2005545/Ning/data/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --output revision_90_HG002 --similarity 75 --gap_tolerate -1 --min_match_per 90

