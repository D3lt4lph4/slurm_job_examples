# Horovod on a distributed system with slurm

The file in the folder are given the usage with the calculator [MYRIA](http://www-tech.criann.fr/calcul/tech/myria-doc/guide-util/), if you want to use it on another system, please modify the code accordingly.

The example is the advance example from [horovod github] for keras. For more details please refer to their github.

**Warning:** 
Please be aware that calculation on multiple node is not straight forward and require some readings and optimizations both on the GPUs and CPUs side. As a first step in multi-calculation, please refer to [1](https://arxiv.org/abs/1404.5997), [2](https://www.research.ed.ac.uk/portal/files/75846467/width_of_minima_reached_by_stochastic_gradient_descent_is_influenced_by_learning_rate_to_batch_size_ratio.pdf) and [3](https://arxiv.org/abs/1706.02677).
