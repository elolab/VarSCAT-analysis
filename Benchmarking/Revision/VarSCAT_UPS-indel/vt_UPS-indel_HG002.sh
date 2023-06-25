#!/bin/bash
#SBATCH --job-name=UPS-indel_vt1
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava
module load tykky
export PATH="/VarSCAT/bin:$PATH"

/gatk-4.1.9.0/gatk LeftAlignAndTrimVariants -R reference.fa -V UPS.HG002.indel.recode.vcf -O GATK.UPS.HG002.indel.recode.vcf --split-multi-allelics
/vt/vt normalize GATK.UPS.HG002.indel.recode.vcf -r reference.fa -o vt.GATK.UPS.HG002.indel.recode.vcf
./ups_indel reference.fa vt.GATK.UPS.HG002.indel.recode.vcf normalized_UPS_HG002 -hd=true