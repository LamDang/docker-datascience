DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="20_spark"

docker build -t ${IMAGE_NAME} $DIR
