#!/bin/sh

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TgBotWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        bot_token="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
        echo "Berkas auth harus memiliki setidaknya 2 baris (token dan chat ID Anda)."
        exit 1
    fi
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Menjalankan speedtest dan menyimpan hasilnya dalam variabel
speedtest_result=$(speedtest)

# Cek apakah speedtest berhasil atau gagal
if [ $? -eq 0 ]; then
    # Jika berhasil, maka mengambil nilai-nilai yang diperlukan
    download=$(echo "$speedtest_result" | grep "Download" | awk '{print $2}')
    upload=$(echo "$speedtest_result" | grep "Upload" | awk '{print $2}')
    ping=$(echo "$speedtest_result" | grep "Latency" | awk '{print $2}' | sed 's/ms//')
    isp=$(echo "$speedtest_result" | grep "ISP" | cut -d ':' -f2-)
    server_name=$(echo "$speedtest_result" | grep "Server" | cut -d ':' -f2- | sed 's/(id = [0-9]*)//') # Menghilangkan "(id = ...)"
    result_url=$(echo "$speedtest_result" | grep "Result URL" | cut -d ':' -f2-)

    # Mengambil informasi dari perintah curl
    curl_result=$(curl -sS ipinfo.io/json?token=7b5dbaccc41db0)
    ip=$(echo "$curl_result" | jq -r '.ip')
    hostname=$(echo "$curl_result" | jq -r '.hostname')
    org=$(echo "$curl_result" | jq -r '.org')
    timezone=$(echo "$curl_result" | jq -r '.timezone')

    # Menambahkan tanggal dan waktu terakhir pembaruan
    current_time=$(date +"%d-%m-%Y %I:%M %p")

    # Membuat pesan dengan format yang diinginkan jika speedtest berhasil
    message="
╔═══════════════════════════╗
   ╔═══╦═══╦╗──╔╦══╗╔═══╦════╗
   ║╔══╩╗╔╗║╚╗╔╝║╔╗║║╔═╗║╔╗╔╗║
   ║╚══╗║║║╠╗╚╝╔╣╚╝╚╣║─║╠╝║║╚╝
   ║╔══╝║║║║╚╗╔╝║╔═╗║║─║║─║║
   ║╚══╦╝╚╝║─║║─║╚═╝║╚═╝║─║║
   ╚═══╩═══╝─╚╝─╚═══╩═══╝─╚╝
╚═══════════════════════════╝
╔══𝙀𝘿𝙔 𝙎𝙋𝙀𝙀𝘿𝙏𝙀𝙎𝙏 𝙏𝙊𝙊𝙇𝙎═════════╗
║
╠ 𝗛𝗢𝗦𝗧: $(uci get system.@system[0].hostname | tr -d '\0')
╠ 𝗣𝗜𝗡𝗚: $ping ms
╠ 𝗜𝗣: $ip
╠ 𝗦𝗘𝗥𝗩𝗘𝗥: $server_name
╠ 𝗜𝗦𝗣: $org
╠ 𝗥𝗘𝗚𝗜𝗢𝗡: $timezone
╠ 𝗗𝗢𝗪𝗡𝗟𝗢𝗔𝗗: $download Mbps
╠ 𝗨𝗣𝗟𝗢𝗔𝗗: $upload Mbps 
╠═════════════════════════════╗
╠ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $current_time
╚═════════════════════════════╝
"
else
    # Jika speedtest gagal, maka mengirimkan pesan notifikasi
    message="⚠️  𝙈𝙖𝙖𝙛, 𝙨𝙖𝙖𝙩 𝙞𝙣𝙞 𝙇𝙀𝙇𝙐𝙃𝙐𝙍 𝙀𝘿𝙔 𝙨𝙚𝙙𝙖𝙣𝙜 𝙢𝙖𝙡𝙖𝙨. ⚠️"
fi

# Mengirim pesan ke akun Telegram pribadi
curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$message" -d "parse_mode=Markdown"
