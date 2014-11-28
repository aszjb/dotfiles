#!/bin/sh

set -e

export PATH=$HOME/.nodebrew/current/bin:$PATH

curl -L git.io/nodebrew | perl - setup
nodebrew install-binary stable 
nodebrew use stable
#npm update -g npm
npm install -g jshint
npm install -g jsonlint
