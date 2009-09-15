#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload colors
colors

if [ -n ${SSH_CONNECTION} ]; then
PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} 
[%n]$ "
else
PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} 
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
fi

PROMPT2='[%n]> ' 

#補間
autoload -U compinit
compinit

#履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

#先方予約
#autoload predict-on
#predict-on

#ビープ音ならなさない
setopt nobeep

#cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

#キーバインド
bindkey -e

#ターミナルのタイトル
#case "${TERM}" in
#kterm*|xterm)
#    precmd() {
#        echo -ne "\033]0;${HOST}\007"
#    }
#    ;;
#esac 

#lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#デフォルトパーミッションの設定
umask 022

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

alias :q='exit'

alias svnadd="svn st | grep '^?' | awk '{ print \$2 }' | xargs svn add"
alias svndel="svn st | grep '^!' | awk '{ print \$2 }' | xargs svn delete"

alias -g G="| grep"
alias -g L="| less"

alias gs="git svn"

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

#rm *の前に確認しない
#setopt rm_star_silent

#screenのステータスラインに最後に実行したコマンドを表示
if [ "$TERM" = "screen" ]; then
    #chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*) 
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd () {}
fi

#w3m4alc
function alc() {
  if [ $# != 0 ]; then
    #lynx "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    #lynx "http://www.alc.co.jp/"
    w3m "http://www.alc.co.jp/"
  fi
}

#個別設定を読み込む
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#エディタ
#どうやらscreenの自動起動前にこれを読み込むと調子悪いらしい
export EDITOR=vi
