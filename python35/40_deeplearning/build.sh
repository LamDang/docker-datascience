DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="40_deeplearning_py35"

sudo docker build -t lamdang/${IMAGE_NAME} $DIR 
