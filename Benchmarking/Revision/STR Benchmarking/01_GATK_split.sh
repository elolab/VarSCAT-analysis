#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --job-name split
#SBATCH --error split.Errors.txt
#SBATCH --output split.output.txt

/GATK/gatk-4.1.9.0/gatk LeftAlignAndTrimVariants -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V HG002_GRCh38_1_22_v4.2.1_benchmark.chr1.vcf -O GATK_HG002_chr1_bioallelics.vcf --split-multi-allelics

/GATK/gatk-4.1.9.0/gatk LeftAlignAndTrimVariants -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V HG006_GRCh38_1_22_v4.2.1_benchmark.chr1.vcf -O GATK_HG006_chr1_bioallelics.vcf --split-multi-allelics
