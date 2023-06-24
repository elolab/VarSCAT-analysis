#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition long
#SBATCH --job-name HG006_17
source /myenv/bin/activate
python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf HG006_GRCh38_1_22_v4.2.1_benchmark.chr17.vcf --reference /GIAB/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta --similarity 100 --gap_tolerate 0 --output VarSCAT_chr17.txt
