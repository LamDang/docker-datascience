FROM 20_spark:latest

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
    conda install -y libgcc && \ 
    python setup.py install

### hyperopt
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

### vowpal wabbit
USER root
RUN apt-get update -y --fix-missing && apt-get install -y libboost-program-options-dev \
    zlib1g-dev \
    libboost-python-dev

RUN cd $ADD_PKG_PATH && \
    git clone git://github.com/JohnLangford/vowpal_wabbit.git && \
    chown -R $NB_UID vowpal_wabbit && \
    cd vowpal_wabbit && make -s -j4 && make -s install

USER $NB_UID
RUN cd $ADD_PKG_PATH/vowpal_wabbit/python && \
    python setup.py develop
#RUN pip install vowpalwabbit

### gensim
RUN conda install -y gensim

### datarobot api
RUN pip install datarobot

### Update scikit-learn
RUN conda install -y scikit-learn=0.18.1=np111py27_0

### LightGBM
USER root
RUN apt-get install -yq cmake

USER $NB_UID
RUN cd $ADD_PKG_PATH && \
    git clone --recursive https://github.com/Microsoft/LightGBM && \
    cd LightGBM && mkdir build && cd build && \
    cmake .. && make -j && \
    cd ../python-package && python setup.py install

### dask distributed
RUN conda install -y dask distributed -c conda-forge

### pandas profiling
RUN conda install pandas-profiling

### fastText
RUN cd $ADD_PKG_PATH && \ 
    git clone https://github.com/facebookresearch/fastText.git && \
    cd fastText && make
RUN pip install fastText

### Viz: wordcloud, graphviz, pydot
USER root
RUN apt-get install -y graphviz

USER $NB_UID
RUN conda install -y graphviz seaborn
RUN conda install -y -c amueller wordcloud

USER $NB_USER

