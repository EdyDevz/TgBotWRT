import telepot
import subprocess
import time
import threading
import os
import requests
import hashlib
import datetime
import random

# Membaca token dan chat ID admin dari berkas token.txt
with open('/root/TgBotWRT/AUTH', 'r') as token_file:
    lines = token_file.readlines()
    if len(lines) >= 2:
        TOKEN = lines[0].strip()
        USER_ID = int(lines[1].strip())
    else:
        print("Berkas token harus memiliki setidaknya 2 baris (token dan chat ID admin).")
        exit()

# Daftar chat ID admin
admins = set([USER_ID])

# Lokasi file penanda (semaphore) untuk berhenti
STOP_BOT = '/root/TgBotWRT/stop.sh'

# Lokasi file cmd
CMD_FILE_PATH = '/root/TgBotWRT/cmd'

# URL untuk mengambil menu dari Folder /root
MENU_FILE_PATH = '/root/TgBotWRT/menu'

# Waktu interval untuk memeriksa perubahan cmd (dalam detik)
RELOAD_INTERVAL = 600  # Ini akan memeriksa setiap 10 menit

# Hash md5 cmd saat ini
current_cmd_file_hash = None

# Variabel global untuk waktu mulai bot
bot_start_time = None

# Daftar stiker untuk digunakan saat perintah salah
sticker_list = [
    "CAACAgUAAxkBAAEW4-xlIUDJVE25oao5Rtw0fIJ2-uOrMAAC7QkAAuBF8FQII1g3etFjfjAE",
"CAACAgUAAxkBAAEW2ENlHTsiS2DPTkMFXB-F1s9kzq3kcwACcAsAAoxv6FQ95_qSd-r-GzA",
"CAACAgUAAxkBAAEW2HllHUEVMHKty_SVDxwDOAABAROMf4cAAjcRAAKYG6FUR_jkhKs1gHMwBA",
"CAACAgUAAxkBAAEW2I5lHUVOsAZBbWUoVnjEi1X94IofvwAC8QEAA4oRVoiCpxSZ_iw0MAQ",
"CAACAgUAAxkBAAEW599lIzk6uAIZAbFVF7DfIQ584J0RrwACTggAAgEXGFbh6gL3kBr3QzAE",
"CAACAgUAAxkBAAEW5-FlIznKEFp2_agAAVT_zSrwxMOREl4AAsEBAAL4iaUfQ6uHMvXhR_IwBA",
"CAACAgUAAxkBAAEW5-NlIznglNx15YZr4BYzmIAJQDM2rQACJwwAAjDMQFVe0rz7ubar9jAE",
"CAACAgUAAxkBAAEW5-VlIzoUokGQAzzKgaXibYYaxds_OQACqQEAAviJpR9t8d29tl3EvTAE",
"CAACAgUAAxkBAAEW5-dlIzojifU2dGlFkSqlHmwe1PIq6AACqwEAAviJpR8qBRTatkgtuTAE",
"CAACAgUAAxkBAAEW5-llIzpHcwS74U4Cn6LI6XaOCm22AAMFAgAC-ImlH_2J-IyC0oQMMAQ",
"CAACAgUAAxkBAAEW5-tlIzpZtEGGyDBcW2Ol8X5CZoslFgAC1AQAAiV1YVUiWMi0oPW5nTAE",
"CAACAgUAAxkBAAEW5-1lIzqQg3Gi1qymfxj4FEXHljKFmAACSQUAAqyDKVdaiQY72PXw1zAE",
"CAACAgUAAxkBAAEW5-9lIzq41AfxEYeHH1H8rcbB0rpkMwAC-QQAAh6ywVTlF4EYQjEjpzAE",
"CAACAgUAAxkBAAEW6AFlI2wtA6GJNAqlN7HLtRxQNQwXBAACggQAAi_2WFe4sTVdrI7XgzAE",
"CAACAgUAAxkBAAEW6ANlI2yBZlOgxjLtbhMsXE6LUreG4gACcAMAAmx5qFRIrfOHelodnjAE",
"CAACAgUAAxkBAAEW6AVlI2yYrIbDU5XXZVRDhBPz1L6xHwAC3gMAAloUaVcK_MsCmtGJETAE",
"CAACAgUAAxkBAAEW6AllI2ypDf-U5YE6979p_xHB04P9VAACegMAAhrOqVVRL-nU6UlwszAE",
"CAACAgUAAxkBAAEW0SllGsZ3AAEb2gYvvMi7YK5tsU6EKbgAAsEBAAL4iaUfQ6uHMvXhR_IwBA",
"CAACAgUAAxkBAAEW6AtlI20HYlBodqEubzSOWkZYwUWFRwAC6AMAApBsYVU48uecLZi06DAE",
"CAACAgUAAxkBAAEW6A1lI20gWc1bs2jEY8DZpcanpbgUDAACCgQAAhXj2VVcBETriJVYmjAE",
"CAACAgUAAxkBAAEW6A9lI20zVsazNNoAAVPFHQEjEn1lgGgAAt4CAAJ7OOBV6IyTs9XfKU8wBA",
"CAACAgUAAxkBAAEW6BFlI21LnAZPoRtv9KCwMyWplqcttAAC9gMAAnAusFf0-6bvVAABXggwBA",
"CAACAgUAAxkBAAEW6BNlI21yBzHJh8Suc8dq5hPBL9tKLwACjAYAAiAMwFTRAqncN4ITZTAE",
"CAACAgUAAxkBAAEW6BVlI22VvLyl0EO-VKi6K2yAflp_iwACmgEAAviJpR-TowPqDtMuqjAE",
"CAACAgUAAxkBAAEW6BdlI22jqGVdVFcDsTT2vvm6CnM4IQACmwEAAviJpR_bPgF4D9RU1DAE",
"CAACAgUAAxkBAAEW6BllI224Qd35DojLsvUFh1AWeBwsfgACrAEAAviJpR9gdnzDCCIrzTAE",
"CAACAgUAAxkBAAEW6BtlI22_nmpZ0N9QMIqnpgpW3eBmfQACuAEAAviJpR9RTXVXQuq6kDAE",
"CAACAgUAAxkBAAEW6B1lI23hyQGwhmR4ZTMy5-lYtVgy4AACvgEAAviJpR_MNaUi40x3-zAE",
"CAACAgUAAxkBAAEW6CFlI24PwyS-_x73S6sNlQTyBQanxgAC5AEAAviJpR-trHE9Mr5JGjAE",
"CAACAgUAAxkBAAEW6B9lI239xVfAQBW8pOUDfJuSyIj2ewACwgEAAviJpR8-W8f2aFTMkDAE",
"CAACAgUAAxkBAAEW6CNlI25I1lfZL_JeFMPrfs-TKPh01gACLwQAAsIFwVUiRu7l4khu1zAE",
"CAACAgUAAxkBAAEW6CdlI26PE5TGJaDZI_AUw3zkywVhGwAC7AADhT2oVYccpyKAQX5yMAQ",
"CAACAgUAAxkBAAEW6CllI26erTTbUi4Z31SwuKE4TT3yHQACQQEAArJ7oFWHrZPOTbbSzTAE",
"CAACAgUAAxkBAAEW6IllI4pH3Ke0pzXqtVbsGyaEhR9qZAACzgoAAjUCOFWBkcnyvUz_0jAE",
"CAACAgUAAxkBAAEW6ItlI4pfJHU4r2wSmVwSt0CjoQY0fAACFgwAAq1rSFW08EAQA161HzAE",
"CAACAgUAAxkBAAEW6JFlI4p73zwQsPPiQ7r9PXG1sy67HQAChQoAAq-DwFb0a4rNnWkCjjAE",
"CAACAgUAAxkBAAEW6JNlI4qLX0FhxTd7OJf17PQrD0giVQACvQkAAkQIwVaCd3NacnFBpzAE",
"CAACAgUAAxkBAAEW6JVlI4qXXtsWNEDO4nnw8syxxVRdMwAC4goAAmnvwFaXoFDNj4z7kDAE",
"CAACAgUAAxkBAAEW6JdlI4q6MxTrLMzHE5DTbecPjVL8LwACJQsAAtwhyVa6eIPK7y1OIjAE",
"CAACAgUAAxkBAAEW6JllI4rCPERT8b_eGtZLp9tbDUhUqAAC9wkAAmf-0Vay5CfjIeg7STAE",
"CAACAgUAAxkBAAEW6KplI5Lzw5VMVLYyKArB0iVDhOtH_QACRgwAAqPlSFX5CocCwGM0yTAE",
"CAACAgUAAxkBAAEW6K5lI5NKBb7wy5jZ2YvbAtbw2NwBywAChQoAAq-DwFb0a4rNnWkCjjAE",
"CAACAgUAAxkBAAEW6LBlI5Nsgc64gdKj1b_wGE0pFYj7MQACMQsAArzHwVZozUTUoFbVlDAE",
"CAACAgUAAxkBAAEW6LJlI5OqQQl6_SWZTDJOfh5D9eOIEgACGgMAAvI26VSOwLLLjYCI4jAE",
"CAACAgUAAxkBAAEW6LRlI5O05sVp5q_RbRM0qD0Fw7eohwACvgMAAiUD4FQpt8xI_6X8-jAE",
"CAACAgUAAxkBAAEW6LZlI5Pj8dABPOko0w24CqKFnIifpQAClwUAAjV90VXAWe6SFk_fTDAE",
"CAACAgUAAxkBAAEW6LplI5QI-6ypbrH24FcH3eRqQlYG9gAC7gQAAm02EVZb6arCUH6tzDAE",
"CAACAgUAAxkBAAEW6LxlI5QY1xZrdPMdtmaYHuLj2zYzoAAC3QQAAq2aEFbeyOV6ETr3oTAE",
"CAACAgUAAxkBAAEW6L5lI5QwQLaNFR6tGkLIjmCoqSzQEQACJAUAAiSVEVYgb98SCXsTbjAE",
"CAACAgUAAxkBAAEW6MBlI5RJkXScC7M1YRemqiaev1qfrgACYgQAAhjeEVYkGSdiLmvXMzAE",
"CAACAgUAAxkBAAEW6MRlI5RhIjCjbbimyx2H88NAjyLCBgACoQcAAtcoIFXjQ96xfax1yjAE",
"CAACAgUAAxkBAAEW6MhlI5SIGYziKRTNf4_fbMnFyP5sfgAChgQAAtNwGFY1Ki7kWk_gkjAE",
"CAACAgUAAxkBAAEW6MplI5SdF1Z40RkuhPEMVWWXhpezegACngUAAk07EFYulqNTOIsFazAE",
"CAACAgUAAxkBAAEW6M5lI5S_fwWKK0hWb0RDKrE3I4AbEwAChgEAAviJpR_8Cag8nT4mVDAE",
"CAACAgUAAxkBAAEW6NBlI5TmSL0F28_KCjKpa3fB4os9AwACywEAAviJpR-QthEUulRkKDAE",
"CAACAgUAAxkBAAEW6NRlI5UZ_gh9AAE2h2gPJjg72M7J9RkAAjwFAAJg5wFUQaMpwyK7X_gwBA",
"CAACAgUAAxkBAAEW6NZlI5UoYOb_xwuIooudCr3snujhygACeAQAApX6gFTa5hH6e2Yu1DAE",
"CAACAgUAAxkBAAEW6N1lI5VZ9wP1osXN-hShq-I0--Gg4gACNAUAAgH5UFZgW-avSdTA1zAE",
"CAACAgUAAxkBAAEW6OFlI5V6vC_z_JKGK0qbeH2kvY3s0AACywQAApQVmVXWpEgMc9-zizAE",
"CAACAgUAAxkBAAEW6ONlI5WJYaENjBMoKBAe6ljcTQo1JwACowQAAsyx8VURv2P5L-XVtDAE",
"CAACAgUAAxkBAAEW6OVlI5WhmoyDCG41HCQmk3kUsxIUsAACJgcAAozD8VUybNuR84NvfDAE",
"CAACAgUAAxkBAAEW6OllI5XF-oMgpAABqB0EEJ0E_r4txOsAAocEAAKxrPlV6Tunxz3Vp8kwBA",
"CAACAgUAAxkBAAEW6OdlI5WvPS6gf3a-7WUPmX2MHveoygACwAQAAr8d8FXk_GoM0bJFITAE",
"CAACAgUAAxkBAAEW6OtlI5XatMO5uimxxLQ5rT5xc06K9AACZAUAAntCMVZQ6i2NdvEFlDAE",
"CAACAgUAAxkBAAEW6O1lI5XlPC6GQRDP_EdxehMDkxzeIgACHQUAAqT7KVfqwfMUfCXaTzAE",
"CAACAgUAAxkBAAEW6O9lI5XxjWCb6b53Bowkc-V0wfTt_wACnwUAAjTqKFfN4aJMO-IP0jAE",
"CAACAgUAAxkBAAEW6PFlI5YN1t0Yq_qBZqC22tzyqfM1xwACNgYAAqIQOVRgSXeikMmfzjAE",
"CAACAgUAAxkBAAEW6PNlI5YzWaU5HDx4fUZAYdU671VnNwACBQQAAkHqkVTNg8QHhBeUpzAE",
"CAACAgUAAxkBAAEW6PVlI5ZBSBW5T3WxAXkENAEgC2P49gACZwIAAoItGVQtri_aWbSUyDAE",
"CAACAgUAAxkBAAEW6N9lI5VuCJlVasen8Qsdsr8P65nWXwACqAUAAgqOqFQz64P6hyiSqDAE",
"CAACAgUAAxkBAAEW6NtlI5U52e7DSOwx7-k_c8avjmyJ2QACLwMAAhm5KVX5SB4NrDwojjAE",
"CAACAgUAAxkBAAEW6MxlI5SpaYOYd_DT8RoAAa3DQKcsFqEAAtgFAALOuRhWS32EkIwS8LcwBA",
]

# Set untuk melacak stiker yang sudah dikirim
sent_stickers = set()

# Fungsi untuk menjalankan perintah di terminal tanpa menampilkan output
def run_command(command):
    try:
        subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError as e:
        return False

# Fungsi untuk membaca berkas teks alias
def load_aliases(file_path):
    aliases = {}
    try:
        with open(file_path, 'r') as file:
            for line in file:
                parts = line.strip().split(':')
                if len(parts) == 2:
                    alias, cmd = parts
                    aliases[alias.strip()] = cmd.strip()
    except Exception as e:
        print(f"Error loading aliases: {str(e)}")
    return aliases

# Fungsi untuk menghapus pesan setelah waktu tertentu
def delete_message_after(USER_ID, message_id, seconds):
    time.sleep(seconds)
    bot.deleteMessage((USER_ID, message_id))

# Fungsi untuk mengirim pesan menu
def send_menu(chat_id):
    with open(MENU_FILE_PATH, 'r') as menu_file:
        menu_text = menu_file.read()
        bot.sendMessage(chat_id, menu_text, parse_mode="Markdown")

# Fungsi untuk mengirim stiker jika perintah salah
def send_random_sticker(USER_ID):
    # Pilih stiker acak yang belum pernah dikirim
    while True:
        sticker_to_send = random.choice(sticker_list)
        if sticker_to_send not in sent_stickers:
            sent_stickers.add(sticker_to_send)
            break

    bot.sendSticker(USER_ID, sticker_to_send)

# Fungsi untuk menangani perintah /menu
def handle_start(msg):
    USER_ID = msg['chat']['id']
    send_menu(USER_ID)

# Fungsi untuk menangani pesan yang diterima dari bot Telegram
def handle(msg):
    USER_ID = msg['chat']['id']
    user_id = msg['from']['id']

    # Memeriksa apakah pesan memiliki teks
    if 'text' in msg:
        command = msg['text']

        if command == '/menu':
            handle_start(msg)
        elif user_id in admins:
            if command.startswith('/cmd'):
                parts = command.split(' ', 1)
                if len(parts) == 2:
                    cmd_to_run = parts[1]
                    # Mengirim pesan "Please wait" saat perintah dikenali
                    wait_message = bot.sendMessage(USER_ID, "Please wait...")
                    # Menjalankan perintah yang diberikan
                    if run_command(cmd_to_run):
                        # Jika perintah berhasil dijalankan, hapus pesan "Please wait..."
                        bot.deleteMessage((USER_ID, wait_message['message_id']))
                    else:
                        # Jika perintah gagal, beri pesan "Perintah salah atau gagal dijalankan."
                        send_random_sticker(USER_ID)
                        bot.sendMessage(USER_ID, "Perintah salah atau gagal dijalankan.")
                        # Hapus pesan "Perintah salah atau gagal dijalankan." setelah 5 detik
                        t = threading.Thread(target=delete_message_after, args=(USER_ID, msg['message_id'], 5))
                        t.start()
                else:
                    send_random_sticker(USER_ID)
                    bot.sendMessage(USER_ID, "The /cmd command format is incorrect.  Use: /cmd <command>")
            else:
                if command in aliases:
                    # Mengirim pesan "Please wait" saat perintah dikenali
                    wait_message = bot.sendMessage(USER_ID, "Please wait...")
                    # Menjalankan perintah sesuai dengan alias yang ditemukan
                    if run_command(aliases[command]):
                        # Jika perintah berhasil dijalankan, hapus pesan "Please wait..."
                        bot.deleteMessage((USER_ID, wait_message['message_id']))
                    else:
                        # Jika perintah gagal, beri pesan "Wrong Command, Use /menu To Check"
                        send_random_sticker(USER_ID)
                        bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")
                        # Hapus pesan "Wrong Command, Use /menu To Check" setelah 5 detik
                        t = threading.Thread(target=delete_message_after, args=(USER_ID, msg['message_id'], 5))
                        t.start()
                else:
                    # Menampilkan pesan "Wrong Command, Use /menu To Check"
                    send_random_sticker(USER_ID)
                    bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")
        else:
            send_random_sticker(USER_ID)
            bot.sendMessage(USER_ID, "Anda bukan golongan yang diizinkan.")
    else:
        send_random_sticker(USER_ID)
        bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")

# Fungsi untuk memeriksa koneksi internet
def check_internet_connection():
    try:
        response = requests.get('https://www.google.com', timeout=10)
        return True
    except (requests.ConnectionError, requests.Timeout):
        return False

# Fungsi untuk memuat ulang file cmd jika berubah
def reload_cmd_file():
    global current_cmd_file_hash
    new_cmd_file_hash = get_file_md5_hash(CMD_FILE_PATH)
    if new_cmd_file_hash != current_cmd_file_hash:
        current_cmd_file_hash = new_cmd_file_hash
        aliases = load_aliases(CMD_FILE_PATH)

# Fungsi untuk menghitung hash MD5 dari sebuah berkas
def get_file_md5_hash(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as file:
        for chunk in iter(lambda: file.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

# Inisialisasi bot Telegram
bot = telepot.Bot(TOKEN)
bot.message_loop(handle)

# Mendapatkan daftar alias dari berkas teks
aliases = load_aliases(CMD_FILE_PATH)
current_cmd_file_hash = get_file_md5_hash(CMD_FILE_PATH)

# Set waktu mulai bot saat ini
bot_start_time = datetime.datetime.now()

print('Bot sedang berjalan. Untuk berhenti, gunakan perintah /stop')

# Biarkan bot berjalan terus selama file penanda tidak ada
while not os.path.exists(STOP_BOT):
    try:
        # Cek koneksi internet
        if check_internet_connection():
            # Tempatkan logika bot Anda di sini
            pass
        else:
            print('Tidak ada koneksi internet. Menunggu...')
            time.sleep(60)  # Menunggu 1 menit sebelum mencoba lagi
        # Cek dan muat ulang cmd jika perlu
        if time.time() % RELOAD_INTERVAL == 0:
            reload_cmd_file()
    except Exception as e:
        print(f"Terjadi kesalahan: {str(e)}")
        # Tambahkan logika untuk menunggu sebelum mencoba lagi
        time.sleep(60)  # Menunggu 1 menit sebelum mencoba lagi

# Bot berhenti jika file penanda ada
print('Bot berhenti.')