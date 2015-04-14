#!/bin/sh

set -e

$DIR=$HOME/local/src/github.com/hokaccha

mkdir -p $DIR
cd $DIR
git clone https://github.com/hokaccha/dotfiles
cd dotfiles/osx-setup

./dotfiles.sh
./brew.sh
./nodebrew.sh
./go.sh
