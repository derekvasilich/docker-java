#!/bin/sh
set e+x

## For docker hub 
IMAGE=docker-java:latest
DOCKER_HUB_TAG=derekvasilich/$IMAGE

## Replace with internal GitLab repo URL
REPO=gitlab.derekwilliams.biz:5050
NAMESPACE=dealer-gears
PROJECT=dg-android
TAG=$REPO/$NAMESPACE/$PROJECT/$IMAGE

docker login $REPO

echo "Building $TAG"
docker build -t $TAG .

echo "Do you wish to push the image (Y/n)?"
read PUSH
if [[ "$PUSH" == "Y" ]]
then
    echo "Pushing $TAG"
    docker push $TAG
fi