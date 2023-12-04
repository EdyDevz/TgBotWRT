#!/bin/bash

# Asosiasi antara judul dan URL
declare -A SCRIPTS
SCRIPTS["system"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/system.sh"
SCRIPTS["speedtest"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/speedtest.sh"
SCRIPTS["ping"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/ping.sh"
SCRIPTS["restart"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/restart.sh"
SCRIPTS["reboot"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/reboot.sh"
SCRIPTS["shutdown"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/shutdown.sh"
SCRIPTS["ocstart"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/ocstart.sh"
SCRIPTS["ocrestart"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/ocrestart.sh"
SCRIPTS["ocstop"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/ocstop.sh"
SCRIPTS["clear"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/clear.sh"
SCRIPTS["vnstat"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/vnstat.sh"
SCRIPTS["vnstat-d"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/vnstat-d.sh"
SCRIPTS["vnstat-m"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/vnstat-m.sh"
SCRIPTS["vnstat-y"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/vnstat-y.sh"
SCRIPTS["stop"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/OFFLINE/TOOLS/stop.sh"
# Tambahkan judul dan URL lain sesuai kebutuhan

# Memeriksa apakah argumen yang diberikan adalah judul yang valid
if [ "$#" -ne 1 ] || [ -z "${SCRIPTS[$1]}" ]; then
    echo "Penggunaan: bash s.sh [judul script]"
    exit 1
fi

# Mengunduh dan menjalankan skrip dari URL yang sesuai dengan judul
selected_url="${SCRIPTS[$1]}"
script=$(curl -s "$selected_url" | tr -d '\r')
bash -c "$script"
