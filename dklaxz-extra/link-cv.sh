PYTHON=$(which python3)

GLOBAL_CV2=$($PYTHON -c 'import cv2; print(cv2)' | awk '{print $4}' | sed s:"['>]":"":g)
cat << EOF
hard copy this, no no symlink
EOF
echo $GLOBAL_CV2 

cat << EOF
example:
    from:
    /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so
    to:
    /root/env/lib/python3.6/site-packages/cv2.so

For Error:
    numpy.core.multiarray failed to import

    pip install numpy #( in your env )
EOF
