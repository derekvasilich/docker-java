#!/bin/sh

docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} cat /etc/debian_version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} env
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} java -version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} git --version
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} whoami
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} pwd
docker container run --rm --entrypoint '' ${IMAGE_NAME:-derekvasilich/docker-java} sdkmanager --list_installed
