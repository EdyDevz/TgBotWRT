#!/bin/bash

echo"
░█████╗░██████╗░░█████╗░████████╗
██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
██║░░╚═╝██████╔╝██║░░██║░░░██║░░░
██║░░██╗██╔══██╗██║░░██║░░░██║░░░
╚█████╔╝██║░░██║╚█████╔╝░░░██║░░░
░╚════╝░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░"
echo "BANDWITH LIMIT TEST"
echo "100MB TEST"
sleep 5
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
sleep 10
# READ AUTH
if [ -f "/root/TestBW/AUTH" ]; then
    TOKEN=$(head -n 1 /root/TestBW/AUTH)
    ID=$(tail -n 1 /root/TestBW/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

MSG "100MB SUCCESSFUL✅"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$ID" -d "text=$MSG"
exit