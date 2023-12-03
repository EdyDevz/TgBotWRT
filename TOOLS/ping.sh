#!/bin/bash

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# PING SERVER
SERVER=("1.1.1.1")
messages=()
failed=0
for server in "${SERVER[@]}"
do
    result=$(ping -c 1 $SERVER)
    if [ $? -eq 0 ]; then
        ping=$(echo "$result" | awk -F'/' 'END {printf "%.0f", $5}')
        messages+=("➤ PING❗$ping ms..")
    else
        messages+=("➤ FAILED ❌")
        failed=$((failed_count + 1))
    fi
done
for msg in "${messages[@]}"
do
    MSG+="$msg"
done

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG"