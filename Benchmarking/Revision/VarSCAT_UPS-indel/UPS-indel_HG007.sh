#!/bin/bash
#SBATCH --job-name=UPS-indel6
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava

./ups_indel reference.fa UPS.HG007.indel.recode.vcf HG007_UPS -hd=true
