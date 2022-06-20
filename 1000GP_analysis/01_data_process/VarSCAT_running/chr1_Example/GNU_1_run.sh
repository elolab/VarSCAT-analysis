#!/bin/sh
#SBATCH --cpus-per-task 24
#SBATCH --partition long
#SBATCH --output gnu.output.txt
#SBATCH --error gnu.Errors.txt
#SBATCH --job-name 01_gnu
source /myenv/bin/activate
time cat 1_index.txt | /parallel-20211222/src/parallel -P 24 python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf /1000GP/chr1/1000GP_chr1_no_genotype.vcf.gz --reference Homo_sapiens.GRCh38.dna.primary_assembly.fa --similarity 100 --gap_tolerate 0 --location {} --output {}
