```
docker pull nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

docker run --rm -it --gpus all --device /dev/video0:/dev/video0 -v $HOME:/tf -v /tmp/.X11-unix:/tmp/.X11-unix --ipc=host -e DISPLAY=$DISPLAY -p 8888:8888 nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04 bash

CUDA=11.0
CUDNN_MAJOR_VERSION=8
CUDNN=8.0.4.30-1
LIB_DIR_PREFIX=x86_64
LIBNVINFER=7.1.3-1
LIBNVINFER_MAJOR_VERSION=7

apt-get update && apt-get install -y --no-install-recommends \
        build-essential gcc g++ nano cmake make unzip zip pkg-config \
        libcurl4-openssl-dev libfreetype6-dev libhdf5-serial-dev \
        libzmq3-dev netcat software-properties-common \
        zlib1g-dev wget git curl

apt-get install -y --no-install-recommends libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-dev=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin-dev=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA}
# Need to get 189 MB of archives.


LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs:/usr/include/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

TF_NEED_CUDA 1
TF_NEED_TENSORRT 1
TF_CUDA_VERSION=${CUDA}
TF_CUDNN_VERSION=${CUDNN_MAJOR_VERSION}

### causing ERROR ###
<!-- ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig -->
######

apt-get update && apt-get install -y \
    python3 python3-pip openjdk-8-jdk python3-dev \
    virtualenv swig

python3 -m pip --no-cache-dir install --upgrade \
    pip setuptools

ln -s $(which python3) /usr/local/bin/python


python3 -m pip --no-cache-dir install \
    Pillow h5py keras_preprocessing matplotlib \
    mock 'numpy<1.19.0' scipy sklearn pandas \
    future portpicker enum34 matplotlib logxs jupyterthemes

BAZEL_VERSION=3.1.0
mkdir /bazel && \
    wget -O /bazel/installer.sh "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh" && \
    wget -O /bazel/LICENSE.txt "https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE" && \
    chmod +x /bazel/installer.sh && \
    /bazel/installer.sh && \
    rm -f /bazel/installer.sh

git clone https://github.com/minlaxz/ml-in-docker.git && cd ml-in-docker && \
cp laxz.bashrc /etc/bash.bashrc && \
chmod a+rwx /etc/bash.bashrc && \
cd .. && rm -rf ml-in-docker/

python3 -m pip install --no-cache-dir jupyter_http_over_ws ipykernel==5.1.1 nbformat==5.0
jupyter serverextension enable --py jupyter_http_over_ws

mkdir -p /tf/tensorflow-tutorials && chmod -R a+rwx /tf/
mkdir /.local && chmod a+rwx /.local
./examples-ipynb.txt /tf

wget -qi ../examples-ipynb.txt && apt-get autoremove -y

python3 -m ipykernel.kernelspec

jt -t onedork -kl -f roboto -fs 10 -tf merriserif -tfs 115 -nf ptsans -nfs 10 -cellw 80% -cursw 2
```


driver failed

mv /usr/local/cuda/lib64/stubs/libnvidia-ml.so /usr/local/cuda/lib64/stubs/libnvidia-ml.so.bak