#!/bin/sh

REPO="esycat/jetbrains-hub"
TAG=${1:-"1.0"}

docker build -t $REPO:$TAG $(dirname $0) || exit $?
echo $REPO:$TAG image is ready.
