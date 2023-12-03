#!/bin/sh

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Generate the system status report
MSG="
➤ 𝙀𝘿𝙔 𝙈𝙊𝙉𝙄𝙏𝙊𝙍𝙄𝙉𝙂 𝘽𝙊𝙏 🚀

➤ 𝙎𝙮𝙨𝙩𝙚𝙢 𝙄𝙣𝙛𝙤𝙧𝙢𝙖𝙩𝙞𝙤𝙣:
🏠 𝙃𝙤𝙨𝙩𝙣𝙖𝙢𝙚: $(uci get system.@system[0].hostname | tr -d '\0')
💻 𝙈𝙤𝙙𝙚𝙡: $(cat /proc/device-tree/model | tr -d '\0')
🔶 𝘼𝙧𝙘𝙝𝙞𝙩𝙚𝙘𝙩𝙪𝙧𝙚: $(uname -m)
⚙️ 𝙁𝙞𝙧𝙢𝙬𝙖𝙧𝙚: $(cat /etc/openwrt_release | grep DISTRIB_DESCRIPTION | cut -d "'" -f 2 | tr -d '\0')
🎯 𝙋𝙡𝙖𝙩𝙛𝙤𝙧𝙢: $(cat /etc/openwrt_release | grep DISTRIB_TARGET | cut -d "'" -f 2 | tr -d '\0')
🐧 𝙆𝙚𝙧𝙣𝙚𝙡: $(uname -r)
⏰ 𝘿𝙖𝙩𝙚: $(date +"%d %b %Y | %I:%M %p")
⏳ 𝙐𝙥𝙩𝙞𝙢𝙚: $(uptime | awk '{print $3,$4}' | sed 's/,.*//')
❄️ 𝙏𝙚𝙢𝙥: $(awk '{printf "%.2f°C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp)
📈 𝙇𝙤𝙖𝙙 𝘼𝙫𝙚𝙧𝙖𝙜𝙚: $(awk '{printf "%.0f%%", $1 * 100}' /proc/loadavg)
💡 𝘾𝙋𝙐 𝙐𝙨𝙖𝙜𝙚: $(mpstat 1 1 | tail -n 1 | awk '{printf "%.2f%%", 100 - $NF}')

➤ 𝘾𝙝𝙚𝙘𝙠𝙚𝙙 𝙗𝙮 𝙀𝙙𝙮 𝘿𝙚𝙫𝙚𝙡𝙤𝙥𝙚𝙧 🤖
"

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/edy.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto