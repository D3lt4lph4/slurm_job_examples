#!/bin/bash

# Slurm submission script, serial job
# CRIHAN v 1.00 - Jan 2017 
# support@criann.fr

#SBATCH --exclusive
#SBATCH --time 48:00:00
#SBATCH --mem 100000 
#SBATCH --mail-type ALL
#SBATCH --mail-user user@stuff.fr
#SBATCH --partition gpu_p100
#SBATCH --gres gpu:2
#SBATCH --nodes 1
#SBATCH --output %J.out
#SBATCH --error %J.err

module load cuda/9.0
module load python3-DL/keras/2.2.4

# Start the calculation on the first gpu
python3 mnist.py --gpu 0 &

# Start the calculation on the second gpu
python3 mnist.py --gpu 1 &

wait
