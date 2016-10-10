FROM lamdang/30_add_packages_py35:latest

MAINTAINER LAM DANG

LABEL com.nvidia.volumes.needed="nvidia_driver"

# Install CUDA & CuDNN

###############################
### COPY FROM NVIDIA-DOCKER ###
###############################

ENV CUDA_VERSION 7.5
ENV CUDA_PKG_VERSION 7-5=7.5-18
ENV CUDNN_VERSION 5.1

# Add CUDA Repo
USER root

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +2 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64 /" > /etc/apt/sources.list.d/cuda.list

# Install cuda 
RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-$CUDA_PKG_VERSION \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-$CUDA_VERSION /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/cuda/lib" >> /etc/ld.so.conf.d/cuda.conf && \
    echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-misc-headers-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-license-$CUDA_PKG_VERSION \
        cuda-nvrtc-dev-$CUDA_PKG_VERSION \
        cuda-cusolver-dev-$CUDA_PKG_VERSION \
        cuda-cublas-dev-$CUDA_PKG_VERSION \
        cuda-cufft-dev-$CUDA_PKG_VERSION \
        cuda-curand-dev-$CUDA_PKG_VERSION \
        cuda-cusparse-dev-$CUDA_PKG_VERSION \
        cuda-npp-dev-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-driver-dev-$CUDA_PKG_VERSION && \
    cd /tmp && apt-get download gpu-deployment-kit && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/gpu-deployment-kit && cd /tmp/gpu-deployment-kit && \
    dpkg -x /tmp/gpu-deployment-kit_*.deb . && \
    mv usr/include/nvidia/gdk/* /usr/local/cuda/include && \
    mv usr/src/gdk/nvml/lib/* /usr/local/cuda/lib64/stubs && \
    rm -rf /tmp/gpu-deployment-kit*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs:${LIBRARY_PATH}

# Install CuDNN
USER root

#RUN CUDNN_DOWNLOAD_SUM=40d506d0a8a00a3faccce1433346806b8cd2535683b6f08a63683ce6e474419f && \
#    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-7.5-linux-x64-v5.1.tgz -O && \
#    echo "$CUDNN_DOWNLOAD_SUM  cudnn-7.5-linux-x64-v5.1.tgz" | sha256sum -c --strict - && \
#    tar -xzf cudnn-7.5-linux-x64-v5.1.tgz -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*' && \
#    rm cudnn-7.5-linux-x64-v5.1.tgz && \
#    ldconfig

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
            libcudnn5 libcudnn5-dev && \
    rm -rf /var/lib/apt/lists/*

###################
### END OF COPY ###
###################

# Install Theano
USER root
RUN apt-get update && apt-get install -y g++ liblapack-dev libatlas-dev libopenblas-dev 

USER $NB_USER
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/Theano/Theano.git && \
    cd Theano && \
    python setup.py develop

# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\nmode=FAST_RUN\n[nvcc]\nfastmath=True\n" >> /home/${NB_USER}/.theanorc

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

# Install tensorflow
USER root
RUN apt-get update && apt-get install -y python-dev python-pip 

USER $NB_USER
RUN export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0rc0-cp35-cp35m-linux_x86_64.whl && \
    pip install --ignore-installed --upgrade $TF_BINARY_URL 


