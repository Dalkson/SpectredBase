#!/bin/bash
killall spectred
screen -S node -X kill

cd $(dirname "$0")
screen -dmS node ./spectred --utxoindex --rpclisten=0.0.0.0:18110 --rpclisten-borsh=127.0.0.1:19110
screen -ls