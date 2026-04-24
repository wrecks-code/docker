#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean

if [ -f /var/run/reboot-required ]; then
  reboot
fi
