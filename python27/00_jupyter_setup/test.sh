#! /bin/bash
image_name="00_jupyter_setup_py27:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## Build tests
echo "Building test image"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo docker build -t ${image_name} $DIR

## Run tests
echo "Test home folder"
sudo docker run --rm ${image_name} ls -al /home/ipython
echo "Test conda"
sudo docker run --rm ${image_name} conda --version
echo "Test jupyter"
sudo docker run -d --name test ${image_name}  start-noteobok.sh
sudo docker stop test && sudo docker rm test

## Clean up
sudo docker rmi ${image_name}
