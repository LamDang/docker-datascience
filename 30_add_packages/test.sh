#! /bin/bash
## Build tests
image_name="30_add_packages:test"
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
echo "Test datarobot"
sudo docker run --rm ${image_name} python -c "from datarobot import *"


## Clean up
sudo docker rmi ${image_name}
