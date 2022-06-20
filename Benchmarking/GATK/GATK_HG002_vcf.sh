#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --time 12:00:00
#SBATCH --job-name HG002.TR
#SBATCH --error HG002.TR.Errors.txt
#SBATCH --output HG002.TR.output.txt

/gatk-4.1.9.0/gatk LeftAlignAndTrimVariants -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V HG002_GRCh38_1_22_v4.2.1_benchmark.chr1.vcf -O GATK_HG002_chr1_bioallelics.vcf --split-multi-allelics
/vt/vt normalize GATK_HG002_chr1_bioallelics.vcf -r GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -o vt_GATK_HG002_chr1_bioallelics.vcf
/gatk-4.1.9.0/gatk VariantAnnotator -A TandemRepeat -R GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -V vt_GATK_HG002_chr1_bioallelics.vcf -O GATK_HG002_chr1_TR.vcf
