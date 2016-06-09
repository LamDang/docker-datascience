FROM lamdang/20_spark:latest

MAINTAINER Lam Dang

# Create Python 2 environment
USER $NB_USER
RUN conda create --yes -n python2 python=2.7
RUN bash -c '. activate python2 && \
    conda install -c defaults anaconda==${ANACONDA_VERSION} && \
    . deactivate'

RUN bash -c '. activate python2 && \
    cd $ADD_PKG_PATH/xgboost/python-package && python setup.py install && \
    cd $ADD_PKG_PATH/hyperopt && python setup.py develop && \
    pip install plotly && \
    . deactivate'

USER root
RUN bash -c '. activate python2 && \
    python -m ipykernel install --prefix=$CONDA_DIR && \
    . deactivate'
RUN jq --arg v "$CONDA_DIR/envs/python2/bin/python" \
        '.["env"]["PYSPARK_PYTHON"]=$v' \
        $CONDA_DIR/share/jupyter/kernels/python2/kernel.json > /tmp/kernel.json && \
        mv /tmp/kernel.json $CONDA_DIR/share/jupyter/kernels/python2/kernel.json

USER $NB_USER

