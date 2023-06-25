#!/bin/bash
#SBATCH --job-name=UPS-indel_vt2
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava
module load tykky
export PATH="/VarSCAT/bin:$PATH"

/gatk-4.1.9.0/gatk LeftAlignAndTrimVariants -R reference.fa -V UPS.HG003.indel.recode.vcf -O GATK.UPS.HG003.indel.recode.vcf --split-multi-allelics
/vt/vt normalize GATK.UPS.HG003.indel.recode.vcf -r reference.fa -o vt.GATK.UPS.HG003.indel.recode.vcf
./ups_indel reference.fa vt.GATK.UPS.HG003.indel.recode.vcf UPS_data/normalized_UPS_HG003 -hd=true
