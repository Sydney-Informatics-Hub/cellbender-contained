# Container with 10x spaceranger

#To build this file:
#sudo docker build . -t sydneyinformaticshub/tensorflow:2.14

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run -it -v `pwd`:/project sydneyinformaticshub/tensorflow:2.14 /bin/bash -c "python test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/tensorflow:2.14

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build spaceranger.img docker://sydneyinformaticshub/tensorflow:2.14

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --bind /project:/project tf.img /bin/bash -c "cd "$PBS_O_WORKDIR" && python test.py"

# Pull base image.
FROM nbutter/pytorch
MAINTAINER Nathaniel Butterworth USYD SIH

RUN mkdir /project /scratch && touch /usr/bin/nvidia-smi

RUN pip install tensorflow==2.3 cudatoolkit=10.2 scikit-learn 


