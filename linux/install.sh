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

read -e -p "Do you want to bootstrap (Quick Sync)? (y/N) " bschoice
read -e -p "Install Bridge? (y/N) " installbridgechoice
read -e -p "Install Chrony (Recommended)? (Y/n) " installchronychoice
read -e -p "Start on reboot? (y/N) " runonrebootchoice

sleep 1


echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m1. Installing required dependencies... \e[0m" && sleep 1

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install screen unzip psmisc  -y
cd $HOME
killall spectred
killall spr_bridge
screen -S node -X kill
screen -S bridge -X kill
rm -rf ~/spectred
rm -rf $HOME/.rusty-spectre/spectre-mainnet/*
[[ "$installchronychoice" == [Nn]* ]] || sudo apt-get install chrony -y


echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m2. Grabbing Binary... \e[0m" && sleep 1

mkdir ~/spectred
cd ~/spectred
wget https://github.com/spectre-project/rusty-spectre/releases/download/v0.3.16/rusty-spectre-v0.3.16-linux-gnu-amd64.zip
unzip rusty-spectre-v0.3.16-linux-gnu-amd64.zip
rm rusty-spectre-v0.3.16-linux-gnu-amd64.zip
mv bin/* .
rm -r bin

function bootstrap() {
echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32mBootstrapping... \e[0m" && sleep 1

mkdir -p ~/.rusty-spectre/spectre-mainnet/
cd ~/.rusty-spectre/spectre-mainnet/
wget https://spectredbase.com/datadir.zip
unzip datadir.zip
rm datadir.zip

}

[[ "$bschoice" == [Yy]* ]] && bootstrap

function runonreboot() {
echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32mAdding to crontab... \e[0m" && sleep 1

crontab -l | grep -q '@reboot ~/spectred/startNodeBridge.sh'  && echo 'entry exists' || (crontab -l ; echo "@reboot ~/spectred/startNodeBridge.sh") | crontab -
	
}

[[ "$runonrebootchoice" == [Yy]* ]] && runonreboot

echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m3. Starting Node... \e[0m" && sleep 1

cd ~/spectred
screen -dmS node ./spectred --utxoindex --rpclisten=0.0.0.0:18110 --rpclisten-borsh=127.0.0.1:19110

function installbridge() {
echo -e "\e[0;36m=================================================="
echo -e "\e[1m\e[32m4. Installing and running Bridge, please wait... \e[0m" && sleep 1

wget https://spectredbase.com/linux/spr_bridge-v0.3.15-linux-x86_64.zip
unzip spr_bridge-v0.3.15-linux-x86_64.zip
rm spr_bridge-v0.3.15-linux-x86_64.zip
mv spr_bridge-v0.3.15-linux-x86_64/* .
rm -r spr_bridge-v0.3.15-linux-x86_64
chmod +x spr_bridge

wget https://spectredbase.com/linux/startNodeBridge.sh
chmod +x startNodeBridge.sh

sleep 10
screen -dmS bridge ./spr_bridge
}

[[ "$installbridgechoice" == [Yy]* ]] && installbridge || $(wget https://spectredbase.com/linux/startNode.sh && chmod +x startNode.sh)

screen -ls


