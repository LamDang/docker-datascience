FROM lamdang/00_jupyter_setup_py27:latest

MAINTAINER Lam Dang

# Install the whole anaconda distribution
ENV ANACONDA_VERSION 4.1.1

USER root
RUN apt-get update --fix-missing && apt-get install -y \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools htop screen

# Install Anaconda python 3
USER $NB_UID
RUN conda update -y conda
RUN conda install -c defaults -y anaconda==${ANACONDA_VERSION} && \
    conda clean -tipsy

# Create kernel
USER $NB_UID
RUN python -m ipykernel.kernelspec --prefix=$CONDA_DIR

USER $NB_USER

