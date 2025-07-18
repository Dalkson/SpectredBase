#!/bin/bash
clear
echo -e "\e[0;36m==================================================================\e[0;31m "
echo "   _____                 __                ______                ";
echo "  / ___/____  ___  _____/ /_________  ____/ / __ )____ _________ ";
echo "  \__ \/ __ \/ _ \/ ___/ __/ ___/ _ \/ __  / __  / __ \`/ ___/ _ \\";
echo " ___/ / /_/ /  __/ /__/ /_/ /  /  __/ /_/ / /_/ / /_/ (__  )  __/";
echo "/____/ .___/\___/\___/\__/_/   \___/\__,_/_____/\__,_/____/\___/ ";
echo "    /_/                                                          ";
echo -e "\e[0;36m=================================================================="
echo -e "\e[0m"

sleep 1

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m1. Downloading Binary... \e[0m" && sleep 1

cd ~/spectred
wget https://github.com/spectre-project/rusty-spectre/releases/download/v0.3.15/rusty-spectre-v0.3.15-linux-gnu-amd64.zip
unzip rusty-spectre-v0.3.15-linux-gnu-amd64.zip
rm -r rusty-spectre-v0.3.15-linux-gnu-amd64.zip

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m2. Replacing Binary... \e[0m" && sleep 1

killall spectred
killall spr_bridge
screen -S node -X kill
screen -S bridge -X kill
mv bin/* .
rm -r bin

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32mFinished... Please start node again. \e[0m" && sleep 1

