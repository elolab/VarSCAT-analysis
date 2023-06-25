#!/bin/bash
#SBATCH --job-name=UPS-indel5
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava

./ups_indel reference.fa UPS.HG005.indel.recode.vcf UPS_data/HG005_UPS -hd=true

