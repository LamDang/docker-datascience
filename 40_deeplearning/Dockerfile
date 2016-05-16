FROM lamdang/30_add_envs:latest

MAINTAINER LAM DANG

# Install CUDA
USER root
RUN apt-get update && apt-get install -y kmod
RUN cd /tmp && \
    wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    echo "4b3bcecf0dfc35928a0898793cf3e4c6 *cuda_7.5.18_linux.run" | md5sum -c - && \ 
    chmod +x cuda_*_linux.run && \
    ./cuda_*_linux.run -extract=`pwd` && \    
    ./NVIDIA-Linux-x86_64-*.run -s --no-kernel-module && \
    ./cuda-linux64-rel-*.run -noprompt && \    
    rm -rf *

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Install CuDNN
USER root
RUN cd /tmp && \
    wget -q http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/libcudnn5_5.0.5-1+cuda7.5_amd64.deb && \
    dpkg -i libcudnn5_5.0.5-1+cuda7.5_amd64.deb && \
    apt-get update && apt-get install libcudnn5 && \
    rm -rf *

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
