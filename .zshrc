# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}(%s %b) %{'$reset_color'%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='[%n]> ' 

# 補間
autoload -U compinit
compinit -u

# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

# エディタ
export EDITOR=vi

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# キーバインド
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

# ビープ音ならなさない
setopt nobeep

# cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# デフォルトパーミッションの設定
umask 022

# alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

# 環境ごとの設定読み込む
[ -f ~/.zshrc_env ] && source ~/.zshrc_env

# 個別設定を読み込む
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
