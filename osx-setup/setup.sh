#!/bin/sh

set -e

cd $(dirname $0)

# dotfiles
cat symlinks | while read line; do
  ln -Fis "$HOME/$line" $HOME
done

exit

# brew
cat brew | while read line; do
  brew install $line
done

brew cleanup
ln -sfv /usr/local/opt/**/*/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/*

# nodebrew
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary stable 
nodebrew use stable
#npm update -g npm
npm install -g jshint
npm install -g jsonlint

# go
go get github.com/peco/peco
go get github.com/motemen/ghq
