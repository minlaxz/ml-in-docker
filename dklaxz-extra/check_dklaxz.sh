DK_PREFIX=$1
DKTMP_PREFIX=$2
DK_REPO=$3

cd $DK_PREFIX
# DKHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')
DKHASH=$(find . -maxdepth 2 -name "*.sh" -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')

rm -rf $DKTMP_PREFIX
git clone --quiet $DK_REPO $DKTMP_PREFIX && cd $_

# rm -rf .git Dockerfile.* LICENSE README.md deprecated examples-ipynb.txt laxz.bashrc .gitignore
# DKTMPHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')
DKTMPHASH=$(find . -maxdepth 2 -name "*.sh" -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')

echo -e "\e[2;32m"
echo "current hash : $DKHASH"
echo "lastest hash : $DKTMPHASH"
echo -e "\e[m"

if [[ "$DKHASH" == "$DKTMPHASH" ]]; then
    echo -e "\e[1;37m"
    echo "dklaxz : no update! "
    echo -e "\e[m"

else
    echo -e "\e[1;36m"
    echo "dklaxz : updating."
    rm -rf $DK_PREFIX /usr/bin/dklaxz
    mv $DKTMP_PREFIX/ $DK_PREFIX/
    ln -s $DK_PREFIX/dklaxz.sh /usr/bin/dklaxz && chmod 755 /usr/bin/dklaxz
    echo "done."
fi
echo -e "\e[m"
