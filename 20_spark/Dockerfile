FROM 10_anaconda:latest

MAINTAINER Lam Dang

ENV SPARK_VERSION 2.1.0
ENV SPARK_URL http://www.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz
ENV SPARK_MD5HASH 186765A95838602ED81EA4E9270561F8

#Install jq to deal with json kernel
USER root 
RUN apt-get -yqq update && \
    apt-get -yqq install jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark dependencies
#RUN apt-get -y update && \
#    apt-get install -y --no-install-recommends openjdk-8-jre-headless && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

# Temporarily add jessie backports to get openjdk 8, but then remove that source
RUN echo 'deb http://cdn-fastly.deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-8-jre-headless && \
    rm /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download Spark
RUN cd /tmp && \
    wget ${SPARK_URL} && \
    echo "${SPARK_MD5HASH} *spark-${SPARK_VERSION}-bin-hadoop2.6.tgz" | md5sum -c -

# Extract Spark
RUN cd /tmp && \
    tar xzf spark-${SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
    rm spark-${SPARK_VERSION}-bin-hadoop2.6.tgz
RUN cd /usr/local && ln -s spark-${SPARK_VERSION}-bin-hadoop2.6 spark

# Spark config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

# Create folder to mount YARN config files
RUN mkdir /usr/local/spark/conf/yarn_conf
ENV YARN_CONF_DIR /usr/local/spark/conf/yarn_conf

# Configure kernels for pyspark
USER $NB_UID
RUN jq --arg v "$CONDA_DIR/bin/python" \
        '.["env"]["PYSPARK_PYTHON"]=$v' \
        $CONDA_DIR/share/jupyter/kernels/python3/kernel.json > /tmp/kernel.json && \
        mv /tmp/kernel.json $CONDA_DIR/share/jupyter/kernels/python3/kernel.json

USER $NB_USER
