#!/bin/bash

echo "UPDATING REPOSITORY"
sleep 2
opkg update
clear
echo "SUCCESS"
clear
sleep 2
cd
echo "INSTALLING GIT"
sleep 2
opkg install git
opkg install git-http
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING PYTHON"
sleep 2
opkg install python3
opkg install python3-pip
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING JQ"
sleep 2
opkg install jq
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING SYSSTAT"
sleep 2
opkg install sysstat
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING NANO"
sleep 2
opkg install nano
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING TMUX"
sleep 2
opkg install tmux
clear
echo "SUCCESS"
clear
sleep 2
echo "INSTALLING TOOLS ...."
sleep 2
pip3 install telepot requests python-telegram-bot
opkg list-installed | grep python3
pip3 list
git clone -b SCRIPT https://github.com/EdyDevz/TgBotWRT
mv /root/TgBotWRT/edy /etc/init.d/
mv /root/TgBotWRT/edy.py /usr/bin/
chmod +x /etc/init.d/edy
chmod +x /usr/bin/edy.py
chmod +x /root/TgBotWRT/*
chmod +x /root/TgBotWRT/TOOLS/*
clear
echo "SUCCESS"
clear
sleep 5
echo "JANGAN LUPA ISI BOT TOKEN DAN ID TELEGRAM YA ANJING"
sleep 10
echo "TUTORIAL DAH LENGKAP JANGAN BANYAK TANYA YA ANJING"
sleep 10
clear
nano /root/TgBotWRT/AUTH
echo "PLEASE WAIT....."
sleep 5
clear
echo "SETUP TOOLS ....."
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
