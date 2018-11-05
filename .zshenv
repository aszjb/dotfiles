typeset -U path PATH
setopt no_global_rcs
eval `/usr/libexec/path_helper -s`
export PATH=$HOME/local/bin:$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export GOPATH=$HOME/local
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
