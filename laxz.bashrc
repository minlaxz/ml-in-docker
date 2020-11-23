# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PS1="\[\e[31m\]mlaxz-dock\[\e[m\] \[\e[33m\]\w\[\e[m\] > "
export TERM=xterm-256color

alias grep="grep --color=auto"
alias ls="ls --color=auto"

DK_PREFIX=/usr/local/dklaxz
DKTMP_PREFIX=/tmp/dklaxz

echo -e "\e[1;36m"
cat<<ML
 __  __  ____  _  _  __      __    _  _  ____ 
(  \/  )(_  _)( \( )(  )    /__\  ( \/ )(_   )
 )    (  _)(_  )  (  )(__  /(__)\  )  (  / /_ 
(_/\/\_)(____)(_)\_)(____)(__)(__)(_/\_)(____) ___ minlaxz

ML
echo -e "\e[m"
########################################################

echo -e "\e[0;33m"
if [[ $EUID -eq 0 ]]; then
  cat <<WARN
WARNING: You are running this container as root, which can cause new files in
mounted volumes to be created as the root user on your host machine.

To avoid this, run the container by specifying your user's userid:

$ docker run -u \$(id -u):\$(id -g) args...
WARN
else
  cat <<EXPL
You are running this container as user with ID $(id -u) and group $(id -g),
which should map to the ID and group for your user on the Docker host. Great!
EXPL
fi
echo -e "\e[m"
########################################################

_check_internet(){
wget -q --spider google.com
if [ $? -eq 0 ]; then
_check_dk_update
else
echo -e "\e[0;31m"
cat<<EOF
seem to be Offline ...
ps consider manually update later => dklaxz --update
EOF
fi
}
########################################################

_check_dk_update(){

cd $DK_PREFIX
DKHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sha256sum | awk '{print $1}')

echo -e "\e[7;33m"
cat<<EOF
  dklaxz is checking for update, please wait a bit ...   
EOF
echo -e "\e[m"

# download or update repo 
if [[ ! -f "$DKTMP_PREFIX/dklaxz" ]]; then
rm -rf $DKTMP_PREFIX
git clone --quiet https://github.com/minlaxz/ml-in-docker.git $DKTMP_PREFIX && cd $_
else
cd $DKTMP_PREFIX
git pull --quiet origin master
fi

# now inside DKTMP_PREFIX
rm !("dklaxz"|"dklaxz-extra")
DKTMPHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sha256sum | awk '{print $1}')

if [[ "$DKHASH" == "$DKTMPHASH" ]]; then
echo -e "\e[1;37m"
cat<<EOF
dklaxz up-to-date."
EOF
echo -e "\e[m"

else
echo -e "\e[1;31m"
cat<<EOF
dklaxz update available.
please consider running dklaxz --update
EOF
fi

echo -e "\e[2;32m"
cat<<EOF
"current hash : $DKHASH"
"lastest hash : $DKTMPHASH"
EOF
echo -e "\e[m"

#sha256sum -c SHA256SUMS 2>&1 | grep OK
}
########################################################

_check_internet
echo -e "\e[1;35m"
echo "You can type 'dklaxz --help' for more."
# Turn off colors
echo -e "\e[m"
cd /tf