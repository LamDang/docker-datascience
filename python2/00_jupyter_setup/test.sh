#! /bin/bash
## Build tests
echo "Building test image"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo docker build -t 00_jupyter_setup:test $DIR

## Run tests
echo "Test home folder"
sudo docker run --rm 00_jupyter_setup:test ls -al /home/ipython
echo "Test conda"
sudo docker run --rm 00_jupyter_setup:test conda --version
echo "Test jupyter"
sudo docker rm test || true
sudo docker run -d --name test 00_jupyter_setup:test start-noteobok.sh
sudo docker stop test && sudo docker rm test

## Clean up
sudo docker rmi 00_jupyter_setup:test
