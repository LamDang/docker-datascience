FROM ubuntu:xenial

MAINTAINER Lam Dang

USER root
# OS dependencies
RUN apt-get update && apt-get install -yq \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    git \
    htop \
    screen \
    unzip \
    pigz
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Environment Setup
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV SHELL /bin/bash
ENV NB_USER ipython
ENV NB_UID 1001
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Add user
RUN useradd -m -s /bin/bash -u $NB_UID -U $NB_USER

USER $NB_USER
# Setup datascience home directory
RUN mkdir /home/$NB_USER/datalab && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

# Configure container startup as root
USER root

EXPOSE 8888
WORKDIR /home/$NB_USER/datalab/
ENTRYPOINT ["tini", "--"]
