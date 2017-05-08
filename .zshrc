# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '%{${fg[green]}%}(%b%{${fg[red]}%}%c%u%{${fg[green]}%}) %{$reset_color%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
🍺  "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='🍻  ' 

# 補間
fpath=(/usr/local/share/zsh-completions $fpath)
[ -d ~/.zsh_fn ] && fpath=($HOME/.zsh_fn $fpath)
autoload -U compinit
compinit -u

# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# エディタ
export EDITOR=vi

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
export LSCOLORS=exfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;34:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'ex=32'

# デフォルトパーミッションの設定
umask 022

# スラッシュを区切り文字に含める
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

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

# tmux auto startup
if type tmux >/dev/null 2>&1 && ! tmux ls -F '#{session_name}:#{session_attached}' 2>/dev/null | grep ^`whoami`:1$ >/dev/null; then
    tmux new -As `whoami`
fi

# 環境ごとの設定読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# The next line updates PATH for the Google Cloud SDK.
source '/Users/hokamura/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/hokamura/google-cloud-sdk/completion.zsh.inc'
