### TELEGRAM BOT FOR OPENWRT

* [**OWNER**](https://t.me/EdyDevz)

##### TUTORIAL
* [**VIEW ON YOUTUBE**](https://youtu.be/4zhOv0Ke_Vs?si=B2qRDOyYifILzSur)


### NOTE❗
***TUTORIAL UDAH LENGKAP NJENG! GAUSAH BANYAK TANYA! BACA SAMPE KELAR BIAR PAHAM!!!***

* **BOT ONLINE = RUNNING SCRIPT VIA ONLINE SCRIPT**
* **BOT OFFLINE = RUNNING SCRIPT VIA OFFLINE SCRIPT**

**SESUAIKAN DENGAN KEBUTUHAN**


### REQUIREMENTS

* `git`
* `git-http`
* `python3`
* `python3-pip`
* `jq`
* `sysstat`
* `telepot`
* `nano`
* `python-telegram-bot`
* `ookla-speedtest-1.1.1`



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
opkg install nano
```

```
pip3 install telepot requests python-telegram-bot
```

```
opkg list-installed | grep python3 && pip3 list
```
##### CLONE REPO


**ONLINE SCRIPT**
```
git clone -b ONLINE https://github.com/EdyDevz/TgBotWRT
```

**OFFLINE SCRIPT**
```
git clone -b OFFLINE https://github.com/EdyDevz/TgBotWRT
```

##### MOVE ALL PACKAGE ONLINE SCRIPT

```
mv /root/TgBotWRT/edy /etc/init.d/ && mv /root/TgBotWRT/edy.py /usr/bin/ && chmod +x /usr/bin/edy.py && chmod +x /etc/init.d/edy && chmod +x /root/TgBotWRT/*
```

##### MOVE ALL PACKAGE OFFLINE SCRIPT

```
mv /root/TgBotWRT/edy /etc/init.d/ && mv /root/TgBotWRT/edy.py /usr/bin/ && chmod +x /usr/bin/edy.py && chmod +x /etc/init.d/edy && chmod +x /root/TgBotWRT/* && chmod +x /root/TgBotWRT/TOOLS/*
```
*
*
##### BOT ONLINE AUTO INSTALLER 🚀

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/online-installer.sh && bash install)
```
*
*
##### BOT OFFLINE AUTO INSTALLER 🚀
```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/offline-installer.sh && bash install)
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
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/uninstaller.sh && bash install)
```

*
*


##### SPEEDTEST INSTALLER 🚀

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/speedtest-installer.sh && bash install)
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
 * `/reboot` ***- Reboot Server ♻️***
 * `/shutdown` ***- Shutdown Server 📴***
 * `/ocstart` ***- Start OpenClash 🟢***
 * `/ocrestart` ***- Restart OpenClash 🟡***
 * `/ocstop` ***- Stop OpenClash 🔴***
 * `/stop` ***- Stop BOT ❌***

## CREDIT

* **MBAH EDY ( DEVELOPER )**
* **BUJEL** ***( ADMIN GANTENG )***
* **KARTOLO** ***( SCRIPT MAKER )***
* **THANKS FOR ALL MEMBER IGH & TESTER**

##### READ THIS ❗
This is a script created and compiled by ***Leluhur Edy.*** use sensibly, do not edit or reupload to another groups. I can ***leak your data*** if you edit my script or sell it to other people.  remember that!! If there are any additions/confusion, you can pm me on Telegram!!!
