#!/bin/sh
# IMAGE=$IMAGE

REPO=gitlab.derekwilliams.biz:5050
NAMESPACE=dealer-gears
PROJECT=dg-android
IMAGE=$REPO/$NAMESPACE/$PROJECT/docker-java

docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} cat /etc/debian_version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} env
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} java -version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} gradle -version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} mvn -version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} git --version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} whoami
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} pwd
docker container run --rm --entrypoint '' ${IMAGE_NAME:-$IMAGE} sdkmanager --list_installed

# Run Snyk security scan
#   npm i -g snyk
#   snyk auth
echo "Do you wish to perform a security scan (Y/n)?"
read SCAN
if [[ "#SCAN" == "Y" ]]
then
    snyk container test $IMAGE --file=Dockerfile
fi