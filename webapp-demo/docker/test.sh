#!/bin/bash

set -x

TEST_NAME=docker-web-demo

cd ..

mvn clean
mvn package -P test

docker build -f docker/Dockerfile -t ${TEST_NAME} .

docker run -d -p 8080:8080 --name ${TEST_NAME} ${TEST_NAME}

docker logs -f ${TEST_NAME}