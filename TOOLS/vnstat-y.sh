#!/bin/bash

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Fungsi untuk mengambil data download, upload, dan total dari vnstat
get_daily_bandwidth() {
    vnstat_output=$(vnstat -i br-lan -y 1 --style 0 | sed -n 6p)
    download=$(echo "$vnstat_output" | awk '{print $5, $6}')
    upload=$(echo "$vnstat_output" | awk '{print $2, $3}')
    total=$(echo "$vnstat_output" | awk '{print $8, $9}')
    
    echo "
❏ BANDWIDTH YEARLY USAGE
└ DOWNLOAD: $download
└ UPLOAD: $upload
└ TOTAL: $total
└ DATE: $(date +'%d-%m-%Y %I:%M %p')
└ CHECKED BY EDY DEVELOPER
"
}

# Main program
get_ip_info
MSG=$(get_daily_bandwidth)

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/bot.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto