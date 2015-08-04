#!/bin/sh

set -x

list=(
    .gitconfig
    .gitexclude
    .gitignore
    .gvimrc
    .peco
    .tigrc
    .tmux.conf
    .vim
    .vimrc
    .vimrc.bundle
    .vimrc_first.vim
    .zsh_fn
    .zshrc
    .zshenv
)

for name in ${list[@]}
do
  ln -sfv "$HOME/.dotfiles/$name" $HOME
done
