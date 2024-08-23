# Container for tensorflow
# Compare compatibility for TF, CUDA, Python versions:
# https://www.tensorflow.org/install/source#tested_build_configurations
# This image has a max Cuda of 10.2 and python 3.8 as base.

#To build this file:
#sudo docker build . -t sydneyinformaticshub/jax

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run --gpus=all -it -v `pwd`:/project sydneyinformaticshub/jax /bin/bash -c "cd /project && ipython test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/jax

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build tf.img docker://sydneyinformaticshub/jax:

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --nv --bind /project:/project tf.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"

# Pull base image.
FROM sydneyinformaticshub/tensorflow:2.3
MAINTAINER Nathaniel Butterworth USYD SIH

# RUN touch /usr/bin/nvidia-smi

RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=10.2 -c pytorch

RUN pip install functorch transformers tokenizers datasets accelerate
RUN pip install dgl -f https://data.dgl.ai/wheels/cu102/repo.html

RUN pip install dglgo -f https://data.dgl.ai/wheels-test/repo.html

RUN pip install torchmetrics
RUN pip install sentencepiece
RUN pip install nltk
RUN pip install evaluate
RUN pip install wandb
RUN pip install tiktoken
RUN pip install prenlp
RUN pip install einops
RUN pip install --upgrade "jax[cuda102]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

RUN pip install flax
RUN pip install ml-collections
RUN pip install tensorboard
RUN pip install tensorflow-datasets
RUN pip install torchtext --no-deps 

CMD /build/miniconda3/bin/python
