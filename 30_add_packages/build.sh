DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="30_add_packages"

docker build -t ${IMAGE_NAME} $DIR 
