#!/bin/bash
#SBATCH --job-name=UPS-indel1
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava

./ups_indel reference.fa UPS.HG002.indel.recode.vcf HG002_UPS -hd=true
