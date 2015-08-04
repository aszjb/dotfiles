#!/bin/sh

set -x

list=(
    zsh
    git
    w3m
    wget
    tig
    tree
    the_silver_searcher
    tmux
    reattach-to-user-namespace
    zsh-completions
    jq
    peco
    ghq
)

for name in ${list[@]}
do
    brew install $name
done
