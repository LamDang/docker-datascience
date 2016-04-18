FROM jupyter/minimal-notebook:latest

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

# Change user base
USER root 

ENV NB_USER datalab
RUN deluser --remove-home jovyan

# Create datalab user with UID=1000 and in the 'users' group
RUN useradd -m -d /home/datalab -s /bin/bash -N -u 1000 datalab
RUN chown -R datalab:users /opt/conda && chown -R datalab:users /home/datalab

USER datalab

# Setup datalab home directory

RUN mkdir /home/datalab/work && \ 
    mkdir /home/datalab/data && \ 
    mkdir /home/datalab/.jupyter && \
    mkdir /home/datalab/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/datalab/.curlrc

USER root

# Configure container startup as root
EXPOSE 8888
WORKDIR /home/$NB_USER
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start-notebook.sh /usr/local/bin/
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

# Switch back to datalab to avoid accidental container runs as root
USER datalab


