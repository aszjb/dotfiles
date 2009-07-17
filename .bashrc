umask 022

HISTSIZE=50000
HISTFILESIZE=50000
export HISTCONTROL=ignoreboth

PS1='\n\[\033[1;33m\]\w\n\[\033[1;37m\][\u]\$ '

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

bind "\C-n":history-search-forward
bind "\C-p":history-search-backward
