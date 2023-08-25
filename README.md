## Master Worker Flashback

### Objective

Compare the simulation time and memory footprint of the classical master-worker example provided in SimGrid distribution between different versions (currently 3.14 vs. 3.34)

### Requirements

  - Docker
  - Python3 and matplotlib

### Usage

Typing

```
make build
```

will:
  - build Docker images locally if needed; and
  - build the two versions of the simulators using these images.

Typing

```
make run
```

will:
  - run a set of experiments that produce a result figure in PDF, using whatever was build last. 


These experiments are for some default sets of numbers of hosts and numbers of trials (as encoded in the Makefile). These can be changed by typing, for instance:

```
make MIN_HOSTS=1000 MAX_HOSTS=10000 STEP_HOSTS=500 NUM_TRIALS=10 run
```


