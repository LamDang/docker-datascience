FROM lamdang/30_add_envs:latest

MAINTAINER LAM DANG

# Create new conda env for deep learning
USER $NB_USER
RUN conda create --yes -n py3_deeplearning --clone root
 
USER root
RUN  bash -c '. activate py3_deeplearning && \
        python -m ipykernel install --prefix=$CONDA_DIR --name python3_deeplearning --display-name "Python 3 Deep Learning" && \
        . deactivate'

# Install Theano
USER root
RUN apt-get update && apt-get install -y g++ liblapack-dev libatlas-dev libopenblas-dev 

USER $NB_USER
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/Theano/Theano.git && \
    cd Theano && \
    bash -c '. activate py3_deeplearning && \
	python setup.py develop && \
	. deactivate' 


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
    bash -c '. activate py3_deeplearning && \
    	python setup.py install && \ 
	. deactivate' 

# Install tensorflow
USER root
RUN apt-get update && apt-get install -y python-dev python-pip 

USER $NB_USER
RUN cd /tmp && \
    wget -q https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.8.0-cp34-cp34m-linux_x86_64.whl && \
    mv tensorflow-0.8.0-cp34-cp34m-linux_x86_64.whl tensorflow-0.8.0-cp35-cp35m-linux_x86_64.whl && \ 
    bash -c '. activate py3_deeplearning && \
	pip install tensorflow* && \
	. deactivate'

