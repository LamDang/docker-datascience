FROM 10_anaconda:latest
MAINTAINER Lam Dang

# Setup folder for non-Anaconda packages
USER root

ENV ADD_PKG_PATH /usr/local/additional_packages
RUN mkdir -m 777 ${ADD_PKG_PATH}
RUN apt-get update -y && apt-get install -yq cmake g++

# Install additional packages
# USER $NB_USER
## ML packages
RUN conda install -c conda-forge \
    xgboost \
    lightgbm

### hyperopt
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

### datarobot api
RUN pip install datarobot

## NLP
RUN conda install -y gensim && \
    conda install -c conda-forge spacy

### fastText
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/facebookresearch/fastText.git && \
    cd fastText && make -j4
RUN pip install fastText

## Image
RUN conda install -y opencv

## Distributed Computing
RUN conda install -y dask distributed fastparquet

## Viz: wordcloud, graphviz, pydot
RUN conda install -y graphviz seaborn pydotplus pandas-profiling
RUN conda install -y -c amueller wordcloud

# Cleanup
RUN conda clean -tipsy
USER $NB_USER
