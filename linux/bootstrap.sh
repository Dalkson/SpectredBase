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

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m1. Preparing... \e[0m" && sleep 1

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install unzip psmisc  -y
killall spectred
killall spr_bridge
screen -S node -X kill
screen -S bridge -X kill
rm -rf $HOME/.rusty-spectre/spectre-mainnet/*

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m2. Bootstrapping... \e[0m" && sleep 1

mkdir -p ~/.rusty-spectre/spectre-mainnet/
cd ~/.rusty-spectre/spectre-mainnet/
wget https://spectredbase.com/datadir.zip
unzip datadir.zip
rm datadir.zip

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32mComplete, please start node. \e[0m" && sleep 1

