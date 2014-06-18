#!/bin/sh

set -e

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl -O https://raw.github.com/hokaccha/dotfiles/.osx-setup/Brewfile
brew bundle

ln -sfv /usr/local/opt/**/*/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/*
