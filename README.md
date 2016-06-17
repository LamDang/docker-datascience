# Docker stack for data science tools

This docker stack is organized in "steps" each step add some new environment to the tool. 
Each step should be independent and provide a runnable image.
* 00_jupyter_setup: Configure user name and home directory. Have Python 3 and Jupyter Notebook
* 10_anaconda: Add Anaconda and some ML packages (xgboost, hyperopt, ..) 
* 20_spark: Add Spark 
* 30_add_envs: Add Python 2 envs with Anaconda and add kernel to Jupyter
* 40_deeplearning_cpu: Add Theano, Keras and Tensorflow with CPU configuration
* 41_deeplearning_gpu: Add CUDA and CuDNN installation. To be run with nvidia-docker

## User guide
### Launch a permanent Jupyter Notebook server 
sudo docker run [Docker Options] [Image Name] start-notebook.sh [Notebook Options]

### Docker Options:

#### Recommended Options:
* **-d --restart=unless-stopped** - Run in detached mode and always restart container except manually stopped
* **-p <host_port>:<contaier_port>** - Map container port to specific host port
* **-e PASSWORD=<your_passwd> -e USE_HTTPS=yes** - Set password. It is recommended to always use HTTPS when password is set.
* **-e NB_UID=<your_uid> --user root** - Set notebook user UID. This is important to control the permissions of files mounted from host or future files created by the container
* **-v <host_absolute_path>:<container_absolute_path>** - Mount a host folder to container. It is recommended to use absolute path to avoid confusion

#### Spark Options:
* **--net host** - When run Spark on YARN, Spark will communicate with YARN cluster with the IP of the container. One can either setup bridge network to make container visible to YARN cluster or let it use host network interface
* Spark installation in this docker does not contain configuration to work with HADOOP cluster. One can mount the necessary *conf* folder to /usr/local/spark/conf to setup Spark configuration with HADOOP

#### Run Jupyter with GPU & CUDA deep learning:
**Prerequisites:**
* Have CUDA capable GPU installed with driver
* Install CUDA toolkit
* Install nvidia-docker and nvidia-docker-plugin: https://github.com/NVIDIA/nvidia-docker/wiki/Installation

**How:** Run container usual by replacing _sudo docker_ with _sudo nvidia-docker_


