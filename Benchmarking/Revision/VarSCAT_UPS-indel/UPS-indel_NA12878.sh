#!/bin/bash
#SBATCH --job-name=UPS-indel8
#SBATCH --account=project
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=small

module spider java
module load biojava

./ups_indel reference.fa UPS.NA12878.indel.recode.vcf UPS_data/NA12878_UPS -hd=true
