#!/bin/bash

#set -x

TEST_NAME=centos

docker build -t ${TEST_NAME} .

docker run -d --name ${TEST_NAME} ${TEST_NAME}

docker logs -f ${TEST_NAME}