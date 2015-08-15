#!/bin/sh

REPO="esycat/jetbrains-hub"
TAG="1.0"

NAME="jetbrains-hub"
PORTS="80:8080"
VOLUMES=""

docker create --name $NAME -p $PORTS $REPO:$TAG || exit $?

echo $NAME container is ready.
echo To start: docker start $NAME
