#! /bin/bash
## Build tests
image_name="20_add_packages:test"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building test image"
docker build -t ${image_name} $DIR

## Run tests
echo "Test xgboost"
docker run --rm ${image_name} python -c "import xgboost as xgb; print(type(xgb.XGBClassifier()))"
echo "Test LightGBM"
docker run --rm ${image_name} python -c "import lightgbm as gbm; print(type(gbm.LGBMClassifier()))"
echo "Test hyperopt"
echo "Test hyperopt"
docker run --rm ${image_name} python -c "from hyperopt import *"
echo "Test gensim"
docker run --rm ${image_name} python -c "from gensim import *"
echo "Test datarobot"
docker run --rm ${image_name} python -c "from datarobot import *"
echo "Test mkl"
docker run --rm ${image_name} python -c "from sklearn.tests.test_kernel_ridge import test_kernel_ridge; test_kernel_ridge()"

## Clean up
docker rmi ${image_name}
