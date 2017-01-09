#! /bin/bash
## Build tests
image_name="10_anaconda:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
docker build -t ${image_name} $DIR

## Run tests
echo "Test anaconda version py3"
docker run --rm ${image_name} conda list anaconda$

## Clean up
docker rmi ${image_name}
