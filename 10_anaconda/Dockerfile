FROM 00_setup:latest

MAINTAINER Lam Dang

USER root
# Setup env
ENV ANACONDA_VERSION 4.3.1
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN mkdir -p -m 777 ${CONDA_DIR}
RUN apt-get update --fix-missing && apt-get install -y \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools htop screen

# Install Anaconda python 3
USER $NB_USER
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    /bin/bash Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy

USER $NB_USER
RUN conda update -yq conda
RUN conda install -c defaults -y anaconda==${ANACONDA_VERSION} && \
    conda clean -tipsy

# Setup Jupyter
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
COPY jupyter_custom.js /tmp/

USER root
RUN cat /tmp/jupyter_custom.js >> $CONDA_DIR/lib/python3.5/site-packages/notebook/static/custom/custom.js && \
    rm /tmp/jupyter_custom.js

USER $NB_USER
RUN python -m ipykernel install --prefix=$CONDA_DIR --display-name "Python 3"
# Jupyter Lab
RUN conda install -yq -c conda-forge jupyterlab jupyter_contrib_nbextensions
RUN jupyter nbextension enable execute_time/ExecuteTime && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable toc2/main

# PATCH jupyter crash with keras progress bar
RUN conda install -yq notebook=4.2.3
RUN pip install keras_tqdm


COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
CMD ["start-notebook.sh"]
