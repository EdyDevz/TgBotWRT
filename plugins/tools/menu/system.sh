#!/bin/sh

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

# Function to send a message to the Telegram bot
send_telegram_message() {
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$1" \
        -d "parse_mode=Markdown"
}

# Generate the system status report
SYSTEM_REPORT="
╔═════▷ 𝙀𝘿𝙔 𝙈𝙊𝙉𝙄𝙏𝙊𝙍𝙄𝙉𝙂 𝘽𝙊𝙏 🚀 ◁
║
╠ 𝙎𝙮𝙨𝙩𝙚𝙢 𝙄𝙣𝙛𝙤𝙧𝙢𝙖𝙩𝙞𝙤𝙣:
╠ 🏠 𝙃𝙤𝙨𝙩𝙣𝙖𝙢𝙚: $(uci get system.@system[0].hostname | tr -d '\0')
╠ 💻 𝙈𝙤𝙙𝙚𝙡: $(cat /proc/device-tree/model | tr -d '\0')
╠ 🔶 𝘼𝙧𝙘𝙝𝙞𝙩𝙚𝙘𝙩𝙪𝙧𝙚: $(uname -m)
╠ ⚙️ 𝙁𝙞𝙧𝙢𝙬𝙖𝙧𝙚: $(cat /etc/openwrt_release | grep DISTRIB_DESCRIPTION | cut -d "'" -f 2 | tr -d '\0')
╠ 🎯 𝙋𝙡𝙖𝙩𝙛𝙤𝙧𝙢: $(cat /etc/openwrt_release | grep DISTRIB_TARGET | cut -d "'" -f 2 | tr -d '\0')
╠ 🐧 𝙆𝙚𝙧𝙣𝙚𝙡: $(uname -r)
╠ ⏰ 𝘿𝙖𝙩𝙚: $(date +"%d %b %Y | %I:%M %p")
╠ ⏳ 𝙐𝙥𝙩𝙞𝙢𝙚: $(uptime | awk '{print $3,$4}' | sed 's/,.*//')
╠ ❄️ 𝙏𝙚𝙢𝙥: $(awk '{printf "%.2f°C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp)
╠ 📈 𝙇𝙤𝙖𝙙 𝘼𝙫𝙚𝙧𝙖𝙜𝙚: $(awk '{printf "%.0f%%", $1 * 100}' /proc/loadavg)
╚ 💡 𝘾𝙋𝙐 𝙐𝙨𝙖𝙜𝙚: $(mpstat 1 1 | tail -n 1 | awk '{printf "%.2f%%", 100 - $NF}')
"

# Send the system report to the Telegram bot
send_telegram_message "$SYSTEM_REPORT"
