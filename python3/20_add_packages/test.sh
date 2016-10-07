#! /bin/bash
## Build tests
image_name="20_add_packages:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
sudo docker build -t ${image_name} $DIR

## Run tests
echo "Test xgboost"
sudo docker run --rm ${image_name} python -c "import xgboost as xgb; print(type(xgb.XGBClassifier()))"
echo "Test hyperopt"
sudo docker run --rm ${image_name} python -c "from hyperopt import *"
echo "Test vw"
sudo docker run --rm ${image_name} python -c "from vowpalwabbit import *"
echo "Test gensim"
sudo docker run --rm ${image_name} python -c "from gensim import *"


#sudo docker rm test
#sudo docker run -d --name test 00_jupyter_setup:test start-noteobok.sh
#sudo docker stop test && sudo docker rm test

## Clean up
sudo docker rmi ${image_name}
