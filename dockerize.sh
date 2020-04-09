#!/usr/bin/env bash

if [[ "${DOCKERHUB_USER}" == "" ]]; then
    echo "Docker hub username is needed in order to build docker images."
    echo "Please provide one with:"
    echo ""
    echo "DOCKERHUB_USER=<docker-hub-username> ./dockerize.sh"
    echo ""
    exit 1
fi

if [[ "${DOCKERHUB_PASSWORD}" == "" ]]; then
    echo "---------------------------------------------------------"
    echo "Docker hub password is not provided. You may have to push"
    echo "to repository by your own with command:"
    echo ""
    echo "docker push <image-name>"
    echo "---------------------------------------------------------"
    echo ""
fi

echo "All images built with this script will be created and tagged with 'latest' under your username: ${DOCKERHUB_USER}"
echo "These are the expected images:"
echo ""

echo "- ${DOCKERHUB_USER}/origin"
echo "- ${DOCKERHUB_USER}/backend"
echo "- ${DOCKERHUB_USER}/migration-demo"
echo "- ${DOCKERHUB_USER}/simulator"

echo ""

# Dockerize origin
echo "Dockerizing ${DOCKERHUB_USER}/origin ..."
if [[ ! -f "package.json" ]]; then
    echo "[${DOCKERHUB_USER}/origin] I expect you to run this script in origin project. No file 'package.json' found."
    exit 1
fi

VERSION="latest"
IMAGE_NAME="${DOCKERHUB_USER}/origin"

docker build -t ${IMAGE_NAME}:${VERSION} -f origin.Dockerfile .

if [ ! $? -eq 0 ]; then
    echo "[${DOCKERHUB_USER}/origin] Fail to build ${DOCKERHUB_USER}/origin."
    exit 1
fi