#!/bin/bash

if [[ $ENABLE_PRIVOXY == "yes" ]]; then
     # run script to check ip is valid for tunnel device
     source /home/nobody/checkip.sh
     echo "[info] Configuring Privoxy..."
     [[ -d /config/privoxy ]] || mkdir /config/privoxy
     [[ -f /config/privoxy/config ]] || cp -R /etc/privoxy/ /config/
     LAN_IP=$(hostname -i)
     sed -i -e "s/confdir \/etc\/privoxy/confdir \/config\/privoxy/g" /config/privoxy/config
     sed -i -e "s/logdir \/var\/log\/privoxy/logdir \/config\/privoxy/g" /config/privoxy/config
     sed -i -e "s/listen-address.*/listen-address  $LAN_IP:8118/g" /config/privoxy/config
     echo "[info] All checks complete, starting Privoxy..."
     /usr/bin/privoxy --no-daemon /config/privoxy/config
else
     echo "[info] Privoxy set to disabled"
fi
