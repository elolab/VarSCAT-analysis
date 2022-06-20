#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --output N1.output.txt
#SBATCH --error N1.Errors.txt
#SBATCH --job-name N1

/bcftools-1.5/bcftools view -G -l 5 ALL.chr1.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz > 1000GP_chr1_no_genotype.vcf.gz
