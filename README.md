### TELEGRAM BOT FOR OPENWRT

* [**OWNER**](https://t.me/EdyDevz)

##### TUTORIAL
* [**VIEW TUTORIAL**](https://nicecloud.tech/0:/TUTORIAL%20INSTALL%20TGBOTWRT.mp4?a=view)
* [**DOWNLOAD VIDEO**](https://nicecloud.tech/0:/TUTORIAL%20INSTALL%20TGBOTWRT.mp4)
* [**VIEW ON TELEGRAM**](https://t.me/TrashLeech/48)

### NOTE❗
***TUTORIAL UDAH LENGKAP NJENG! GAUSAH BANYAK TANYA! BACA SAMPE KELAR BIAR PAHAM!!!***

##### MANUAL INSTALL 😎
```
opkg update
```

```
opkg install git
```

```
opkg install git-http
```

```
opkg install python3
```

```
opkg install python3-pip
```

```
opkg install jq
```

```
opkg install sysstat
```

```
pip3 install telepot requests python-telegram-bot
```

```
opkg list-installed | grep python3 && pip3 list
```
##### CLONE REPO

```
git clone https://github.com/EdyDevz/TgBotWRT
```
##### MOVE ALL PACKAGE

```
mv /root/TgBotWRT/edy /etc/init.d/ && mv /root/TgBotWRT/edy.py /usr/bin/ && chmod +x /usr/bin/edy.py && chmod +x /etc/init.d/edy && rm -rf /root/TgBotWRT/plugins
```
*
*
##### AUTO INSTALLER 🚀

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/installer.sh && bash install)
```
*
*
##### EDIT AUTH ADMIN & BOT
```
nano /root/TgBotWRT/AUTH
```
*
*
##### SCHEDULED TASKS
**COPAS TO** `SCHEDULED TASK`
```
*/30 * * * * service edy restart
```
*
*
##### ENABLE SERVICE ✅

```
service edy enable
```

##### START BOT 🚀

```
service edy start
```

##### RESTART BOT ♻️

```
service edy restart
```

##### STOP BOT ❌

```
service edy stop
```
*
*

##### UNINSTALLER BOT 🗑️

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/master/plugins/tools/uninstaller.sh && bash install)
```

*
*

## Commands

**Use** `/menu` **For check CMD 📖**

 * **CMD LIST:**
 * `/system` ***- View System Information 🖥️***
 * `/speedtest` ***- Internet Speed Analysis ⚡***
 * `/vnstat` ***- Vnstat Monitor 🚀***
 * `/ping` ***- Ping Server ⚙️***
 * `/clear` ***- Cache Memory Purge 🗑️***
 * `/restart` ***- Restart BOT 🤖***
 * `/reboot` ***- Reboot STB ♻️***
 * `/shutdown` ***- Shutdown Server 📴***
 * `/ocr` ***- Restart OpenClash ♨️***
 * `/ocs` ***- Stop OpenClash ❌***

## CREDIT

* **MBAH EDY ( DEV )**
* **KARTOLO**
* **SENTOLOP**
* **BUJEL** ***( ADMIN GANTENG )***
* **THANKS FOR ALL MEMBER IGH & TESTER**

##### READ THIS ❗
This is a script created and compiled by ***Leluhur Edy.*** use sensibly, do not edit or reupload to another groups. I can ***leak your data*** if you edit my script or sell it to other people.  remember that!! If there are any additions/confusion, you can pm me on Telegram!!!
