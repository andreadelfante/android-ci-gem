#!/bin/sh

BASE=andreadelfante/android-ci-gem
# VERSION_BASE defines a version to build.
# Please uncomment it to define the version to build.
#VERSION_BASE=
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
git commit -m "Version ${VERSION_BASE} (latest) ready"
git push

git tag -d $LATEST_BASE
git push --delete origin $LATEST_BASE

git tag $LATEST_BASE
git push origin --tags
