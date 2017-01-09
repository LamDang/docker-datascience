DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="00_jupyter_setup"

docker build -t ${IMAGE_NAME} $DIR
