#!/bin/bash

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Daftar server yang akan di-ping beserta alias-aliasnya
servers=("1.1.1.1:└ Cloudflare" "8.8.8.8:└ Google DNS" "google.com:└ Google" "facebook.com:└ Facebook" "instagram.com:└ Instagram" "twitter.com:└ Twitter" "youtube.com:└ YouTube" "github.com:└ GitHub" "pornhub.com:└ PornHUB")

# Inisialisasi variabel untuk menyimpan status setiap server
status_messages=()

# Inisialisasi variabel untuk menghitung jumlah server yang tidak aman
failed_count=0

# Inisialisasi pesan dengan informasi ISP, IP, dan zona waktu
MSG="
❏ PING TEST RESULTS ❏
"

# Loop melalui daftar server
for server in "${servers[@]}"
do
    # Split server dan alias menggunakan delimiter ":"
    IFS=':' read -ra server_parts <<< "$server"
    server_ip="${server_parts[0]}"
    server_alias="${server_parts[1]}"
    
    result=$(ping -c 1 -W 1 $server_ip)  # Mengirim satu paket ICMP dan timeout dalam 1 detik
    
    # Periksa hasil ping
    if [ $? -eq 0 ]; then
        response_time=$(echo "$result" | awk -F'/' 'END {printf "%.0f", $5}')  # Memformat tanpa desimal
        case "$server_alias" in
            "└ Cloudflare")
                ;;
            "└ Google DNS")
                ;;
            "└ Google")
                ;;
            "└ Facebook")
                ;;
            "└ Instagram")
                ;;
            "└ Twitter")
                ;;
            "└ YouTube")
                ;;
            "└ GitHub")
                ;;
            "└ PornHUB")
                ;;
        esac
        status_messages+=("$server_alias ☞ $response_time ms")
    else
        status_messages+=("$server_alias ☞ ❌")
        failed_count=$((failed_count + 1))
    fi
done

# Menambahkan status setiap server ke pesan notifikasi
for message in "${status_messages[@]}"
do
    MSG+="$message
"
done

# Buat pesan notifikasi berdasarkan jumlah server yang aman atau tidak aman
if [ $failed_count -eq 0 ]; then
    MSG+="
GOOD SERVER ✅"
else
    MSG+="
BAD SERVER❗"
fi

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/bot.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto