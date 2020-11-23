echo -e "\e[1;37m"
cat<<EOF
    Docker and OpenCV Usage.
    ------------------------
    docker run --rm --interactive --tty --gpus all --device /dev/video0:/dev/video0 \
    --volume $HOME:$HOME --publish 8888:8888 IMAGE /bin/bash #FOR INTERACTIVE ADN REMOVE ON EXIT


    docker run --name NAME --detach --tty --gpus all --device /dev/video0:/dev/video0 \
    --volume $HOME:$HOME --publish 8888:8888 IMAGE
    docker exec --interactive --tty NAME /bin/bash

    docker run --detach --tty --gpus all --device /dev/video0:/dev/video0 \
    --volume $HOME:$HOME --publish 8888:8888 IMAGE

    more info (xhost) - https://github.com/minlaxz/ml-in-docker/blob/master/README.md
EOF
echo -e "\e[m"