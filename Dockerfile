# Container for Cellbender with GPU support to run on Artemis
# Compatibility has been balanced for Ubuntu 16.04 -> Cuda 10.2 -> and stacks herein.

#To build this file:
#sudo docker build . -t sydneyinformaticshub/cellbender

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run --gpus=all -it -v `pwd`:/project sydneyinformaticshub/cellbender /bin/bash -c "cd /project && ipython test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/cellbender

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build cellbender.img docker://sydneyinformaticshub/cellbender:

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --nv --bind /project:/project cellbender.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"

# Pull base image.
FROM sydneyinformaticshub/tensorflow:2.3
# Cotains ubuntu=16.04, cuda=10.2, conda=22.9.0, python=3.8.13, pytorch==1.11.0, tensorflow=2.3.0, scikit-learn==1.3.1
# Inherits Artemis touch points: /usr/bin/nvidia-smi, /project, and /scratch
LABEL Author="Nathaniel Butterworth USYD SIH"

# Update python to 3.10
# RUN conda install python=3.10

# Update to pytorch 1.12.1
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=10.2 -c pytorch

### New from https://github.com/broadinstitute/CellBender

# Copy the local cellbender repo
WORKDIR /software
RUN git clone https://github.com/broadinstitute/CellBender

ENV DOCKER=true \
    CONDA_AUTO_UPDATE_CONDA=false \
    CONDA_DIR="/opt/conda" \
    GCLOUD_DIR="/opt/gcloud" \
    GOOGLE_CLOUD_CLI_VERSION="397.0.0" \
    GIT_SHA=$GIT_SHA
ENV PATH="$CONDA_DIR/bin:$GCLOUD_DIR/google-cloud-sdk/bin:$PATH"

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates sudo \
 && apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/* \
# get gsutil
 && mkdir -p $GCLOUD_DIR \
 && curl -so $HOME/google-cloud-cli.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GOOGLE_CLOUD_CLI_VERSION}-linux-x86_64.tar.gz \
 && tar -xzf $HOME/google-cloud-cli.tar.gz -C $GCLOUD_DIR \
 && .$GCLOUD_DIR/google-cloud-sdk/install.sh --usage-reporting false \
 && rm $HOME/google-cloud-cli.tar.gz \
# get compiled crcmod for gsutil
 && conda install -y -c conda-forge crcmod \
# install cellbender and its dependencies
 && yes | pip install -e /software/CellBender/ \
 && conda clean -yaf \
 && sudo rm -rf ~/.cache/pip

CMD /build/miniconda3/bin/python
