#!/bin/sh

BASE=andreadelfante/android-ci-gem
LATEST_BASE=latest

RC=$BASE:rc
LATEST=$BASE:$LATEST_BASE

docker rmi $RC --force
docker rmi $LATEST --force

docker build -t $RC .

docker tag $RC $LATEST

docker login
docker push $LATEST

git add .
git commit -m "Version latest ready"
git push

git tag -d $LATEST_BASE
git push --delete origin $LATEST_BASE

git tag $LATEST_BASE
git push origin --tags
