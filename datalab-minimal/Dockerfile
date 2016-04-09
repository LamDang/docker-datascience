FROM continuumio/anaconda3:latest

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

# Partially replicate https://github.com/jupyter/docker-stacks/blob/master/minimal-notebook/Dockerfile
## Install all OS dependencies for fully functional notebook server

USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git \
    vim \
    jed \
    emacs \
    wget \
    build-essential \
    python-dev \
    ca-certificates \
    bzip2 \
    unzip \
    libsm6 \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    sudo \
    locales \
    libxrender1 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

## Configure environment
ENV CONDA_DIR /opt/conda
#ENV PATH $CONDA_DIR/bin:$PATH #
ENV SHELL /bin/bash
ENV NB_USER datalab #
ENV NB_UID 1000
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create datalab user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p /opt/conda && \
    chown datalab /opt/conda

USER datalab

# Setup datalab home directory
RUN mkdir /home/$NB_USER/work && \ # work for script
    mkdir /home/$NB_USER/data && \ # data for data stored on DS servers
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

USER root

# Configure container startup as root
EXPOSE 8888
WORKDIR /home/$NB_USER/work
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start-notebook.sh /usr/local/bin/
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

# Switch back to datalab to avoid accidental container runs as root
USER datalab
