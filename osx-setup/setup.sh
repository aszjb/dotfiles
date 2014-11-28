#!/bin/sh

set -e

cd $(dirname $0)

./dotfiles.sh
./brew.sh
./nodebrew.sh
./go.sh
