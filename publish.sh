#!/bin/sh

BASE=andreadelfante/android-ci-gem
VERSION_BASE=29.0.2
LATEST_BASE=latest

RC=$BASE:rc
LATEST=$BASE:$LATEST_BASE
VERSION=$BASE:$VERSION_BASE

docker rmi $RC --force
docker rmi $LATEST --force
docker rmi $VERSION --force

docker build -t $RC .

docker tag $RC $VERSION
docker tag $RC $LATEST

docker login
docker push $VERSION
docker push $LATEST

git add .
git commit -m "Version ${VERSION_BASE} ready"
git push

git tag -d $LATEST_BASE
git push --delete origin $LATEST_BASE

git tag -d $VERSION_BASE
git push --delete origin $VERSION_BASE

git tag $LATEST_BASE
git tag $VERSION_BASE
git push origin --tags
