#!/bin/sh

set -e

cd $(dirname $0)

cat dotfiles | while read line; do
  ln -sfv "$HOME/.dotfiles/$line" $HOME
done
