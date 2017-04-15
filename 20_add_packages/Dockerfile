FROM 10_anaconda:latest
MAINTAINER Lam Dang

# Setup folder for non-Anaconda packages
USER root

ENV ADD_PKG_PATH /usr/local/additional_packages
RUN mkdir -m 777 ${ADD_PKG_PATH}
RUN apt-get install -yq cmake g++

# Install additional packages
USER $NB_USER
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
RUN apt-get update -y && apt-get install -y libboost-program-options-dev \
    zlib1g-dev \
    libboost-python-dev

RUN cd $ADD_PKG_PATH && \
    git clone git://github.com/JohnLangford/vowpal_wabbit.git && \
    chown -R $NB_USER:$NB_USER vowpal_wabbit && \
    cd vowpal_wabbit && make -s -j4 && make -s install

USER $NB_USER
RUN cd $ADD_PKG_PATH/vowpal_wabbit/python && \
    python setup.py develop

### gensim
RUN conda install -y gensim

### datarobot api
RUN pip install datarobot

### LightGBM
USER $NB_USER
RUN cd $ADD_PKG_PATH && \
    git clone --recursive https://github.com/Microsoft/LightGBM && \
    cd LightGBM && mkdir build && cd build && \
    cmake .. && make -j4 && \
    cd ../python-package && python setup.py install

### dask distributed
RUN conda install -y dask distributed -c conda-forge

### pandas profiling
RUN conda install -y pandas-profiling -c conda-forge

### fastText
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/facebookresearch/fastText.git && \
    cd fastText && make -j4
RUN pip install fastText

### Viz: wordcloud, graphviz, pydot
USER root
RUN apt-get install -y graphviz

USER $NB_USER
RUN conda install -y graphviz seaborn
RUN conda install -y -c amueller wordcloud
RUN conda install -y -c conda-forge fastparquet

USER $NB_USER
