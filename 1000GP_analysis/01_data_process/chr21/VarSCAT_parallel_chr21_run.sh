#!/bin/sh
#SBATCH --cpus-per-task 24
#SBATCH --partition long
#SBATCH --job-name gnu_21
source /myenv/bin/activate
time cat 21_index.txt | /parallel-20211222/src/parallel -P 24 python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf 1000GP_chr21_no_genotype.vcf.gz --reference /GRCh38/Sequence/WholeGenomeFasta/Homo_sapiens.GRCh38.dna.primary_assembly.fa --location {} --output {}
