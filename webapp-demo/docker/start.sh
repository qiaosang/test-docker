#!/bin/bash

#set -x

trap "${APP_HOME}/stop.sh" SIGTERM

cat ${APP_HOME}/hosts >> /etc/hosts

asadmin start-domain

asadmin deploy ${APP_HOME}/${APP_NAME}

echo "App is running..."

/usr/sbin/sshd

#set +x

while true
do
  sleep 1
done;