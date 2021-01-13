#!/bin/bash
version='1.3.0' # -- [main OFF/major ON/minor ON]
OPENCV_VERSION='4.5.1'

DK_PREFIX=/usr/local/dklaxz
DK_EXT_PREFIX=$DK_PREFIX/dklaxz-extra
DKTMP_PREFIX=/tmp/dklaxz
DK_REPO=https://github.com/minlaxz/ml-in-docker.git

if [ $# -eq 0 ]; then
echo -e "\e[1;31m"
    printf "[not an option] dklaxz --help    for usage.\n"
echo -e "\e[m"
else
    stVar=$1 #major
    ndVar=$2 #minor

    # make sure update with dklaxz-extra/help
    case "$stVar" in
        --help) bash $DK_EXT_PREFIX/help.sh ;;
        --map) bash $DK_EXT_PREFIX/map.sh ;;

        --build-cv) if [[ $ndVar == "" ]]; then
            echo "This need GPU(s)'(!s) compute capability number. eg:7.6"
            echo "more info > https://developer.nvidia.com/cuda-gpus"
            else bash $DK_EXT_PREFIX/build_opencv.sh $OPENCV_VERSION $ndVar
            fi
            ;;
        --help-cv) bash $DK_EXT_PREFIX/howto_opencv.sh ;;
        --link-cv) bash $DK_EXT_PREFIX/link-cv.sh ;;

        # --build-tf) if [[ ]]

        --version) printf "version : ${version} Main/Build/Minor\n" ;;
        --update) bash $DK_EXT_PREFIX/check_dklaxz.sh $DK_PREFIX $DKTMP_PREFIX $DK_REPO ;;
        --update-rc) bash $DK_EXT_PREFIX/check_rc.sh ;; # for some weird cases
        *) printf "[not an option $stVar] dklaxz --help for usage.\n" ;;
    esac
fi