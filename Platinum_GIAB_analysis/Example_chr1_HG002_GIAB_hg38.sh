#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition long
#SBATCH --time 1-00:00:00
#SBATCH --output HG002_chr1_p.output.txt
#SBATCH --error HG002_chr1_p.Errors.txt
#SBATCH --job-name 02_chr1_p

source /myenv/bin/activate
python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf HG002_GRCh38_1_22_v4.2.1_benchmark.chr1.vcf --reference GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --similarity 100 --gap_tolerate 0 --output 05_03_2022_chr1_p
