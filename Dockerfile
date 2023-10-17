# Container for tensorflow
# Compare compatibility for TF, CUDA, Python versions:
# https://www.tensorflow.org/install/source#tested_build_configurations
# This image has a max Cuda of 10.2 and python 3.8 as base.

#To build this file:
#sudo docker build . -t sydneyinformaticshub/tensorflow:2.3

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run --gpus=all -it -v `pwd`:/project sydneyinformaticshub/tensorflow:2.3 /bin/bash -c "cd /project && ipython test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/tensorflow:2.3

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build tf.img docker://sydneyinformaticshub/tensorflow:2.3

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --nv --bind /project:/project tf.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"

# Pull base image.
FROM nbutter/pytorch:ubuntu1604
MAINTAINER Nathaniel Butterworth USYD SIH

RUN touch /usr/bin/nvidia-smi

# Fix a few bugs by upgrading these libraries
RUN pip install -U scikit-learn numpy protobuf pandas==1.4.4 matplotlib==3.5.3 ipython && \
  pip install -U tensorflow==2.3 && \
  pip install -U protobuf==3.20.* && \
  pip cache purge


#TF 2.3 uses Cuda 10.1, so just copy Cuda10.2
RUN ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudart.so /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudart.so.10.1
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.2/targets/x86_64-linux/lib/

CMD /build/miniconda3/bin/python
