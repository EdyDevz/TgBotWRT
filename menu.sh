#!/bin/bash

# Asosiasi antara judul dan URL
declare -A SCRIPTS
SCRIPTS["system"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/system.sh"
SCRIPTS["speedtest"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/speedtest.sh"
SCRIPTS["ping"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/ping.sh"
SCRIPTS["vnstat"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/vnstat.sh"
SCRIPTS["restart"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/restart.sh"
SCRIPTS["reboot"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/reboot.sh"
SCRIPTS["shutdown"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/shutdown.sh"
SCRIPTS["ocr"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/ocr.sh"
SCRIPTS["ocs"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/ocs.sh"
SCRIPTS["clear"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/menu/clear.sh"
SCRIPTS["license"]="https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/license.sh"
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
