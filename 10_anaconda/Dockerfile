FROM 00_setup:latest

MAINTAINER Lam Dang

USER root
# Setup env
ENV ANACONDA_VERSION 5.0.1
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN mkdir -p -m 777 ${CONDA_DIR}
RUN apt-get update --fix-missing && apt-get install -y \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools

# Install Miniconda python 3
USER root
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy

# Install Anaconda
RUN conda update -yq conda
RUN conda install -c defaults -y anaconda==${ANACONDA_VERSION} && \
    conda clean -tipsy
RUN python -m ipykernel install --prefix=$CONDA_DIR --display-name "Python 3"

# Jupyter add-on
RUN conda install -yq notebook
RUN conda install -yq -c conda-forge \
    jupyterlab \
    jupyter_contrib_nbextensions \
    tqdm
RUN jupyter nbextension enable execute_time/ExecuteTime && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable toc2/main

# Config Jupyter
USER root
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN printf "\nc.NotebookApp.token = u'' \n\n" >> /home/${NB_USER}/.jupyter/jupyter_notebook_config.py && \
    mkdir -p $HOME/.ipython/profile_default/ && \
    ln -s $HOME/.jupyter/jupyter_notebook_config.py $HOME/.ipython/profile_default/ipython_notebook_config.py

# Add Domino's dependencies
RUN apt-get update && apt-get install -yq gcc
RUN pip install \
    flask==0.12 \
    jsonify==0.5 \
    uwsgi==2.0.14 \
    cairocffi     # required for Python 3

# Add script to resume notebook output
COPY jupyter_custom.js /tmp/
RUN cat /tmp/jupyter_custom.js >> \
    $CONDA_DIR/lib/python3.6/site-packages/notebook/static/custom/custom.js && \
    rm /tmp/jupyter_custom.js
# Add permission on executables
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start-notebook.sh
CMD ["start-notebook.sh"]

# Add conda to path
RUN echo 'export PATH='${CONDA_DIR}'/bin:$PATH' >> /home/$NB_USER/.bashrc
RUN chown -R $NB_USER:$NB_USER /home/$NB_USER/.conda
USER $NB_USER
