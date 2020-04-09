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

VERSION="latest"
DOCKERFILE_REPO_BASE="https://raw.githubusercontent.com/chonla/ewf-origin-dockerization/master"

build_from_remote_docker() {
    IMG="$1"
    DOCKERFILE="$2"
    DOCKERFILE_REPO="${DOCKERFILE_REPO_BASE}/${DOCKERFILE}"
    echo "[${IMG}] Building image from: ${DOCKERFILE_REPO}"
    curl "${DOCKERFILE_REPO}" | docker build -t ${IMG}:latest -
}

push_image_to_registry() {
    IMG=$1

    # image will be pushed only password is provided
    if [[ "${DOCKERHUB_PASSWORD}" != "" ]]; then
        echo "[${IMG}] Pushing ${IMG}:latest to registry"

        echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USER}" --password-stdin

        docker push "${IMG}:latest"
    fi
}

dockerize() {
    IMG=$1
    DOCKERFILE=$2

    echo "Dockerizing ${IMG} ..."
    build_from_remote_docker "${IMG}" "${DOCKERFILE}"
    if [ ! $? -eq 0 ]; then
        echo "[${IMG}] Fail to build ${IMG}."
        exit 1
    fi
    push_image_to_registry "${IMG}"
}

# Validating workspace
if [[ ! -f "package.json" ]]; then
    echo "[${IMAGE_NAME}] I expect you to run this script in origin project. No file 'package.json' found."
    exit 1
fi

# Dockerize origin
dockerize "${DOCKERHUB_USER}/origin" "origin.Dockerfile"