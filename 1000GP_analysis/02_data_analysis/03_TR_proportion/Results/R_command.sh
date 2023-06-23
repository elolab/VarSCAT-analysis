#!/bin/bash -l
#SBATCH --account=project
#SBATCH --partition=small
#SBATCH --time=12:00:00
#SBATCH --job-name=R_1000
#SBATCH --mem-per-cpu=50G

# Load r-env
module load r-env

# Clean up .Renviron file in home directory
if test -f ~/.Renviron; then
    sed -i '/TMPDIR/d' ~/.Renviron
fi

# Specify a temp folder path
echo "TMPDIR=/scratch/project_2005545" >> ~/.Renviron

# Run the R script
srun apptainer_wrapper exec Rscript --no-save 03_sample_level_counts_TR_non_TR.R
