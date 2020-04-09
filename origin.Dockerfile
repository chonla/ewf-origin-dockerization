FROM node:12.16.1-alpine

ADD . /app
WORKDIR /app

RUN apk --no-cache add make gcc g++ python bash
RUN yarn && yarn install
