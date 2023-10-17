# Tensorflow Container

Docker/Singularity image to run [Tensorflow](https://www.tensorflow.org/) on Centos 6.9 host kernel with Cuda10.2. The container is built on Ubuntu 16.04 image. 


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g. in the quickest way you can:

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/tensorflow-contained.git
cd tensorflow-contained
jobid=`qsub artemis_build.pbs`
qsub -W depend=afterok:$jobid artemis_run.pbs
```
Be sure to modify the `artemis_build.pbs` and `artemis_run.pbs` script to match your needs.

Once you have built the container image you can move that to where your data is or vice-versa, or just point to it to launch the image.



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
This will create the `tf.img` image file.

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --nv --bind /project:/project tf.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"
```
