#!/bin/sh

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

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
╔═══𝙏𝙀𝙎𝙏 𝘽𝘼𝙉𝘿𝙒𝙄𝙏𝙃═════════════╗

☞     /100MB - 𝟭𝟬𝟬𝗠𝗕 𝗧𝗘𝗦𝗧
☞     /1GB - 𝟭𝗚𝗕 𝗧𝗘𝗦𝗧
☞     /5GB - 𝟱𝗚𝗕 𝗧𝗘𝗦𝗧
☞     /10GB - 𝟭𝟬𝗚𝗕 𝗧𝗘𝗦𝗧

╚═══════════════════════════╝
"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$ID" -d "text=$MSG"
