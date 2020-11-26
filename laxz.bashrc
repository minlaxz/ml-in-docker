# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PS1="\[\e[31m\]mlaxz-dock\[\e[m\] \[\e[33m\]\w\[\e[m\] > "
export TERM=xterm-256color

alias grep="grep --color=auto"
alias ls="ls --color=auto"

DK_PREFIX=/usr/local/dklaxz
DK_REPO=https://github.com/minlaxz/ml-in-docker.git

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
which should map to the ID and group for your user on the Docker host.
Great!
EXPL
fi
echo -e "\e[m"
########################################################

_check_internet(){
wget -q --spider google.com
if [ $? -eq 0 ]; then

echo -e "\e[7;33m"
echo "installing dklaxz, please wait a bit ... "
echo -e "\e[m"

_install_dklaxz

else
echo -e "\e[0;31m"
echo "=> dklaxz can't be installed for now. seem to be OFFLINE ..."
echo -e "\e[m"

fi

}
########################################################

_install_dklaxz(){
  git clone --quiet $DK_REPO $DK_PREFIX && cd $_
  # DKTMPHASH=$(cat ./current_hash 2> /dev/null)
  # rm -rf .git Dockerfile.* LICENSE README.md deprecated examples-ipynb.txt laxz.bashrc .gitignore current_hash
  # DKHASH=$(find . \( ! -regex '.*/\..*' \) -type f -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')
  # echo "Defined hash : ${DKTMPHASH}"
  DKHASH=$(find . -maxdepth 2 -name "*.sh" -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}')
  echo "dklaxz's current hash : ${DKHASH}"
  ln -s $DK_PREFIX/dklaxz.sh /usr/bin/dklaxz
  chmod 755 /usr/bin/dklaxz
}

########################################################

_check_internet

echo -e "\e[1;35m"
echo "You can type 'dklaxz --help' for more."
echo -e "\e[m"
cd /tf
