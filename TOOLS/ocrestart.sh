#!/bin/bash

service openclash restart

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="➤ 𝙍𝙀𝙎𝙏𝘼𝙍𝙏 𝙊𝙋𝙀𝙉𝘾𝙇𝘼𝙎𝙃 𝙎𝙐𝘾𝘾𝙀𝙎𝙎𝙁𝙐𝙇"

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/edy.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto