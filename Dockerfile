FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
LABEL maintainer="Min Latt <minminlaxz@gmail.com>"
WORKDIR /root/
RUN apt update && apt upgrade -y && apt install --no-install-recommends -y \
net-tools wget netcat build-essential vim locate pv tree && cd /root/ \
&& curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o conda.sh \
&& chmod a+x conda.sh && ./conda.sh && conda config --set auto_activate_base true && source .bashrc \
&& conda install python=3.6.9 numpy tensorflow-gpu numpy \
&& rm -rf /var/lib/apt/lists/* && conda clean -a \
&& curl 
CMD ["bash" "-c" "source /etc/laxz.bashrc \
&& jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --allow-root"]