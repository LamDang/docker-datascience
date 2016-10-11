#! /bin/bash
## Build tests
image_name="40_deeplearning_py27:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
sudo docker build -t ${image_name} $DIR

## Run tests
echo "Test cuda"
sudo nvidia-docker run --rm ${image_name} nvidia-smi
echo "Test theano"
sudo nvidia-docker run --rm ${image_name} python -c "import theano"
echo "Test keras"
sudo nvidia-docker run --rm ${image_name} python -c "import keras"
echo "Test tensorflow"
sudo nvidia-docker run --rm ${image_name} python -c "import tensorflow"

## Clean up
sudo docker rmi ${image_name}
