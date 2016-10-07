FROM lamdang/10_anaconda:latest

MAINTAINER Lam Dang

# Setup folder for non-Anaconda packages
USER root

RUN mkdir /usr/local/additional_packages && \
    chown -R $NB_UID /usr/local/additional_packages
ENV ADD_PKG_PATH /usr/local/additional_packages

# Install additional packages
USER $NB_UID

### xgboost
RUN cd $ADD_PKG_PATH && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && make -s -j4 && \
    cd python-package && \
    python setup.py install && \
    bash -c '. activate python2 && \
	python setup.py install && \
	. deactivate'

### hyperopt
RUN cd $ADD_PKG_PATH && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    cd hyperopt && python setup.py develop && \
    bash -c '. activate python2 && \
	python setup.py develop && \
	. deactivate'

### vowpal wabbit
USER root
RUN apt-get install -y libboost-program-options-dev zlib1g-dev libboost-python-dev
RUN cd $ADD_PKG_PATH && \
    git clone git://github.com/JohnLangford/vowpal_wabbit.git && \
    chmod a+rwx vowpal_wabbit && \
    cd vowpal_wabbit make -s -j4 && make -s install

USER $NB_UID
RUN cd $ADD_PKG_PATH/vowpal_wabbit/python && \
    pip install vowpalwabbit && \
    bash -c '. activate python2 && \
	pip install vowpalwabbit && \
	. deactivate'

### gensim
RUN conda install -y gensim && \
    bash -c '. activate python2 && \
	conda install -y gensim && \
	. deactivate'

USER $NB_USER

