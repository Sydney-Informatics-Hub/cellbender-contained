# Container for Tensorflow, Pytorch, Jax, and other Python Deep Learning tools.
# Compatibility has been balanced for Ubuntu 16.04 -> Cuda 10.2 -> and stacks herein.

#To build this file:
#sudo docker build . -t sydneyinformaticshub/pydl

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run --gpus=all -it -v `pwd`:/project sydneyinformaticshub/pydl /bin/bash -c "cd /project && ipython test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/pydl

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build pydl.img docker://sydneyinformaticshub/pydl:

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --nv --bind /project:/project pydl.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"

# Pull base image.
FROM sydneyinformaticshub/tensorflow:2.3
# Cotains ubuntu=16.04, cuda=10.2, conda=22.9.0, python=3.8.13, pytorch==1.11.0, tensorflow=2.3.0, scikit-learn==1.3.1
# Inherits Artemis touch points: /usr/bin/nvidia-smi, /project, and /scratch
LABEL Author="Nathaniel Butterworth USYD SIH"

# Update python to 3.10
# RUN conda install python=3.10

# Update to pytorch 1.12.1
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=10.2 -c pytorch

# Install additional packages.s
RUN pip install functorch==0.2.1 transformers datasets accelerate
RUN pip install dgl==1.1.1 -f https://data.dgl.ai/wheels/cu102/repo.html
RUN pip install dglgo==0.0.1
#
# # for translation tasks and sinkformer
RUN pip install torchmetrics==0.11.4 sentencepiece nltk evaluate tiktoken prenlp einops wandb==0.12
RUN pip install https://storage.googleapis.com/jax-releases/cuda102/jaxlib-0.1.71+cuda102-cp38-none-manylinux2010_x86_64.whl && \
pip install jax==0.1.71
# # for LRA
RUN pip install flax==0.2 ml-collections tensorflow-datasets && \
 pip install --no-deps torchtext==0.13
RUN pip cache purge

CMD /build/miniconda3/bin/python
