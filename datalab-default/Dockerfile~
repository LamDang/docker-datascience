FROM lamdang/datalab:minimal

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

# Install the whole anaconda distribution
USER root

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

USER datalab

RUN conda update conda
RUN conda install anaconda

# Create Python 2 environment
RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 anaconda

USER root

# Install Python 2 kernel spec globally to avoid permission problems when NB_UID
# switching at runtime.
RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install

USER datalab
