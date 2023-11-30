#!/bin/bash

# Asosiasi antara judul dan URL
declare -A SCRIPTS
SCRIPTS["menu"]="https://tgbotwrt.titit.tech/menu.sh"
SCRIPTS["system"]="https://tgbotwrt.titit.tech/system.sh"
SCRIPTS["speedtest"]="https://tgbotwrt.titit.tech/speedtest.sh"
SCRIPTS["ping"]="https://tgbotwrt.titit.tech/ping.sh"
SCRIPTS["restart"]="https://tgbotwrt.titit.tech/restart.sh"
SCRIPTS["reboot"]="https://tgbotwrt.titit.tech/reboot.sh"
SCRIPTS["shutdown"]="https://tgbotwrt.titit.tech/shutdown.sh"
SCRIPTS["ocstart"]="https://tgbotwrt.titit.tech/ocstart.sh"
SCRIPTS["ocrestart"]="https://tgbotwrt.titit.tech/ocrestart.sh"
SCRIPTS["ocstop"]="https://tgbotwrt.titit.tech/ocstop.sh"
SCRIPTS["clear"]="https://tgbotwrt.titit.tech/clear.sh"
SCRIPTS["vnstat"]="https://tgbotwrt.titit.tech/vnstat.sh"
SCRIPTS["vnstat-d"]="https://tgbotwrt.titit.tech/vnstat-d.sh"
SCRIPTS["vnstat-m"]="https://tgbotwrt.titit.tech/vnstat-m.sh"
SCRIPTS["vnstat-y"]="https://tgbotwrt.titit.tech/vnstat-y.sh"
SCRIPTS["updater"]="https://tgbotwrt.titit.tech/updater.sh"
SCRIPTS["stop"]="https://tgbotwrt.titit.tech/stop.sh"
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
