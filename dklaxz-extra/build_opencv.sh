OPENCV_VERSION=$1
cc=$2

echo -e "\e[1;37m"
echo "installing required dependencies ... ${cc} "
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
    if [[ ! -f ./opencv.zip ]]; then
        echo "Downloading OpenCV archive ... "
        wget -O ./opencv.zip https://github.com/opencv/opencv/archive/master.zip
    fi
    echo "./opencv.zip - found. extracting ... "
    unzip -q ./opencv.zip && mv ./opencv-master/ ./opencv/ 
    echo "clean up."
    rm -f ./opencv.zip
else
    echo "./opencv dir - found > download skipping."
fi
echo -e "\e[m"

echo -e "\e[1;37m"
if [[ ! -d ./opencv ]]; then
    if [[ ! -f ./opencv.zip ]]; then
        echo "Downloading OpenCV archive ... "
        wget -O ./opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip
    fi
    echo "./opencv_contrib.zip - found. extracting ... "
    unzip -q ./opencv_contrib.zip && mv ./opencv_contrib-master/ ./opencv_contrib/ 
    echo "clean up."
    rm -f ./opencv_contrib.zip
else
    echo "./opencv_contrib dir - found > download skipping."
fi
echo -e "\e[m"

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

mkdir -p $HOME/opencv/build && cd $_

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
-D BUILD_EXAMPLES=ON .. \
&& read -p "Build opencv? [y/n]: " yn
case $yn in
    [yY]*) makeopencv ;;
    *) echo "exiting." && exit ;; 
}


read -p "Configure opencv? [y/n]: " yn
case $yn in 
    [Yy]*) cmakeopencv ;;
    *) echo "exiting." && exit ;;
esac


echo -e "\e[7;34m"
echo "Finished."
echo -e "\e[m"
    
echo -e "\e[7;34m"
echo "Cleaning"
echo -e "\e[m"
rm -rf $HOME/opencv $HOME/opencv_contrib /var/lib/apt/lists/* ~/.cache/pip
echo -e "\e[7;34m"
echo "Finished. dklaxz --help-cv for more on cv."
echo -e "\e[m"