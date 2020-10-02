#!/bin/sh

BASE=andreadelfante/android-ci-gem
<<<<<<< HEAD
=======
# VERSION_BASE defines a version to build.
# Please uncomment it to define the version to build.
#VERSION_BASE=
>>>>>>> a523f4b0ea704de3a3760848c36d0fa05ef63b0e
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
<<<<<<< HEAD
git commit -m "Version latest ready"
=======
git commit -m "Version ${VERSION_BASE} (latest) ready"
>>>>>>> a523f4b0ea704de3a3760848c36d0fa05ef63b0e
git push

git tag -d $LATEST_BASE
git push --delete origin $LATEST_BASE

git tag $LATEST_BASE
git push origin --tags
