#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition long
#SBATCH --job-name NA12878_1
source /myenv/bin/activate
python3 /VarSCAT/VarSCAT.py -A --LRP 1 --HGVS 1 --adjacent 1 -T --vcf NA12878.chr1.vcf --reference /Homo_sapiens/UCSC/hg38/Sequence/BWAIndex/genome.fa --similarity 100 --gap_tolerate 0 --output VarSCAT_chr1.txt
