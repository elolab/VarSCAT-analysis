#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --job-name vt_TR
#SBATCH --error vt_TR.Errors.txt
#SBATCH --output vt_TR.output.txt

/GATK/gatk-4.1.9.0/gatk VariantAnnotator -A TandemRepeat -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V vt_GATK_HG002_chr1_bioallelics.vcf -O GATK_HG002_chr1_TR.vcf

/GATK/gatk-4.1.9.0/gatk VariantAnnotator -A TandemRepeat -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V vt_GATK_HG006_chr1_bioallelics.vcf -O GATK_HG006_chr1_TR.vcf
