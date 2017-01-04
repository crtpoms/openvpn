#!/bin/bash

echo "[info] Starting OpenVPN..."

# set sleep period for recheck (in secs)
sleep_period="30"

# loop and restart openvpn on process termination (foreground blocking)
while true; do
     openvpn_cli="/usr/bin/openvpn --cd /config/openvpn --config "${VPN_CONFIG}" --remote "${VPN_REMOTE}" "${VPN_PORT}" --proto "${VPN_PROTOCOL}" --reneg-sec 0 --mute-replay-warnings --auth-nocache --keepalive 10 60 --auth-user-pass credentials.conf --disable-occ"
     # run openvpn to create tunnel
     eval "${openvpn_cli}"
     echo "[warn] VPN connection terminated"
     # ensure openvpn process is dead
     /usr/bin/pkill openvpn
     echo "[warn] Restarting VPN connection in ${sleep_period} secs"
     sleep "${sleep_period}"s
done
