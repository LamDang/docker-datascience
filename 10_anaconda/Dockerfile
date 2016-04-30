FROM lamdang/ds-jupyter-setup:latest

MAINTAINER Lam Dang

# Install the whole anaconda distribution
USER root

RUN apt-get update --fix-missing && apt-get install -yq \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

USER $NB_USER

RUN conda update conda
RUN conda install anaconda

# Create Python 2 environment
# RUN conda create --yes -p $CONDA_DIR/envs/python2 python=2.7 anaconda

# USER root

# Install Python 2 kernel spec globally to avoid permission problems when NB_UID
# switching at runtime.
# RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install

# Install R in conda
# USER $NB_USER

#RUN conda config --add channels r && \
#    conda install --yes \
#    'rpy2=2.7*' \
#    'r-base=3.2*' \
#    'r-irkernel=0.5*' \
#    'r-plyr=1.8*' \
#    'r-devtools=1.9*' \
#    'r-dplyr=0.4*' \
#    'r-ggplot2=1.0*' \
#    'r-tidyr=0.3*' \
#    'r-shiny=0.12*' \
#    'r-rmarkdown=0.8*' \
#    'r-forecast=5.8*' \
#    'r-stringr=0.6*' \
#    'r-rsqlite=1.0*' \
#    'r-reshape2=1.4*' \
#    'r-nycflights13=0.1*' \
#    'r-caret=6.0*' \
#    'r-rcurl=1.95*' \
#    'r-randomforest=4.6*' && conda clean -tipsy

USER $NB_USER
