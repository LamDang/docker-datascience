FROM lamdang/30_add_envs:latest

MAINTAINER LAM DANG

# Install CUDA
USER root
RUN cd /tmp && \
    wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && \
    echo "5cf65b8139d70270d9234d5ff4d697c7 *cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb" | md5sum -c - && \ 
    dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && \ 
    apt-get update && \
    apt-get install cuda 

# Install Theano
USER root
RUN apt-get update && apt-get install -y g++ libatlas-dev 

USER $NB_USER
RUN pip install theano 

# Install Keras
USER root
RUN apt-get update && apt-get install -y \
  libhdf5-dev \
  python-h5py \
  python-yaml 

USER $NB_USER
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/fchollet/keras.git && \
    cd keras && \
    python setup.py install
