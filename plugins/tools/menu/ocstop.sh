#!/bin/bash

service openclash stop

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TgBotWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        BOT_TOKEN="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
        echo "Berkas auth harus memiliki setidaknya 2 baris (token dan chat ID Anda)."
        exit 1
    fi
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="𝙎𝙏𝙊𝙋 𝙊𝙋𝙀𝙉𝘾𝙇𝘼𝙎𝙃 𝙎𝙐𝘾𝘾𝙀𝙎𝙎𝙁𝙐𝙇 ✅"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG"
