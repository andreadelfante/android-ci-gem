#!/bin/sh

BASE=andreadelfante/android-ci-gem
RC=$BASE:rc
LATEST=$BASE:latest
VERSION=$BASE:29.0.1

docker rmi $RC --force
docker rmi $LATEST --force
docker rmi $VERSION --force

docker build -t $RC .

docker tag $RC $LATEST
docker tag $RC $VERSION

docker login
docker push $LATEST
docker push $VERSION

