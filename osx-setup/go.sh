#!/bin/sh

set -e

export GOPATH=$HOME/local

go get code.google.com/p/go.tools/cmd/godoc
go get github.com/nsf/gocode
go get github.com/motemen/ghq
go get github.com/peco/peco/cmd/peco
