#! /bin/bash
image_name="00_setup:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## Build tests
echo "Building test image"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t ${image_name} $DIR

## Run tests
echo "Test home folder"
docker run --rm ${image_name} ls -al /home/ipython

## Clean up
docker rmi ${image_name}
