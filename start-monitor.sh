#!/bin/sh

IP="`ip route get 8.8.8.8 | awk '{print $NF; exit}'`"

set -x

docker run -d -p ${IP}:2222:22 -p ${IP}:8081:8081 -t mbed/blockchain-monitor-ui  /home/arm/start_instance.sh
