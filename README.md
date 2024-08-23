# Deep Learning Container

Docker/Singularity image to run various Deep Learning tools on Centos 6.9 host kernel with Cuda10.2. The container is built on Ubuntu 16.04 image.


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g. in the quickest way you can:

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/pydl-contained.git
cd pydl-contained
jobid=`qsub artemis_build.pbs`
qsub -W depend=afterok:$jobid artemis_run.pbs
```
Be sure to modify the `artemis_build.pbs` and `artemis_run.pbs` script to match your needs.

Once you have built the container image you can move that to where your data is or vice-versa, or just point to it to launch the image.



# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/pydl
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it --gpus=all -v `pwd`:/project sydneyinformaticshub/pydl /bin/bash -c "cd /project && ipython test.py"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/pydl
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/pydl](https://hub.docker.com/r/sydneyinformaticshub/pydl)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build pydl.img docker://sydneyinformaticshub/pydl
```
This will create the `pydl.img` image file.

## Run with singularity
To run the singularity image (noting singularity attempts to mount the current folder by default plus /project and /scratch)
```
singularity run --nv pydl.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"
```
