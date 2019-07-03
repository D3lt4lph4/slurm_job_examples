# Examples to start calculation on a multi-user distributed system using slurm

## Usage recommendations

### Sharing the system with others

When starting calculation on a distributed system, please always be aware that other users may want to use the system. Thus if you do not plan to use all the resources of a node, do not put the exclusive option. If the shared option is used, be aware that slurm will only lock one CPU core if the desired number is not specified. The recommendation is, if there is no special need for a high number of CPUs to ask for N_CPU * N_RESERVED_GPU / N_GPU

### Tensorflow limitations

When submitting a job slurm can reserve a number of CPU cores, but tensorflow spawns processes and seems to account for the total number of cores available on the node rather than for the number of core reserved. Although this problem is known and a solutions are investigated, it is useful to be aware of the it, because it can impede the calculation when the cores are used for other calculations.

## Examples available (keras)

- horovod calculation in the folder [mnist_horovod_example](mnist_horovod_example/README.md)
- multiple parallel calculations on a single node: [multiple_calculation_one_node](multiple_calculation_one_node/README.md)
