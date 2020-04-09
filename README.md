# Dockerization Origin Packages

1. Create base image from origin. Clone origin repository into your local machine.

    ```
    git clone https://github.com/energywebfoundation/origin.git
    ```

2. Create a file named `origin.Dockerfile` in origin directory. You may name it other name.

    ```
    FROM node:12.16.1-alpine

    ADD . /app
    WORKDIR /app

    RUN apk --no-cache add make gcc g++ python bash
    RUN yarn && yarn install
    ```

3. Build it.

    ```
    docker build -t ewf-origin:latest -f origin.Dockerfile .
    ```

4. Tag it.

    ```
    docker tag ewf-origin:latest chonla/ewf-origin:latest
    ```

5. Log into docker hub.

    ```
    docker login
    ```

6. Push the image to docker hub.

    ```
    docker push chonla/ewf-origin:latest
    ```

7. Done!

## Build them all

Go to origin package source code and run `curl https://raw.githubusercontent.com/chonla/ewf-origin-dockerization/master/dockerize.sh | DOCKERHUB_USER=<docker-hub-username> bash`

## Deploy Origin Package

See [Origin Deployment](https://github.com/energywebfoundation/origin/wiki/Origin-Deployment) document.
