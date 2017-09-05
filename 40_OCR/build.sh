DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="40_OCR"

docker build -t ${IMAGE_NAME} $DIR
