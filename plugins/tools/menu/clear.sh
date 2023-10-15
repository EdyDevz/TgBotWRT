#!/bin/sh

# Fungsi untuk mendapatkan status RAM
get_ram_status() {
    total_ram=$(free -m | awk 'NR==2{print $2}')
    free_ram_before=$(free -m | awk 'NR==2{print $7}')
    
    # Membersihkan cache RAM
    sync
    echo 1 > /proc/sys/vm/drop_caches
    
    free_ram_after=$(free -m | awk 'NR==2{print $7}')
    erased_ram=$((free_ram_before - free_ram_after))
    
    echo "💾 𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙍𝙖𝙢: $total_ram MB"
    echo ""
    echo "📊 𝙋𝙧𝙚𝙫𝙞𝙤𝙪𝙨 𝙍𝘼𝙈 𝙎𝙩𝙖𝙩𝙚: $free_ram_before MB"
    echo "📈 𝙇𝙖𝙩𝙚𝙨𝙩 𝙍𝘼𝙈 𝙋𝙚𝙧𝙛𝙤𝙧𝙢𝙖𝙣𝙘𝙚: $free_ram_after MB"
    echo "♻️ 𝙍𝘼𝙈 𝙀𝙧𝙖𝙨𝙚𝙙: $erased_ram MB
     "" "
}

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    chat_id_admin=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Ambil status RAM sebelum dan setelah membersihkan cache RAM
ram_status=$(get_ram_status)

# Dapatkan tanggal dan waktu saat ini
tanggal_waktu_sekarang=$(date "+%d-%m-%Y %I:%M %p")

# Buat pesan notifikasi
pesan_notifikasi="
╔═𝙍𝘼𝙈 𝙎𝙪𝙥𝙚𝙧𝙘𝙝𝙖𝙧𝙜𝙚═════════════╗

$ram_status

╔═══════════════════════════╗
╠ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $tanggal_waktu_sekarang
╚═══════════════════════════╝
"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$chat_id_admin" -d "text=$pesan_notifikasi"

echo "Membersihkan RAM dan cache serta mengirim notifikasi selesai."
