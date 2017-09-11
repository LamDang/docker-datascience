#! /bin/bash
## Build tests
image_name="40_ocr:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
docker build -t ${image_name} $DIR

echo "Test tesseract"
docker run --rm ${image_name} tesseract \
    /usr/local/additional_packages/tesseract/testing/eurotext.tif \
    stdout

## Clean up
docker rmi ${image_name}
