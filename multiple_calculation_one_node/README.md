# Multiple calculations on one node

As the system is shared between users and has a limited number of ressources it can be useful to be able to start multiple parallel calculations on a single node.

The example presented in here will start 2 calculation on a p100 node (2 gpus), one calculation for each of the gpus.

Please not that the example is suboptimal in many ways and should be optimized to the problem at hand. Please also note that if you run a very small network (as the mnist example given here) you may want to start many calculations on one of the gpus. Please check [this link](https://stackoverflow.com/questions/34199233/how-to-prevent-tensorflow-from-allocating-the-totality-of-a-gpu-memory) for more details on the way to prevent tensorflow to take all the resources available for a single calculation.

As the scripts makes usage of the environment variable "CUDA_VISIBLE_DEVICES", it will not support multi-node calculation. Be also aware that this example works well for this peculiar setting, i.e one calculation per gpus in parallel without interaction between them, there is no guarantee that it will work for other settings.
