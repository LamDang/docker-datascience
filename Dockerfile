FROM ubuntu:xenial

USER root

ENV ANACONDA_VERSION 5.0.1
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER ipython
ENV NB_UID 1001
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV ADD_PKG_PATH /usr/local/additional_packages

ENV CUDA_VERSION 8.0
ENV CUDA_PKG_VERSION 8-0=8.0.61-1
ENV CUDNN_VERSION 6
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Add user
RUN useradd -m -s /bin/bash -u $NB_UID -U $NB_USER

USER $NB_USER
# Setup datascience home directory
RUN mkdir /home/$NB_USER/datalab && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

# Configure container startup as root
USER root


COPY build.sh /root/build.sh 
RUN chmod +x /root/build.sh && /root/build.sh

EXPOSE 8888
WORKDIR /home/$NB_USER/datalab/



USER $NB_USER
ENTRYPOINT ["tini", "--"]
