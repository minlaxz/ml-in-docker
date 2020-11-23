echo -e "\e[1;31m"
cat<<EOF
 ----------------------------------------------------------------------
|
|from nvidia/cuda:11.0-cudnn8-base-ubuntu18.04
|           |
|           |
|        minlaxz/ml-env-devel:11.0-v8.0.5-rt7.2.1
|             |  |     |    |
|             |  |     |    |____ export jupyter-notebook @ 8888  <<< |
|             |  |     |                                              |
|             |  |     |____ tensorrt, build tf-gpu                   |
|             |  |               |                                    |
|             |  |               |____ pycuda                         |
|             |  |                                                    |
|             |  |____ ready cuda, cudnn from nvidia                  |
|    __ lxz __|                                                       |
|   |         |                                                       |
|   |         |____ python3, python3-dev, python3-pip, numpy          |
|   |                                                                 |
|   |__build__ opencv build 4.5.0,                                    |
|   |__ help__ helpful usage message.                                 |
|                                                                     |
|    https://gist.github.com/minlaxz/1a99b4277aee3b82a152f036322d7db8 |
|
 --------------cuda11.0:cudnn8.0.5.39:tensorrt7.2.1.6:ubuntu18.04 -----
EOF
echo -e "\e[m"