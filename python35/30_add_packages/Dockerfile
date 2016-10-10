FROM lamdang/20_spark_py35:latest

MAINTAINER Lam Dang

# Setup folder for non-Anaconda packages
USER root

RUN mkdir /usr/local/additional_packages && \
    chown -R $NB_UID /usr/local/additional_packages
ENV ADD_PKG_PATH /usr/local/additional_packages

# Install additional packages
USER $NB_UID

### xgboost
RUN cd $ADD_PKG_PATH && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && make -s -j4 && \
    cd python-package && \
    python setup.py install

### hyperopt
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

### vowpal wabbit
USER root
RUN apt-get update -y && apt-get install -y libboost-program-options-dev \
    zlib1g-dev \
    libboost-python-dev
RUN cd $ADD_PKG_PATH && \
    git clone git://github.com/JohnLangford/vowpal_wabbit.git && \
    chmod a+rwx vowpal_wabbit && \
    cd vowpal_wabbit make -s -j4 && make -s install

USER $NB_UID
RUN cd $ADD_PKG_PATH/vowpal_wabbit/python && \
    pip install vowpalwabbit

### gensim
RUN conda install -y gensim

### datarobot api
RUN pip install datarobot

USER $NB_USER

