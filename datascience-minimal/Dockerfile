FROM jupyter/minimal-notebook:latest

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

# Change user base
USER root 

ENV NB_USER ds_user
RUN deluser --remove-home jovyan

# Create ds_user with UID=1000 and in the 'users' group
RUN useradd -m -d /home/$NB_USER -s /bin/bash -N -u 1000 $NB_USER
RUN chown -R $NB_USER:users /opt/conda && chown -R $NB_USER:users /home/$NB_USER

USER $NB_USER

# Setup datascience home directory

RUN mkdir /home/$NB_USER/work && \ 
    mkdir /home/$NB_USER/data && \ 
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

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

# Switch back to $NB_USER to avoid accidental container runs as root
USER $NB_USER


