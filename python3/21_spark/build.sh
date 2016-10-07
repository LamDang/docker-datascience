DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="21_spark"

sudo docker build -t lamdang/${IMAGE_NAME} $DIR
