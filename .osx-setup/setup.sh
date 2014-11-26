#!/bin/sh

# $ mkdir -p ~/local/tmp/setup
# $ cd ~/local/tmp/setup
# $ curl -O https://raw.github.com/hokaccha/dotfiles/.osx-setup/setup.sh
# $ sh setup.sh

set -e

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl -O https://raw.github.com/hokaccha/dotfiles/.osx-setup/Brewfile
brew bundle
ln -sfv /usr/local/opt/**/*/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/*

# dotfiles
pushd $HOME
git clone https://github.com/hokaccha/dotfiles.git .dotfiles
./dotfiles/symlink.sh

# go get
go get github.com/motemen/ghq
go get github.com/peco/peco
