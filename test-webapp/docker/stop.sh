#!/bin/bash

#set -x

echo "Container will stop, to finish the work quickly..."

echo $(date) >> /var/log/stop.log

asadmin stop-domain

echo "App has stopped."