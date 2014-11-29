#!/bin/sh

set -e

cd $(dirname $0)

cat brew | while read line; do
  brew install $line
done

brew cleanup
zsh -c 'ln -sfv /usr/local/opt/**/*/*.plist ~/Library/LaunchAgents'
launchctl load ~/Library/LaunchAgents/*
