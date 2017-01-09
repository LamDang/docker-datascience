#! /bin/bash
## Build tests
image_name="40_deeplearning:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
docker build -t ${image_name} $DIR

## Run tests
echo "Test cuda"
nvidia-docker run --rm ${image_name} nvidia-smi
echo "Test theano"
nvidia-docker run --rm ${image_name} python -c "import theano"
echo "Test keras"
nvidia-docker run --rm ${image_name} python -c "import keras"
echo "Test tensorflow"
nvidia-docker run --rm ${image_name} python -c "import tensorflow"

## Clean up
docker rmi ${image_name}
