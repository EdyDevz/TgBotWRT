#!/bin/bash

cd
opkg install git
opkg install git-http
opkg install python3
opkg install python3-pip
opkg install jq
opkg install sysstat
pip3 install telepot requests python-telegram-bot
opkg list-installed | grep python3
pip3 list
git clone https://github.com/EdyDevz/TgBotWRT
mv /root/TgBotWRT/edy /etc/init.d/
mv /root/TgBotWRT/edy.py /usr/bin/
chmod +x /etc/init.d/edy
chmod +x /root/TgBotWRT/*
rm -rf /root/TgBotWRT/plugins
clear
nano /root/TgBotWRT/AUTH
service edy enable
service edy start
clear
echo "PLEASE WAIT....."
sleep 5
echo "INSTALLING TOOLS....."
sleep 5
clear
echo "
╔════════════════════════════════════════════════════════╗
 ███████╗██████╗░██╗░░░██╗░██╗░░░░░░░██╗██████╗░████████╗
 ██╔════╝██╔══██╗╚██╗░██╔╝░██║░░██╗░░██║██╔══██╗╚══██╔══╝
 █████╗░░██║░░██║░╚████╔╝░░╚██╗████╗██╔╝██████╔╝░░░██║░░░
 ██╔══╝░░██║░░██║░░╚██╔╝░░░░████╔═████║░██╔══██╗░░░██║░░░
 ███████╗██████╔╝░░░██║░░░░░╚██╔╝░╚██╔╝░██║░░██║░░░██║░░░
 ╚══════╝╚═════╝░░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝░░░╚═╝░░░
╚════════════════════════════════════════════════════════╝"
echo "[+] THAKS FOR USE MY TOOLS & SUPPORT ME :)"
