#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition short
#SBATCH --output index.output.txt
#SBATCH --error index.Errors.txt
#SBATCH --job-name index

/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr2/1000GP_chr2_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr2/1000GP_chr2_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr3/1000GP_chr3_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr4/1000GP_chr4_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr5/1000GP_chr5_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr6/1000GP_chr6_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr7/1000GP_chr7_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr8/1000GP_chr8_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr9/1000GP_chr9_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr10/1000GP_chr10_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr11/1000GP_chr11_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr12/1000GP_chr12_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr13/1000GP_chr13_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr14/1000GP_chr14_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr15/1000GP_chr15_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr16/1000GP_chr16_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr17/1000GP_chr17_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr18/1000GP_chr18_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr19/1000GP_chr19_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr20/1000GP_chr20_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr21/1000GP_chr21_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chr22/1000GP_chr22_no_genotype.vcf.gz
/samtools-1.5/htslib-1.5/tabix -p vcf /1000GP/chrX/1000GP_chrX_no_genotype.vcf.gz
