export LANG=ja_JP.UTF-8

# load colors
autoload colors
colors

# prompt
setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='> '

# vcs info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '%{${fg[green]}%}(%b%{${fg[red]}%}%c%u%{${fg[green]}%})%{$reset_color%}'

# completions
fpath=(/usr/local/share/zsh-completions $fpath)
[ -d ~/.zsh_fn ] && fpath=($HOME/.zsh_fn $fpath)
autoload -U compinit
compinit -u

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# editor
export EDITOR=vi

# key bind
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

# cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

# ls colors
export LSCOLORS=exfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;34:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'ex=32'

# default permission
umask 022

# alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFah"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

# misc settings
unsetopt promptcr
setopt nobeep

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# alc for CLI
function alc() {
  w3m "http://eow.alc.co.jp/search?q=$*" | less +30
}

# macvim
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vim="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
fi

# bundle
alias be="bundle exec"
alias bi="bundle install"

# peco
function peco-cd-ghq {
  local ghq_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$ghq_dir" ]; then
    BUFFER="cd $(git config --global ghq.root)/$ghq_dir"
    zle accept-line
    zle clear-screen
  fi
}

zle -N peco-cd-ghq
bindkey '^h' peco-cd-ghq

function tmpdir() {
  NAME=$(date "+%Y%m%d-%H%M%S")
  DIR="$HOME/tmp/$NAME"
  mkdir $DIR
  cd $DIR
}

function hi() {
    pbpaste | highlight --syntax=$1 --font-size=42 --font=Monaco --style=fine_blue --encoding=utf-8 -O rtf | pbcopy
}

# Load local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
