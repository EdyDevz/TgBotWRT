#!/bin/sh

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Generate the system status report
MSG="
➤ 𝙑𝙉𝙎𝙏𝘼𝙏 📊

➤ /vnstat -d - 𝘿𝘼𝙄𝙇𝙔 𝘿𝘼𝙏𝘼 𝙐𝙎𝘼𝙂𝙀 📊
➤ /vnstat -m - 𝙈𝙊𝙉𝙏𝙃𝙇𝙔 𝘿𝘼𝙏𝘼 𝙐𝙎𝘼𝙂𝙀 📊
➤ /vnstat -y - 𝙔𝙀𝘼𝙍𝙇𝙔 𝘿𝘼𝙏𝘼 𝙐𝙎𝘼𝙂𝙀 📊
"

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/edy.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto