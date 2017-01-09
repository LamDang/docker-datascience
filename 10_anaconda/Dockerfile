FROM 00_jupyter_setup:latest

MAINTAINER Lam Dang

# Install the whole anaconda distribution
ENV ANACONDA_VERSION 4.2.0

USER root
RUN apt-get update --fix-missing && apt-get install -y \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools htop screen

# Install Anaconda
USER $NB_UID
RUN conda update -y conda
RUN conda install -c defaults -y anaconda==${ANACONDA_VERSION} && \
    conda clean -tipsy

# RUN conda install nomkl numpy scipy scikit-learn numexpr && \
#     conda remove mkl mkl-service

# Jupyter Lab
RUN conda install -y -c conda-forge jupyterlab

# Jupyter extension
RUN conda install -c conda-forge jupyter_contrib_nbextensions

USER root
COPY jupyter_custom.js /tmp/
RUN cat /tmp/jupyter_custom.js >> $CONDA_DIR/lib/python2.7/site-packages/notebook/static/custom/custom.js && \
    rm /tmp/jupyter_custom.js

# Create kernel
USER $NB_UID
RUN python -m ipykernel install --prefix=$CONDA_DIR --display-name "Python 2"

USER $NB_USER

