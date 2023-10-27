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
    
    echo "💾 𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙍𝙖𝙢 ☞ $total_ram MB"
    echo "📊 𝘽𝙀𝙁𝙊𝙍𝙀 ☞ $free_ram_before MB"
    echo "📈 𝘼𝙁𝙏𝙀𝙍 ☞ $free_ram_after MB"
    echo "♻️ 𝙍𝘼𝙈 𝙀𝙧𝙖𝙨𝙚𝙙 ☞ $erased_ram MB
     "" "
}

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Ambil status RAM sebelum dan setelah membersihkan cache RAM
ram_status=$(get_ram_status)

# Dapatkan tanggal dan waktu saat ini
date=$(date "+%d-%m-%Y %I:%M %p")

# Buat pesan notifikasi
MSG="
╔═══════════════════════════╗
  ╔═══╦═══╦╗──╔╦══╗╔═══╦════╗
  ║╔══╩╗╔╗║╚╗╔╝║╔╗║║╔═╗║╔╗╔╗║
  ║╚══╗║║║╠╗╚╝╔╣╚╝╚╣║─║╠╝║║╚╝
  ║╔══╝║║║║╚╗╔╝║╔═╗║║─║║─║║
  ║╚══╦╝╚╝║─║║─║╚═╝║╚═╝║─║║
  ╚═══╩═══╝─╚╝─╚═══╩═══╝─╚╝
╚═══════════════════════════╝
╔═══𝙍𝘼𝙈 𝙎𝙪𝙥𝙚𝙧𝙘𝙝𝙖𝙧𝙜𝙚════════════╗
$ram_status
╔═══════════════════════════╗
╠ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $date
╚═══════════════════════════╝
"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$ID" -d "text=$MSG"
