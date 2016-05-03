typeset -U path PATH
setopt no_global_rcs
eval `/usr/libexec/path_helper -s`

path=(
  ./node_modules/.bin
  $HOME/local/bin
  $HOME/.nodebrew/current/bin
  /usr/local/opt/go/libexec/bin
  $path
)

source ~/perl5/perlbrew/etc/bashrc
eval "$(rbenv init -)"

export GOPATH=$HOME/local
