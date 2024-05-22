#!/bin/sh

# Fungsi untuk mendapatkan status RAM
get_ram_status() {
    total_ram=$(free -m | awk 'NR==2{print $2}')
    free_ram_before=$(free -m | awk 'NR==2{print $7}')
    
    # Membersihkan cache RAM
    sync
    echo 3 > /proc/sys/vm/drop_caches
    rm -rf /tmp/luci*
    
    free_ram_after=$(free -m | awk 'NR==2{print $7}')
    erased_ram=$((free_ram_before - free_ram_after))
    
    echo "└ Available Ram: $total_ram MB"
    echo "└ Before: $free_ram_before MB"
    echo "└ After: $free_ram_after MB"
    echo "└ RAM Erased: $erased_ram MB"
}

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Ambil status RAM sebelum dan setelah membersihkan cache RAM
ram_status=$(get_ram_status)

# Dapatkan tanggal dan waktu saat ini
date=$(date "+%d-%m-%Y %I:%M %p")

# Buat pesan notifikasi
MSG="
❏ RAM SUPERCHARGE 🚀
$ram_status
└ DATE: $date
"

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/bot.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto