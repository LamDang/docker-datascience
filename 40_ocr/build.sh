DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="40_ocr"

docker build -t ${IMAGE_NAME} $DIR
