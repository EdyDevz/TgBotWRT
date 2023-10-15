#!/bin/bash

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

# Fungsi untuk mengirim pesan ke bot Telegram
send_telegram_message() {
    chat_id="$1"
    message="$2"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$chat_id&text=$message" > /dev/null
}

# Fungsi untuk mengambil data download, upload, dan total dari vnstat
get_daily_bandwidth() {
    vnstat_output=$(vnstat -i br-lan -m 1 --style 0 | sed -n 6p)
    download=$(echo "$vnstat_output" | awk '{print $5, $6}')
    upload=$(echo "$vnstat_output" | awk '{print $2, $3}')
    total=$(echo "$vnstat_output" | awk '{print $8, $9}')
    
    echo "
╔═══𝗕𝗔𝗡𝗗𝗪𝗜𝗧𝗛 𝗠𝗢𝗡𝗧𝗛𝗟𝗬 𝗥𝗘𝗣𝗢𝗥𝗧════╗
║
╠ 𝗗𝗢𝗪𝗡𝗟𝗢𝗔𝗗: $download
╠ 𝗨𝗣𝗟𝗢𝗔𝗗: $upload
╠ 𝗧𝗢𝗧𝗔𝗟: $total
╠ 𝘾𝙝𝙚𝙘𝙠𝙚𝙙 𝙗𝙮 𝙀𝙙𝙮 𝘿𝙚𝙫𝙚𝙡𝙤𝙥𝙚𝙧 🤖
║
╠═════════════════════════════╗
╠ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $(date +'%d-%m-%Y %I:%M %p')
╚═════════════════════════════╝
"
}

# Main program
get_ip_info
bandwidth_message=$(get_daily_bandwidth)

# Mengirim pesan ke akun Telegram pribadi
send_telegram_message "$CHAT_ID" "$bandwidth_message"
