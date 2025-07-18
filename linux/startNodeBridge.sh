#!/bin/bash
killall spectred
killall spr_bridge
screen -S node -X kill
screen -S bridge -X kill

cd $(dirname "$0")
screen -dmS node ./spectred --utxoindex --rpclisten=0.0.0.0:18110 --rpclisten-borsh=127.0.0.1:19110
sleep 5
screen -dmS bridge ./spr_bridge
screen -ls