#!/bin/bash

# Slurm submission script, serial job
# CRIHAN v 1.00 - Jan 2017 
# support@criann.fr

#SBATCH --exclusive
#SBATCH --time 1:00:00
#SBATCH --mem 10000 
#SBATCH --mail-type ALL
#SBATCH --mail-user user@stuff.fr
#SBATCH --partition gpu_p100
#SBATCH --gres gpu:2
#SBATCH --nodes 2
#SBATCH --output %J.out
#SBATCH --error %J.err
#SBATCH --cpus-per-task=10
#SBATCH --tasks-per-node=2

# Loading the required modules
module load cuda/9.0
module load python3-DL/3.6.1

# Starting the calculation
srun python3 mnist_horovod_example.py
