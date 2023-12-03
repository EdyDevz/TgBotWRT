#!/bin/sh

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
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
    MSG="
➤ 𝙀𝘿𝙔 𝙎𝙋𝙀𝙀𝘿𝙏𝙀𝙎𝙏 𝙏𝙊𝙊𝙇𝙎 ⚡

🏠 𝗛𝗢𝗦𝗧: $(uci get system.@system[0].hostname | tr -d '\0')
🛸 𝗣𝗜𝗡𝗚: $ping ms
🌐 𝗜𝗣: $ip
🛰️ 𝗦𝗘𝗥𝗩𝗘𝗥: $server_name
⛱️ 𝗜𝗦𝗣: $org
🌍 𝗥𝗘𝗚𝗜𝗢𝗡: $timezone
📥 𝗗𝗢𝗪𝗡𝗟𝗢𝗔𝗗: $download Mbps
📤 𝗨𝗣𝗟𝗢𝗔𝗗: $upload Mbps 
📊 𝗥𝗘𝗦𝗨𝗟𝗧: $result_url

➤ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $current_time
"
else
    # Jika speedtest gagal, maka mengirimkan pesan notifikasi
    MSG="𝙀𝘿𝙔 𝙎𝙀𝘿𝘼𝙉𝙂 𝙆𝙀𝙇𝙊𝙉....."
fi

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/edy.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto