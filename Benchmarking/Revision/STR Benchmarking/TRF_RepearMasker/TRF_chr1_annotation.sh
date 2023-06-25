#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --job-name TRF
#SBATCH --error TRF.Errors.txt
#SBATCH --output TRF.output.txt

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG002_chr1_bioallelics.vcf --vcfinput -operation r,r,r /TRF/ -bed chr1_TRF_UCSC_100_match.bed,chr1_TRF_UCSC_100_match.bed,chr1_TRF_UCSC_100_match.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG002_chr1.TRF.UCSC_100_match

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG002_chr1_bioallelics.vcf --vcfinput -operation r,r,r /TRF/ -bed chr1_RM_UCSC_100_match.bed,chr1_RM_UCSC_100_match.bed,chr1_RM_UCSC_100_match.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG002_chr1.RM.UCSC_100_match

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG006_chr1_bioallelics.vcf --vcfinput -operation r,r,r /TRF/ -bed chr1_TRF_UCSC_100_match.bed,chr1_TRF_UCSC_100_match.bed,chr1_TRF_UCSC_100_match.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG006_chr1.TRF.UCSC_100_match

perl /annovar/table_annovar.pl -buildver hg38 -protocol bed,bed,bed vt_GATK_HG006_chr1_bioallelics.vcf --vcfinput -operation r,r,r /TRF/ -bed chr1_RM_UCSC_100_match.bed,chr1_RM_UCSC_100_match.bed,chr1_RM_UCSC_100_match.bed -arg '-colsWanted 2','-colsWanted 3','-colsWanted 4' -out HG006_chr1.RM.UCSC_100_match
