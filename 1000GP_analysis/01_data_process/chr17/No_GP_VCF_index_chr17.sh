#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --job-name N17
/bcftools-1.5/bcftools view -G -l 5 ALL.chr17.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz > 1000GP_chr17_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf 1000GP_chr17_no_genotype.vcf.gz
