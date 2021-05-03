# Examples to start calculation on the CRIANN super-calculator (using slurm)

This repository gives basic examples to run calculation on the [CRIANN super-calculator](https://www.criann.fr/). This repository focuses on the usage of the GPUs for deep learning (although the code provided can be modified for other usages). **Please keep in mind that some of the details may not be up-to-date.**

If you work in the public french system, you may also want to check the national super-calculator, [Jean Zay](calculateur) (this [page](calculateur) may also be useful) as it should not be too hard to get some hours for a project.

## Available ressources

As of today, three types of GPUs are available on the calculator (details at the bottom of this [page](http://www-tech.criann.fr/calcul/tech/myria-doc/guide-util)):

- K80, 9 nodes: 4 GPUs, 32 CPUs and 128 Go top per node, limited to 8 nodes at the same time
- P100, 9 nodes: 4 GPUs, 32 CPUs and 128 Go top per node, limited to 8 nodes at the same time
- v100, 5 nodes: 4 GPUs, 32 CPUs and 180 Go top per node, limited to 5 nodes at the same time

The GPUs are sorted from the less powerful (K80) to the most powerful (V100). Please keep in mind that unless your code was designed to run on multiple nodes, reserving more than one node will be useless.

## Basic overview of the system

MYRIA is a super-calculator shared by many users, hence it needs a system to handle calculations from many users with very different requirements in softwares. To solve both of these problems, SLURM and a module system are used.

SLURM allow for various users to queue their calculations (jobs). SLURM will then automatically schedule jobs so that the computation resources are used at their maximum.

The module system allows for the loading of pre-installed stuff (python, specific softwares, ...). All the available modules can be listed using the following command:

```bash
# List all the modules
module avail

# List the active modules
module list
```

As you will see in the examples, modules are loaded on the fly when a queued job starts.

In order to queue a job, one need to write a script (script.sl) and submit it:

```bash
# submit a job
sbatch script.sl
```

Various scripts are provided in this repository. But for now let's have a look at a simple one:

```bash
#!/bin/bash

# Slurm submission script, serial job
# CRIHAN v 1.00 - Jan 2017
# support@criann.fr

# Time limit for the calculation (48:00:00 max)
#SBATCH --time 24:00:00

# Memory to use (here 50Go)
#SBATCH --mem 50000

# Where to mail when the job is queued/starts/ends
#SBATCH --mail-type ALL
#SBATCH --mail-user mail@user.fr

# Type of gpu to use, either gpu_all, gpu_k80, gpu_p100 or gpu_v100
#SBATCH --partition gpu_p100

# Number of gpu to use
#SBATCH --gres gpu:1

# Number of node to use
#SBATCH --nodes 1

# Number of cpu to use
#SBATCH --cpus-per-task=7


# Were to write the logs
#SBATCH --output %J.out
#SBATCH --error %J.err

module load cuda/9.0
module load python3-DL/keras/2.2.4

# Start the calculation (safer to use srun)
srun python3 mnist.py
```

The script can be roughly divided into 2 parts:

- #SBATCH
- bash commands

The #SBATCH tag is used to pass options to SLURM. All the option used are detailed above, but one thing still needs to be highlighted. SLURM will read all your parameters and try to fit your job in the schedule, as the resources on nodes are limited, if you demand too much your job may start way later than it could have. For instance, if my job requires 1 hour of calculations any 1 hour gap (or longer) in the schedule could be used but if I ask for 24 hours, SLURM will try to find a 24 hours gap in the schedule (which may postpone the start of the training). The same goes for any parameters, asking for more than required is mostly risking to have the job postponed.

The bash commands are all the commands used to prepare and start your calculation. Here we can see that two modules are loaded and then the calculation script is started.

## Usage recommendations

A few recommendations are given to the users, they are here to simplify the work of the support in case of problems and to avoid taking resources that one don't need from others.

### Virtual environnement

It is not recommended to use virtual environnement for various reasons. Rather, one should prefer loading a python module and redefining the path to save the different packages:

```bash
module load python3-DL/3.6.1

export PYTHONUSERBASE=/path/to/my/dir/to/save/packages

pip install numpy --user
```

Please not that loading and installing and stuff can be done out of a slurm script.

### Sharing the system with others

When starting calculation on a distributed system, please always be aware that other users may want to use the system. Thus if you do not plan to use all the resources of a node, do not put the "exclusive" option, use instead "share". If the "share" option is used, be aware that **slurm will only lock one CPU core if the desired number is not specified.**

The recommendation is, if there is no special need for a high number of CPUs to ask for N_CPU * N_RESERVED_GPU / N_GPU. For instance on a node with 4 GPUs and 32 CPUs it is recommended to ask for 8 CPUs per reserved GPU.

## Available examples

The official documentation for the usage of the GPUs is [here](http://www-tech.criann.fr/calcul/tech/myria-doc/gpgpu#Architecture%20V100-SXM2), but is not oriented specifically towards deep-learning. The available examples are using keras/tensorflow  on a single node (more details when following the links):

- One calculation on one node: [here](one_calculation_one_node/README.md)
- Multiple calculations on one node: [here](multiple_calculation_one_node/README.md)

To run the calculations on multiple nodes, the calculator supports the usage of horovod:

- Run a calculation on horovod: [here](mnist_horovod_example/README.md)

## Useful tips

Here is a list of a few useful commands and stuff.

### Environnement variables

When starting a job, some environnement variables are defined:

- $SLURM_JOB_ID: Id of the job
- $SLURM_JOB_NAME: Name of the job
- $SLURM_SUBMIT_DIR: Submit repository
- $LOCAL_WORK_DIR: Folder created when the job starts, should be used to save all the results (no limitation in memory, cleared after 45 days)

### Few slurm commands

The list is available [here](http://www-tech.criann.fr/calcul/tech/myria-doc/guide-util#Soumission)

```bash
# Information about the nodes
sinfo

# List of the queued jobs
squeue

# List of own queued jobs
squeue -u login

# List and expected start time of own jobs
squeue -u login --start
```
