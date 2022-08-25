#!/bin/sh
#SBATCH --cpus-per-task 1
#SBATCH --partition normal
#SBATCH --job-name E_X

source /myenv/bin/activate
python3 extract_INFO_GP.py
