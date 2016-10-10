#! /bin/bash
## Build tests
image_name="20_spark_py35:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
sudo docker build -t ${image_name} $DIR

## Run tests
echo "Test spark version"
sudo docker run --rm ${image_name} /usr/local/spark/bin/spark-submit --version
#echo "Test pyspark python3"
#sudo docker run --rm ${image_name} /usr/local/spark/bin/pyspark 
#echo "Test jupyter"
#sudo docker rm test
#sudo docker run -d --name test 00_jupyter_setup:test start-noteobok.sh
#sudo docker stop test && sudo docker rm test

## Clean up
sudo docker rmi ${image_name}
