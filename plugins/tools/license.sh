#!/bin/bash

# Membaca token dan chat ID dari berkas token.txt
if [ -f "/root/TgBotWRT/script/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TgBotWRT/script/AUTH"
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
MSG="
𝙏𝙝𝙞𝙨 𝙞𝙨 𝙖 𝙨𝙘𝙧𝙞𝙥𝙩 𝙘𝙧𝙚𝙖𝙩𝙚𝙙 𝙖𝙣𝙙 𝙘𝙤𝙢𝙥𝙞𝙡𝙚𝙙 𝙗𝙮 𝙀𝙙𝙮.  𝙪𝙨𝙚 𝙨𝙚𝙣𝙨𝙞𝙗𝙡𝙮, 𝙙𝙤 𝙣𝙤𝙩 𝙚𝙙𝙞𝙩 𝙤𝙧 𝙧𝙚𝙪𝙥𝙡𝙤𝙖𝙙 𝙩𝙤 𝙖𝙣𝙤𝙩𝙝𝙚𝙧 𝙜𝙧𝙤𝙪𝙥𝙨;  𝙄 𝙘𝙖𝙣 𝙡𝙚𝙖𝙠 𝙮𝙤𝙪𝙧 𝙙𝙖𝙩𝙖 𝙞𝙛 𝙮𝙤𝙪 𝙚𝙙𝙞𝙩 𝙢𝙮 𝙨𝙘𝙧𝙞𝙥𝙩 𝙤𝙧 𝙨𝙚𝙡𝙡 𝙞𝙩 𝙩𝙤 𝙤𝙩𝙝𝙚𝙧 𝙥𝙚𝙤𝙥𝙡𝙚.  𝙧𝙚𝙢𝙚𝙢𝙗𝙚𝙧 𝙩𝙝𝙖𝙩, 𝙄𝙛 𝙩𝙝𝙚𝙧𝙚 𝙖𝙧𝙚 𝙖𝙣𝙮 𝙖𝙙𝙙𝙞𝙩𝙞𝙤𝙣𝙨/𝙘𝙤𝙣𝙛𝙪𝙨𝙞𝙤𝙣, 𝙮𝙤𝙪 𝙘𝙖𝙣 𝙥𝙢 𝙢𝙚: @kangbacox ( 𝙇𝙀𝙇𝙐𝙃𝙐𝙍 𝙀𝘿𝙔 )
"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG"
