## Docker for data science tools

This docker stack is organized in "steps" each step add some new environment to the tool. 
Each step should be independent and provide a runnable image.
* 00_jupyter_setup: Configure user name and home directory. Have Python 3 and Jupyter Notebook
* 10_anaconda: Add Anaconda and some ML packages (xgboost, hyperopt, ..) 
* 20_spark: Add Spark 
* 30_add_envs: Add Python 2 envs with Anaconda and add kernel to Jupyter
* 40_deeplearning_cpu: Add Theano, Keras and Tensorflow with CPU configuration
* 41_deeplearning_gpu: Add CUDA and CuDNN installation. To be run with nvidia-docker

### User guide
#### Launch a permanent Jupyter Notebook server 
sudo docker run [Docker Options] [Image Name] start-notebook.sh [Notebook Options]

##### Docker Options:
* **-d --restart=unless-stopped ** 
#### 
