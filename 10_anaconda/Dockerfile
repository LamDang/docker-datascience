FROM lamdang/00_jupyter_setup:latest

MAINTAINER Lam Dang

# Install the whole anaconda distribution
USER root

RUN apt-get update -qq --fix-missing && apt-get install -yq \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools

USER $NB_USER

RUN conda update -yq conda
RUN conda install -yq anaconda!=custom && \
    conda clean -tipsy

USER root
RUN python -m nltk.downloader all -d /usr/share/nltk_data all 

# Setup folder for non-Anaconda packages
USER root

RUN mkdir /usr/local/additional_packages && \
    chown -R $NB_USER /usr/local/additional_packages
ENV ADD_PKG_PATH /usr/local/additional_packages

# Install additional packages
USER $NB_USER

### xgboost
RUN cd $ADD_PKG_PATH && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && make -s -j4 && \
    cd python-package && python setup.py install

### hyperopt
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

### plotly 
RUN pip install plotly

USER $NB_USER

