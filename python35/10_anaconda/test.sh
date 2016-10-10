#! /bin/bash
## Build tests
image_name="10_anaconda_py35:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
sudo docker build -t ${image_name} $DIR

## Run tests
echo "Test anaconda version py3"
sudo docker run --rm ${image_name} conda list anaconda$
#echo "Test jupyter"
#sudo docker rm test
#sudo docker run -d --name test 00_jupyter_setup:test start-noteobok.sh
#sudo docker stop test && sudo docker rm test

## Clean up
sudo docker rmi ${image_name}
