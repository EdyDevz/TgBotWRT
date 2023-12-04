#!/bin/bash

cd
opkg install git
opkg install git-http
opkg install python3
opkg install python3-pip
opkg install jq
opkg install sysstat
opkg install nano
pip3 install telepot requests python-telegram-bot
opkg list-installed | grep python3
pip3 list
git clone -b OFFLINE https://github.com/EdyDevz/TgBotWRT
mv /root/TgBotWRT/edy /etc/init.d/
mv /root/TgBotWRT/edy.py /usr/bin/
chmod +x /etc/init.d/edy
chmod +x /usr/bin/edy.py
chmod +x /root/TgBotWRT/*
clear
echo "JANGAN LUPA ISI BOT TOKEN DAN ID TELEGRAM YA ANJING"
sleep 10
echo "TUTORIAL DAH LENGKAP JANGAN BANYAK TANYA YA ANJING"
sleep 10
clear
nano /root/TgBotWRT/AUTH
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
service edy enable
service edy start
