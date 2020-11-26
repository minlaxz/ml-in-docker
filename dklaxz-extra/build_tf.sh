test ! -f $HOME/tensorflow.zip &&
    wget -O $HOME/tensorflow.zip https://github.com/tensorflow/tensorflow/archive/master.zip || true
unzip -q $HOME/tensorflow.zip &&
    mv $HOME/tensorflow-master $HOME/tensorflow &&
    cd $_ &&
    echo -e "\e[7;33m"
echo "Configuring tensorflow will take decade! "
echo -e "\e[m"
read -p "Continue ? [y/N]" yn
case $yn in
[yY]*)
    bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package &&
        ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg &&
        python3 -m pip install /tmp/tensorflow_pkg/*.whl
    ;;
*) echo "wise choice! " ;;
esac
