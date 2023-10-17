# Tensorflow Container

Docker/Singularity image to run [Tensorflow](https://www.tensorflow.org/) on Centos 6.9 host kernel with Cuda10.2.


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/tensorflow-contained.git
```
Then `cd tensorflow-contained` and modify the `artemis_build.pbs` script and launch with `qsub artemis_build.pbs`.
Then once the image has build  modify the `artemis_run.pbs` script and launch with `qsub artemis_run.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/tensorflow:2.3
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it --gpus=all -v `pwd`:/project sydneyinformaticshub/tensorflow:2.3 /bin/bash -c "cd /project && ipython test.py"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/tensorflow:2.3
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/tensorflow](https://hub.docker.com/r/sydneyinformaticshub/tensorflow)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build tf.img docker://sydneyinformaticshub/tensorflow:2.3
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --nv --bind /project:/project tf.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"
```
