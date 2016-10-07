FROM lamdang/10_anaconda:latest

MAINTAINER Lam Dang

ENV APACHE_SPARK_VERSION 1.6.2

#Install jq to deal with json kernel
USER root 

RUN apt-get -yqq update && \
    apt-get -yqq install jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark dependencies
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-7-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download Spark
RUN cd /tmp && \
    #wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
    wget -q http://www.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
    echo "604936F2BD8AF999D0D624B370F5C4B1 *spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz" | md5sum -c -

# Extract Spark
RUN cd /tmp && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark

# Spark config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip
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

# Python 2 kernel
RUN jq --arg v "$CONDA_DIR/envs/python2/bin/python" \
        '.["env"]["PYSPARK_PYTHON"]=$v' \
        $CONDA_DIR/share/jupyter/kernels/python2/kernel.json > /tmp/kernel.json && \
        mv /tmp/kernel.json $CONDA_DIR/share/jupyter/kernels/python2/kernel.json

USER $NB_USER
