#!/bin/bash
set -e

# define pacman packages
pacman_packages="kmod openvpn privoxy"

# install pre-reqs
pacman -S --needed $pacman_packages --noconfirm

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
