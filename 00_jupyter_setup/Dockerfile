FROM jupyter/minimal-notebook:latest

MAINTAINER Lam Dang

# Create ipython user with UID=1001 
USER root 

ENV NB_UID 1001
ENV NB_USER ipython
ENV HOME /home/$NB_USER

RUN useradd -m -s /bin/bash -u $NB_UID -U $NB_USER
RUN chown -R $NB_USER:$NB_USER /opt/conda

# Setup datascience home directory
USER $NB_USER

RUN mkdir /home/$NB_USER/datalab && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

# Configure container startup as root
USER root

EXPOSE 8888
WORKDIR /home/$NB_USER
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

RUN cp /home/jovyan/.jupyter/jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

RUN deluser --remove-home jovyan && \
    rm -rf /home/jovyan 

# Switch back to $NB_USER to avoid accidental container runs as root
USER $NB_USER
