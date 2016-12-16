#!/bin/bash

#set -x

TEST_NAME=centos

docker stop ${TEST_NAME}

docker rm ${TEST_NAME}

docker rmi ${TEST_NAME}