#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --job-name vt
#SBATCH --error vt.Errors.txt
#SBATCH --output vt.output.txt

/vt/vt normalize GATK_HG002_chr1_bioallelics.vcf -r GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -o vt_GATK_HG002_chr1_bioallelics.vcf

/vt/vt normalize GATK_HG006_chr1_bioallelics.vcf -r GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -o vt_GATK_HG006_chr1_bioallelics.vcf
