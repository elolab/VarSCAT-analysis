#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --output ClinVar_12_1.ambiguity_whole.output.txt
#SBATCH --error ClinVar_12_1.ambiguity_whole.Errors.txt
#SBATCH --job-name Clin_whole

python3 VarSCAT.py -A --vcf clinvar_20220109_no_scaffold.vcf --reference Homo_sapiens.GRCh38.dna.primary_assembly.fa --LRP 1 --HGVS 1 --flank 1 --neighbor 1 --output ambiguity_ClinVar_whole
