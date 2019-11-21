#!/bin/sh

BASE=andreadelfante/android-ci-gem
RC=$BASE:rc
VERSION=$BASE:28.0.3

docker rmi $RC --force
docker rmi $VERSION --force

docker build -t $RC .

docker tag $RC $VERSION

docker login
docker push $VERSION

