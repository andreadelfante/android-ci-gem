#!/bin/sh

BASE=andreadelfante/android-ci-gem
VERSION_BASE=28.0.2

RC=$BASE:rc
VERSION=$BASE:$VERSION_BASE

docker rmi $RC --force
docker rmi $VERSION --force

docker build -t $RC .

docker tag $RC $VERSION

docker login
docker push $VERSION

git add .
git commit -m "Version ${VERSION_BASE} ready"
git push

git tag -d $VERSION_BASE
git push --delete origin $VERSION_BASE

git tag $VERSION_BASE
git push origin --tags
