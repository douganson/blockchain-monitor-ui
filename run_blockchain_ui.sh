#!/bin/sh

set -x

export PORT=8081
export HOST="`ip route get 8.8.8.8 | awk '{print $NF; exit}'`"

cd /home/arm
sudo rm -rf blockchain-samples 2>&1 1> /dev/null
git clone https://github.com/sumanair/blockchain-samples/
cd /home/arm/blockchain-samples/monitoring_ui
npm install
npm install buffertools
npm run build
npm run dev-server
