#!/bin/bash

TEST_NAME=test

docker stop ${TEST_NAME}

docker rm ${TEST_NAME}

docker rmi ${TEST_NAME}