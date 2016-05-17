FROM lamdang/30_add_envs:latest

MAINTAINER LAM DANG

# Install Theano
USER root
RUN apt-get update && apt-get install -y g++ liblapack-dev libatlas-dev libopenblas-dev 

USER $NB_USER
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/Theano/Theano.git && \
    cd Theano && python setup.py develop 

# Set up .theanorc for BLAS 
RUN echo "[blas]\nldflags=-L/usr/lib/ -lopenblas\n" > ~/.theanorc

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
