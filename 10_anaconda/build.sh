DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE_NAME="10_anaconda"

docker build -t ${IMAGE_NAME} $DIR
