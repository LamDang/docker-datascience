DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="30_add_packages_py27"

sudo docker build -t lamdang/${IMAGE_NAME} $DIR 
