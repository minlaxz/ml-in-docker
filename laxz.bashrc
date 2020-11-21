# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PS1="\[\e[31m\]mlaxz-dock\[\e[m\] \[\e[33m\]\w\[\e[m\] > "
export TERM=xterm-256color

alias grep="grep --color=auto"
alias ls="ls --color=auto"

echo -e "\e[1;31m"
cat<<ML
 __  __  ____  _  _  __      __    _  _  ____ 
(  \/  )(_  _)( \( )(  )    /__\  ( \/ )(_   )
 )    (  _)(_  )  (  )(__  /(__)\  )  (  / /_ 
(_/\/\_)(____)(_)\_)(____)(__)(__)(_/\_)(____) ___ minlaxz

ML
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

cd $HOME

_check_internet(){
wget -q --spider google.com
if [ $? -eq 0 ]; then
_check_update
else
cat<<EOF
seem to be Offline ...
ps consider manually update => dklaxz --update
EOF
fi
}

_check_update(){
  curl -fsSL https://raw.githubusercontent.com/minlaxz/scripts/master/dklaxz -o /dklaxz
  DKHASH=$(sha1sum /usr/bin/dlaxz | cut -c 1-40)
  DKTMPHASH=$(sha1sum /dklaxz | cut -c 1-40)
  if [[ "$DKHASH" == "$DKTMPHASH" ]]; then
  echo "dklaxz up-to-date."
  rm /dklaxz
  else 
  mv /dklaxz /usr/bin/dklaxz
  echo "dklaxz is updated."
  fi

#sha256sum -c SHA256SUMS 2>&1 | grep OK
}

_check_internet

echo "You can type 'dklaxz --help' for more."

# Turn off colors
echo -e "\e[m"
