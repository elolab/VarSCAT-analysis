#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --job-name Krait
#SBATCH --error Krait.Errors.txt
#SBATCH --output Krait.output.txt

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG002_chr1_bioallelics.vcf --vcfinput -operation r,r,r /Krait/ -bed chr1_Krait_SSR_05_03.bed,chr1_Krait_SSR_05_03.bed,chr1_Krait_SSR_05_03.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG002.Krait.perfect

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG006_chr1_bioallelics.vcf --vcfinput -operation r,r,r /Krait/ -bed chr1_Krait_SSR_05_03.bed,chr1_Krait_SSR_05_03.bed,chr1_Krait_SSR_05_03.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG006.Krait.perfect

