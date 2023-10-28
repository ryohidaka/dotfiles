#!/bin/bash
echo "[Start] Install Go"

goenv -v

GO_VERSION=$(goenv install -l | tail -n 1 | sed 's/ //g')

goenv install $GO_VERSION
goenv global $GO_VERSION

goenv rehash

go version

echo "[Complete] Install Go"
