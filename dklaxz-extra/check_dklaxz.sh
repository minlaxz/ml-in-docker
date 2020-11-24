DK_PREFIX=$1
DKTMP_PREFIX=$2
DK_REPO=$3

cd $DK_PREFIX
DKHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')

rm -rf $DKTMP_PREFIX
git clone --quiet $DK_REPO $DKTMP_PREFIX && cd $_

rm -rf .git Dockerfile.* LICENSE README.md deprecated examples-ipynb.txt laxz.bashrc .gitignore
DKTMPHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')

if [[ "$DKHASH" == "$DKTMPHASH" ]]; then
    echo -e "\e[1;37m"
    cat <<EOF
dklaxz up-to-date."
EOF
    echo -e "\e[m"

else
    echo -e "\e[1;36m"
    echo "removing old files."
    rm -rf $DK_PREFIX /usr/bin/dklaxz
    mv $DKTMP_PREFIX/ $DK_PREFIX/
    ln -s $DK_PREFIX/dklaxz.sh /usr/bin/dklaxz
    echo "update done."
fi
echo -e "\e[m"

echo -e "\e[2;32m"
cat <<EOF
"current hash : $DKHASH"
"lastest hash : $DKTMPHASH"
EOF
echo -e "\e[m"