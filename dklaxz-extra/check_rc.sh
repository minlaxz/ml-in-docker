curl -fsSL https://raw.githubusercontent.com/minlaxz/scripts/master/laxz.bashrc -o /bash.bashrc
RCHASH=$(sha256sum /etc/bash.bashrc | cut -c 1-60)
RCTMPHASH=$(sha256sum /bash.bashrc | cut -c 1-60)
if [[ "$RCHASH"=="$RCTMPHASH" ]]; then
echo "bashrc update-to-date."
rm /bash.bashrc
else

echo "some weird things happened ?"

mv /bash.bashrc /etc/bash.bashrc
chmod a+rwx /etc/bash.bashrc
echo "bashrc is updated. (dont forget to commit container for changes)"
fi