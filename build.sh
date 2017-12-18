 apt-get update && apt-get install -yq \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    git \
    htop \
    screen \
    unzip \
    pigz \
    nano \
    vim \
    openjdk-8-jdk-headless \
    openssh-server \
	cron
 apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Tini
 wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Environment Setup
 echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


 mkdir -p -m 777 ${CONDA_DIR}
 apt-get update --fix-missing && apt-get install -y \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    python-setuptools htop screen

# Install Miniconda python 3

 cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy

# Install Anaconda
 conda update -yq conda
 conda install -c defaults -y anaconda==${ANACONDA_VERSION} && \
    conda install ipython=5.3.0 -y && \
    conda clean -tipsy
 python -m ipykernel install --prefix=$CONDA_DIR --display-name "Python 3"



# Jupyter add-on
 conda install -yq notebook

 conda install -yq -c conda-forge \
    jupyter_contrib_nbextensions \
    tqdm
 jupyter nbextension enable execute_time/ExecuteTime && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable toc2/main

# Config Jupyter

COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
# Add script to resume notebook output
COPY jupyter_custom.js /tmp/
 cat /tmp/jupyter_custom.js >> \
    $CONDA_DIR/lib/python3.6/site-packages/notebook/static/custom/custom.js && \
    rm /tmp/jupyter_custom.js
# Add permission on executables
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
 chmod +x /usr/local/bin/start.sh
 chmod +x /usr/local/bin/start-notebook.sh
CMD ["start-notebook.sh"]

# Add conda to path
 echo 'export PATH='${CONDA_DIR}'/bin:$PATH' >> /home/$NB_USER/.bashrc
 chown -R $NB_USER:$NB_USER /home/$NB_USER/.conda



 mkdir -m 777 ${ADD_PKG_PATH}
 apt-get update -y && apt-get install -yq cmake g++ libgomp1 && apt-get clean

# Install additional packages
# USER $NB_USER
## ML packages
 conda install -c conda-forge \
    xgboost \
    lightgbm

### hyperopt
 cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

### datarobot api
 pip install datarobot

## NLP
 conda install -y gensim libgcc && \
    conda install -c conda-forge spacy

### fastText
 cd $ADD_PKG_PATH && \
    git clone https://github.com/facebookresearch/fastText.git && \
    cd fastText && make -j4
 pip install fastText

## Image
 conda install -y opencv

## Distributed Computing
 conda install -y dask distributed fastparquet && \
    conda install -y -c conda-forge pyarrow python-snappy

## Viz: wordcloud, graphviz, pydot
 conda install -y \
    graphviz python-graphviz pydotplus \
    seaborn pandas-profiling
 conda install -y -c amueller wordcloud
### bokeh set
 conda install -y bokeh holoviews datashader
### plotly set
 pip install \
    dash==0.17.7 \
    dash-renderer==0.7.4 \
    dash-html-components==0.7.0 \
    dash-core-components==0.12.4 \
    plotly==2.0.15
### brunel
 pip install brunel

### Some specialized pkgs
 conda install -c conda-forge lifelines nlopt -y && \
    conda install -c glemaitre imbalanced-learn -y
 conda install -y -c conda-forge \
    jellyfish \
    python-Levenshtein \
    python-igraph \
    fuzzywuzzy

 pip install bottle line_profiler
 conda install -c anaconda coverage pylint cloudpickle=0.2.2
 pip install pg8000 

conda clean -tipsy
 NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list

# Install cuda
 apt-get update && apt-get install -y --no-install-recommends \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-nvgraph-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-$CUDA_PKG_VERSION \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-8.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

 echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

 echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf


 conda install -c anaconda cudatoolkit -y
# Install CuDNN

 echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

 apt-get update && apt-get install -y --no-install-recommends \
    libcudnn$CUDNN_VERSION libcudnn$CUDNN_VERSION-dev && \
    rm -rf /var/lib/apt/lists/*

###################
### END OF COPY ###
###################


# conda install -y tensorflow-gpu keras-gpu && \
#    conda clean -tipsy
 pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.0-cp36-cp36m-linux_x86_64.whl
 pip install --upgrade keras


