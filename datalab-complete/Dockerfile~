FROM lamdang/datalab:base

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

USER datalab

# Create packages folder to hold non Anaconda packages
RUN mkdir packages
ENV CUS_PKG_PATH /home/$NB_USER/packages

# Install xgboost
RUN cd $CUS_PKG_PATH && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && make -j4 && \
    cd python-package && python setup.py install

# Install hyperopt
RUN cd $CUS_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop

# Install plotly
RUN pip install plotly

USER root
# Install vowpal wabbit
RUN apt-get install -yq --no-install-recommends \
    libboost-program-options-dev \
    libboost-python-dev \
    autoconf \
    automake \ 
    libtool \
    zlib1g-dev

USER datalab
RUN cd $CUS_PKG_PATH && \
    git clone https://github.com/JohnLangford/vowpal_wabbit.git

USER root
RUN cd $CUS_PKG_PATH/vowpal_wabbit && make && make install
