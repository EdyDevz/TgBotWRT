#!/bin/bash

opkg update && wget --no-check-certificate https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-linux-aarch64.tgz -O /tmp/speedtest.tgz && tar -xzvf /tmp/speedtest.tgz -C /usr/bin/ && chmod +x /usr/bin/speedtest && clear && speedtest
