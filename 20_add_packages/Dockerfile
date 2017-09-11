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
RUN conda install -y dask distributed fastparquet && \
    conda install -y -c conda-forge pyarrow python-snappy

## Viz: wordcloud, graphviz, pydot
RUN conda install -y \
    graphviz python-graphviz pydotplus \
    seaborn pandas-profiling
RUN conda install -y -c amueller wordcloud
### bokeh set
RUN conda install -y bokeh holoviews datashader
### plotly set
RUN pip install \
    dash==0.17.7 \
    dash-renderer==0.7.4 \
    dash-html-components==0.7.0 \
    dash-core-components==0.12.4 \
    plotly==2.0.15
### brunel
RUN pip install brunel

### Some specialized pkgs
RUN conda install -c conda-forge lifelines nlopt -y && \
    conda install -c glemaitre imbalanced-learn -y
RUN conda install -y -c conda-forge \
    jellyfish \
    python-Levenshtein \
    python-igraph \
    fuzzywuzzy

RUN pip install bottle
# Cleanup
RUN conda clean -tipsy
USER $NB_USER
