OPENCV_VERSION=$1
cc=$2

echo -e "\e[1;37m"
echo "installing required dependencies ... compute capability: ${cc} "
echo -e "\e[m"

apt install -y libjpeg-dev libpng-dev libtiff-dev libavcodec-dev \
libavformat-dev libswscale-dev libavutil-dev libv4l-dev libxvidcore-dev libx264-dev \
libgtk-3-dev libatlas-base-dev gfortran libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
libfreetype6-dev libtesseract-dev

# libdc1394-22-dev
#  high level programming interface for IEEE 1394 digital cameras - development
# libharfbuzz-dev
#  Development files for OpenType text shaping engine

cd $HOME

echo -e "\e[1;37m"
if [[ ! -d ./opencv ]]; then
    echo "Downloading OpenCV archive ... "
    test ! -f ./opencv.zip && wget -O ./opencv.zip https://github.com/opencv/opencv/archive/master.zip || true
    echo "./opencv.zip extracting ... "
    unzip -q ./opencv.zip && mv ./opencv-master/ ./opencv/ && rm -f ./opencv.zip
fi

if [[ ! -d ./opencv_contrib ]]; then
    echo "Downloading OpenCV archive ... "
    test ! -f ./opencv_contrib.zip && wget -O ./opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip || true
    echo "./opencv_contrib.zip extracting ... "
    unzip -q ./opencv_contrib.zip && mv ./opencv_contrib-master/ ./opencv_contrib/ && rm -f ./opencv_contrib.zip
fi
echo -e "\e[m"

mkdir -p $HOME/opencv/build && cd $_

makeopencv() {
    th_=$(lscpu | grep "^CPU(" | awk '{print $2}')
cat<<EOF
    your total threads : $th_
    building in 5 sec ---
EOF
    sleep 5
    make -j${th_} && make install && ldconfig
}

cmakeopencv() {
th_=$(lscpu | grep "^CPU(" | awk '{print $2}')
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D CUDA_ARCH_BIN=${cc} \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D OPENCV_ENABLE_NONFREE=ON \
-D HAVE_opencv_python3=ON \
-D PYTHON_EXECUTABLE=$(which python) \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D BUILD_EXAMPLES=ON ..

# && read -p "Build opencv? [y/n]: " yn
# case $yn in
#     [yY]*) makeopencv ;;
#     *) echo "exiting." && exit ;; 

}


read -p "Configure opencv? [y/n]: " yn
case $yn in 
    [Yy]*) cmakeopencv ;;
    *) cat<<EOF
you can manually configure opencv,
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D CUDA_ARCH_BIN=${cc} #your GPU compute capability\
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D OPENCV_ENABLE_NONFREE=ON \
-D HAVE_opencv_python3=ON \
-D PYTHON_EXECUTABLE=$(which python) \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D BUILD_EXAMPLES=ON ..
EOF ;;
esac

echo "
TLDR;
make -j${th_} && make install && ldconfig

A Long Story.
I don't want to build software right now,
so that you can check what lib or libs are missing.
make sure your 
'make -j'
is lower than or equal to your cpu threads.
your pc total threads : $th_

type to clean up your docker AFTER INSTALLED opencv
'rm -rf $HOME/opencv $HOME/opencv_contrib /var/lib/apt/lists/* ~/.cache/pip'
make sure don't forget to commit your opencv installed container.
'docker commit CONTAINER_ID_OR_NAME REPO/IMAGE_NAME:TAG'
for example :
'docker commit -m "commit message" 000000000 minlaxz/ml-env:opencv_installed'
"

echo -e "\e[7;34m"
echo "Finished. dklaxz --help-cv for more on opencv"
echo -e "\e[m"