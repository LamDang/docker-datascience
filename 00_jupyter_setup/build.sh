DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="00_jupyter_setup"

sudo docker build -t lamdang/${IMAGE_NAME} $DIR
