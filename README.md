### TELEGRAM BOT FOR OPENWRT

* [**OWNER**](https://t.me/kangbacox)

##### TUTORIAL
* [**VIEW ON YOUTUBE**](https://youtu.be/4zhOv0Ke_Vs?si=B2qRDOyYifILzSur)


### NOTE❗
***TUTORIAL UDAH LENGKAP NJENG! GAUSAH BANYAK TANYA! BACA SAMPE KELAR BIAR PAHAM!!!***


### REQUIREMENTS

* `git`
* `git-http`
* `python3`
* `python3-pip`
* `jq`
* `sysstat`
* `telepot`
* `nano`
* `tmux`
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
opkg install tmux
```

```
pip3 install telepot requests python-telegram-bot
```

```
opkg list-installed | grep python3 && pip3 list
```

##### CLONE REPO

```
git clone -b SCRIPT https://github.com/EdyDevz/TgBotWRT
```

##### MOVE ALL SCRIPT

```
mv /root/TgBotWRT/edy /etc/init.d/ && mv /root/TgBotWRT/edy.py /usr/bin/ && chmod +x /usr/bin/edy.py && chmod +x /etc/init.d/edy && chmod +x /root/TgBotWRT/*
```
*
*
##### BOT AUTO INSTALLER 🚀

```
cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/installer.sh && bash install
```
*
*
##### EDIT AUTH ADMIN & BOT
```
nano /root/TgBotWRT/AUTH
```
*
*
##### AUTO RESTART BOT (OPSIONAL)
**COPAS TO** `SCHEDULED TASKS`
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
tmux
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
cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/uninstaller.sh && bash install
```

*
*


##### SPEEDTEST INSTALLER 🚀

```
cd /tmp && curl -sLko install https://raw.githubusercontent.com/EdyDevz/TgBotWRT/main/speedtest-installer.sh && bash install
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
* **JEKI HYTAM** ***( SCRIPT MAKER )***
* **THANKS FOR ALL MEMBER IGH & TESTER**

##### READ THIS ❗
This is a script created and compiled by ***Leluhur Edy.*** use sensibly, do not edit or reupload to another groups. I can ***leak your data*** if you edit my script or sell it to other people.  remember that!! If there are any additions/confusion, you can pm me on Telegram!!!