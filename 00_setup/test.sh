#! /bin/bash
image_name="00_jupyter_setup:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## Build tests
echo "Building test image"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t ${image_name} $DIR

## Run tests
echo "Test home folder"
docker run --rm ${image_name} ls -al /home/ipython
echo "Test conda"
docker run --rm ${image_name} conda --version
echo "Test jupyter"
docker run -d --name test ${image_name}  start-notebook.sh
docker stop test && docker rm test

## Clean up
docker rmi ${image_name}
