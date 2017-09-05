#! /bin/bash
## Build tests
image_name="40_OCR:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"


## Clean up
docker rmi ${image_name}
